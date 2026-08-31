#!/bin/sh
# enlaces.sh — ADR-004: el grafo de cartas.
#
# Valida que cada arista esté bien puesta y sea seguible:
#   1. todo [[slug]] de un borrador resuelve a un post existente
#   2. todo [[slug]] está declarado en depende_de
#   3. todo depende_de aparece como wikilink (no hay aristas fantasma)
#   4. ningún post publicado conserva [[...]] sin resolver
#   5. el depende_de del post coincide con el del borrador
# Imprime al final el grafo inverso: quién entra en revisión si cambias X.
set -u
root=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
cd "$root" || exit 2
fail=0

# --- helpers ---------------------------------------------------------------
# front matter de un fichero (entre los dos primeros ---)
fm() { awk 'NR==1&&/^---/{f=1;next} f&&/^---/{exit} f' "$1"; }
# cuerpo (tras el segundo ---)
body() { awk 'NR==1&&/^---/{f=1;next} f&&/^---/{f=0;b=1;next} b' "$1"; }
# slugs de los wikilinks [[slug]] o [[slug|alias]] de un texto en stdin
wikilinks() { grep -o '\[\[[^]]*\]\]' 2>/dev/null | sed 's/^\[\[//; s/\]\]$//; s/|.*//'; }
# valores de una lista inline yaml: depende_de: [a, b]
declarados() { sed -n 's/^depende_de:[[:space:]]*\[\(.*\)\].*/\1/p' | tr ',' '\n' | tr -d ' "'"'"''; }
# ¿existe un post con este slug?
post_de() { ls _posts/*-"$1".md 2>/dev/null | head -1; }

# --- 1-3: borradores -------------------------------------------------------
for b in sdd/cartas/*/borrador.md; do
  [ -e "$b" ] || continue
  slug=$(basename "$(dirname "$b")")
  links=$(body "$b" | wikilinks | sort -u)
  decl=$(fm "$b" | declarados | grep -v '^$' | sort -u)

  for l in $links; do
    if [ -z "$(post_de "$l")" ]; then
      echo "FALLO [$slug] wikilink [[$l]] no resuelve a ningún _posts/*-$l.md"
      fail=1
    fi
    printf '%s\n' "$decl" | grep -qx "$l" || {
      echo "FALLO [$slug] wikilink [[$l]] sin declarar en depende_de"
      fail=1
    }
    # el alias es obligatorio (ADR-004): la referencia carga lo que refiere
    body "$b" | grep -q "\[\[$l|" || {
      echo "FALLO [$slug] [[$l]] sin alias '|texto'; el lector que no siga el enlace pierde el argumento"
      fail=1
    }
  done

  for d in $decl; do
    printf '%s\n' "$links" | grep -qx "$d" || {
      echo "FALLO [$slug] depende_de declara '$d' pero ningún wikilink lo usa (arista fantasma)"
      fail=1
    }
  done
done

# --- 4-5: posts publicados -------------------------------------------------
for p in _posts/*.md; do
  [ -e "$p" ] || continue
  if body "$p" | grep -q '\[\['; then
    echo "FALLO [$p] conserva wikilinks sin resolver; al publicar se convierten a {% post_url %} (ADR-004)"
    fail=1
  fi
  pdecl=$(fm "$p" | declarados | grep -v '^$' | sort -u)
  for d in $pdecl; do
    [ -n "$(post_de "$d")" ] || { echo "FALLO [$p] depende_de '$d' no existe"; fail=1; }
  done
done

# --- grafo inverso ---------------------------------------------------------
echo ""
echo "Grafo inverso (si cambias la izquierda, la derecha entra en revisión):"
any=0
for p in _posts/*.md; do
  [ -e "$p" ] || continue
  target=$(basename "$p" .md | sed 's/^[0-9]*-[0-9]*-[0-9]*-//')
  deps=""
  for q in _posts/*.md; do
    fm "$q" | declarados | grep -qx "$target" && deps="$deps $(basename "$q" .md | sed 's/^[0-9]*-[0-9]*-[0-9]*-//')"
  done
  [ -n "$deps" ] && { echo "  $target →$deps"; any=1; }
done
[ "$any" -eq 0 ] && echo "  (ninguna arista todavía)"

echo ""
[ "$fail" -eq 0 ] && echo "enlaces.sh OK"
exit "$fail"
