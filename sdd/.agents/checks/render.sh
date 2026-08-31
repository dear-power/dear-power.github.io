#!/bin/sh
# render.sh — que el post publicado diga lo que la carta dice.
#
# El hard-wrap de la publicación puede dejar al principio de una línea algo que
# Markdown lee como marcador de bloque. El caso real que lo motivó: «...el que
# nacerá en / 2070. Cuando la democracia crece...» — kramdown vio «2070.» como
# lista ordenada, partió el párrafo y abrió una lista numerada en mitad de la
# carta. El texto era correcto; lo que salió publicado, no.
#
# Regla: dentro del cuerpo, un marcador al principio de línea es ACCIDENTAL si
# la línea anterior no está en blanco (estamos a mitad de párrafo). Una lista o
# un encabezado de verdad van precedidos de línea en blanco.
#
# Arreglo: escapar el carácter (2070\.), que sobrevive a que alguien reajuste
# las líneas después. Re-envolver solo mueve el problema.
set -u
root=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
cd "$root" || exit 2
fail=0

for p in _posts/*.md; do
  [ -e "$p" ] || continue
  hits=$(awk '
    NR==1 && /^---/ { infm=1; next }
    infm && /^---/  { infm=0; body=1; prev="";  next }
    !body { next }
    {
      linea = $0
      # marcador de bloque al principio de línea
      esmarcador = (linea ~ /^[[:space:]]*[0-9]+[.)][[:space:]]/) ||
                   (linea ~ /^[[:space:]]*[-*+][[:space:]]/)      ||
                   (linea ~ /^[[:space:]]*>/)                     ||
                   (linea ~ /^[[:space:]]*#{1,6}[[:space:]]/)
      # ...pero solo es accidente si venimos de mitad de párrafo
      if (esmarcador && prev !~ /^[[:space:]]*$/)
        printf "   línea %d: %s\n", NR, linea
      prev = linea
    }
  ' "$p")
  if [ -n "$hits" ]; then
    echo "FALLO [$p] marcador de bloque a mitad de párrafo — Markdown lo renderizará como lista/cita/encabezado:"
    printf '%s\n' "$hits"
    fail=1
  fi
done

if [ "$fail" -ne 0 ]; then
  echo ""
  echo "Escapa el carácter (p. ej. '2070\\.') en vez de re-envolver: el escape"
  echo "sobrevive a que alguien reajuste las líneas; el re-envoltorio no."
else
  echo "render.sh OK"
fi
exit "$fail"
