#!/bin/sh
# post-edit.sh — aviso tras editar una carta o un post.
#
# Lo invoca un hook PostToolUse. NUNCA bloquea: 'fugas' señala candidatos que
# exigen juicio humano (ADR-002 §4), y una carta que entrega una herramienta a
# un lector puede legítimamente señalar lo que hace. El valor está en que el
# aviso llegue mientras el texto sigue caliente, no en impedir nada.
set -u
input=$(cat)
f=$(printf '%s' "$input" | jq -r '.tool_input.file_path // .tool_response.filePath // empty')
[ -n "$f" ] || exit 0

case "$f" in
  */sdd/cartas/*/borrador.md|*/_posts/*.md) ;;
  *) exit 0 ;;
esac

root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
[ -x "$root/sdd/.agents/checks/fugas.sh" ] || [ -f "$root/sdd/.agents/checks/fugas.sh" ] || exit 0

out=$(sh "$root/sdd/.agents/checks/fugas.sh" 2>&1) && exit 0

printf '%s' "$out" | jq -Rs '{
  hookSpecificOutput: {
    hookEventName: "PostToolUse",
    additionalContext: ("fugas.sh señala candidatos a andamiaje narrado (ADR-002 §4). No es un error: aplica la prueba del referente a cada uno antes de tocar nada.\n\n" + .)
  }
}'
exit 0
