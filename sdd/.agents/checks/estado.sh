#!/bin/sh
# estado.sh — coherencia de los manifests (ADR-001 §5: el estado vive en el repo)
#
# Falla si una carta ha avanzado más allá del pacto con gates humanos abiertos,
# o si un acuerdo sigue 'propuesto' mientras la carta se da por pactada.
set -u
root=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
cd "$root" || exit 2
fail=0

for m in sdd/cartas/*/manifest.yaml; do
  [ -e "$m" ] || continue
  carta=$(dirname "$m")
  slug=$(basename "$carta")
  estado=$(sed -n 's/^estado:[[:space:]]*\([a-z-]*\).*/\1/p' "$m" | head -1)
  [ -n "$estado" ] || { echo "FALLO [$slug] manifest sin 'estado'"; fail=1; continue; }

  # ¿hay pendientes declarados? (lista no vacía: alguna línea '- id:' tras 'pendientes:')
  pend=$(awk '/^pendientes:/{f=1;next} f&&/^[a-z_]+:/{f=0} f&&/^[[:space:]]*-[[:space:]]*id:/{c++} END{print c+0}' "$m")

  # Una anomalía DECLARADA (con motivo escrito) degrada a aviso. Sin motivo no
  # cuenta: el coste de saltarse la máquina de estados es justificarlo por
  # escrito y que quede en git.
  anomalia=$(sed -n 's/^anomalia:[[:space:]]*\(.*\)/\1/p' "$m" | head -1 | tr -d '"')
  if [ -n "$anomalia" ]; then
    echo "AVISO [$slug] anomalía declarada: $anomalia"
    continue
  fi

  case "$estado" in
    pactado|borrador|aprobado|publicado|en-vigilia|cerrado)
      if [ "$pend" -gt 0 ]; then
        echo "FALLO [$slug] estado '$estado' con $pend pendiente(s) abierto(s). Ningún paso procede con un PENDING abierto (ADR-001)."
        fail=1
      fi
      props=$(grep -l '^estado:[[:space:]]*propuesto' "$carta"/acuerdos/*.md 2>/dev/null | wc -l | tr -d ' ')
      if [ "$props" -gt 0 ]; then
        echo "FALLO [$slug] estado '$estado' con $props acuerdo(s) todavía 'propuesto'."
        fail=1
      fi
      ;;
  esac

  # Una carta publicada debe apuntar a su post, y el post debe existir.
  if [ "$estado" = "publicado" ] || [ "$estado" = "en-vigilia" ] || [ "$estado" = "cerrado" ]; then
    post=$(sed -n 's/^post:[[:space:]]*\(.*\)/\1/p' "$m" | head -1 | sed 's|^/||')
    if [ -z "$post" ]; then
      echo "FALLO [$slug] estado '$estado' sin campo 'post:'."
      fail=1
    elif [ ! -f "$post" ]; then
      echo "FALLO [$slug] 'post: $post' no existe."
      fail=1
    fi
  fi
done

[ "$fail" -eq 0 ] && echo "estado.sh OK"
exit "$fail"
