#!/bin/sh
# fugas.sh — ADR-002 §4: la carta no narra su propio andamiaje.
#
# Señala frases donde el texto se dirige a su procedimiento en vez de al
# destinatario. NO es un linter de estilo: son CANDIDATOS que exigen juicio.
# Una carta que le entrega una herramienta a un lector puede señalar
# legítimamente lo que hace; eso es pedagogía, no costura. Lee antes de cortar.
#
# Sale 1 si encuentra candidatos. Un hook debe AVISAR con esto, no bloquear.
set -u
root=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
cd "$root" || exit 2

# Patrones extraídos del catálogo de fugas de ADR-002.
patrones='le concedo
se lo concedo
lo concedo
concesion previa
antes de cualquier .pero
antes del primer .pero
quien lo regatea
quien las regatea
usted se sabe
ya se sabe la lista
igual que yo
no se la voy a vender
que quede claro qué no
lo que .*no. estoy diciendo
no le voy a decir
me mojo
para que valga
nada de lo que sigue
como ya expliqué
como se vio en
según la verificación
por lo pactado
en la carta anterior
de todo el texto
terminará sin'

objetivos=$(ls sdd/cartas/*/borrador.md _posts/*.md 2>/dev/null)
[ -n "$objetivos" ] || { echo "fugas.sh: nada que revisar"; exit 0; }

fail=0
for f in $objetivos; do
  hits=$(printf '%s\n' "$patrones" | while IFS= read -r p; do
    [ -n "$p" ] && grep -n -i -E "$p" "$f" 2>/dev/null
  done)
  if [ -n "$hits" ]; then
    echo "── $f"
    printf '%s\n' "$hits" | sed 's/^/   /'
    fail=1
  fi
done

if [ "$fail" -eq 0 ]; then
  echo "fugas.sh OK"
else
  echo ""
  echo "Candidatos a fuga de andamiaje (ADR-002 §4). Aplica la prueba del"
  echo "referente a cada uno: ¿apunta al mundo, al destinatario o al autor"
  echo "-> se queda; al procedimiento que produjo la carta -> se corta."
fi
exit "$fail"
