---
name: dp-vigilar
description: Revisa los observables vencidos de las cartas publicadas de Dear Power, los resuelve contra la realidad y genera seguimiento — también, y sobre todo, cuando el autor se equivocó.
---

# dp-vigilar — la publicación no cierra el ciclo

Cada carta registró sus falsadores **antes** de conocer el resultado. Esta
skill es la que hace que eso signifique algo.

## Pre-check

1. `sdd/.agents/checks/estado.sh`.
2. Recorre los `observables.yaml` de las cartas en estado `publicado` o
   `en-vigilia`. Selecciona los que tengan `fecha_limite` vencida y
   `estado: pendiente`. Los de `fecha_limite: null` son continuos: se revisan
   cuando algo del mundo los toca, no por calendario.

## Cómo se resuelve uno

**Re-verifica, no recuerdes.** Vale lo mismo que en `dp-verificar`: buscador
web, emisor nombrado, fecha. El observable declara qué hecho lo refutaría; ve a
buscar **ese** hecho, no la confirmación de que teníamos razón.

Escribe en el observable:

- `estado:` → `cumplido` | `refutado`
- `resolucion:` → qué pasó, con fuente y fecha. Literal, no interpretado.

## Cuando el falsador dispara

Un observable refutado no es un problema del sistema: es el sistema
funcionando. Y obliga a lo mismo que obligaría en sentido contrario.

> El feedback llega a quien corresponda **también cuando el autor se
> equivocó.**

Un falsador que dispara es **un motivo nuevo** (ADR-001). Se recorre el árbol
otra vez y sale una carta de seguimiento que dice, sin adornarlo, qué se
afirmó, qué pasó y qué queda en pie. Publicar la corrección con la misma
visibilidad que el error es lo único que hace honesto haber apostado.

Si el resultado confirma la apuesta: dilo una vez y sigue. Una predicción
acertada no es un argumento sobre las demás.

## Post-check

1. Todo observable vencido tiene `estado` distinto de `pendiente` y una
   `resolucion` con fuente y fecha.
2. Si alguno se refutó, existe el motivo de seguimiento registrado — no basta
   con marcarlo.
3. `manifest.yaml` al día: `en-vigilia` mientras queden pendientes; `cerrado`
   cuando todos estén resueltos y publicado el seguimiento si tocaba.
