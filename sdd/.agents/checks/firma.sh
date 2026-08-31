#!/bin/sh
# firma.sh — ADR-002, "La firma": las tres piezas son obligatorias.
#
# El layout tiene `signoff | default: site.title`, y ese default es el handle
# INGLÉS: una carta en español que omita signoff se firma "Dear Power" sin
# avisar. Este check existe por eso.
set -u
root=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
cd "$root" || exit 2
fail=0

for p in _posts/*.md; do
  [ -e "$p" ] || continue
  fm=$(awk 'NR==1&&/^---/{f=1;next} f&&/^---/{exit} f' "$p")
  cuerpo=$(awk 'NR==1&&/^---/{f=1;next} f&&/^---/{f=0;b=1;next} b' "$p")

  for campo in layout lang title signoff; do
    printf '%s\n' "$fm" | grep -q "^$campo:" || { echo "FALLO [$p] falta '$campo:' en el front matter"; fail=1; }
  done

  lang=$(printf '%s\n' "$fm" | sed -n 's/^lang:[[:space:]]*\(.*\)/\1/p' | tr -d '"' | head -1)
  signoff=$(printf '%s\n' "$fm" | sed -n 's/^signoff:[[:space:]]*\(.*\)/\1/p' | tr -d '"' | head -1)
  cierre=$(printf '%s\n' "$cuerpo" | grep -v '^[[:space:]]*$' | tail -1)

  case "$lang" in
    es)
      [ "$signoff" = "A Quien Corresponda" ] || { echo "FALLO [$p] lang:es exige signoff 'A Quien Corresponda' (handle, no traducción). Encontrado: '$signoff'"; fail=1; }
      case "$cierre" in
        "Con respeto, y claro."*) ;;
        *) echo "FALLO [$p] lang:es debe cerrar el cuerpo con «Con respeto, y claro.» Encontrado: '$cierre'"; fail=1 ;;
      esac
      ;;
    en)
      [ "$signoff" = "Dear Power" ] || { echo "FALLO [$p] lang:en exige signoff 'Dear Power'. Encontrado: '$signoff'"; fail=1; }
      case "$cierre" in
        "Plainly, and with respect."*) ;;
        *) echo "FALLO [$p] lang:en debe cerrar con 'Plainly, and with respect.' Encontrado: '$cierre'"; fail=1 ;;
      esac
      ;;
    "") echo "FALLO [$p] 'lang:' vacío"; fail=1 ;;
    *)  echo "AVISO [$p] lang '$lang' sin handle acuñado. Acuña el suyo en el README antes de publicar (ADR-002: los handles no se traducen)."; fail=1 ;;
  esac
done

[ "$fail" -eq 0 ] && echo "firma.sh OK"
exit "$fail"
