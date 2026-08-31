#!/bin/sh
# all.sh — todos los checks. Duros primero, de juicio después.
set -u
d=$(dirname "$0")
hard=0

echo "== estado =="; sh "$d/estado.sh" || hard=1
echo "== firma ==";  sh "$d/firma.sh"  || hard=1
echo "== enlaces =="; sh "$d/enlaces.sh" || hard=1
echo "== render =="; sh "$d/render.sh"  || hard=1
echo "== fugas ==";  sh "$d/fugas.sh"  || true

if [ "$hard" -ne 0 ]; then
  echo ""
  echo "Checks duros en rojo: el árbol es incoherente. Arréglalo antes de seguir."
  exit 1
fi
echo ""
echo "Checks duros OK. Si 'fugas' señaló algo, es juicio humano, no error."
exit 0
