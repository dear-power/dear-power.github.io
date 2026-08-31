#!/bin/sh
# pre-commit.sh — barrera dura antes de un commit.
#
# Lo invoca un hook PreToolUse del harness, pero la lógica vive aquí (ADR-003):
# cualquier CI o un git hook local puede llamarlo igual. Lee el JSON del harness
# por stdin y lo ignora: el veredicto no depende de qué comando se iba a correr,
# sino del estado del árbol.
#
# Bloquea si falla un check DURO (estado, firma). 'fugas' no bloquea nunca:
# exige juicio humano y vive en el hook de post-edición.
set -u
root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
[ -d "$root/sdd" ] || exit 0

fail=0
estado=$(sh "$root/sdd/.agents/checks/estado.sh" 2>&1) || fail=1
firma=$(sh "$root/sdd/.agents/checks/firma.sh" 2>&1) || fail=1

[ "$fail" -eq 0 ] && exit 0

printf '%s\n%s' "$estado" "$firma" | jq -Rs '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: ("Checks duros del árbol sdd en rojo — el commit dejaría el repo incoherente (ADR-001 §5, ADR-002). Arréglalo, o declara la anomalía con su motivo en el manifest.\n\n" + .)
  }
}'
exit 0
