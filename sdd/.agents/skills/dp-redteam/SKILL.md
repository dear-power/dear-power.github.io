---
name: dp-redteam
description: Ataca las leyes de una carta de Dear Power desde dos flancos opuestos y nombrados, y produce las correcciones que blindan. Blindar un solo flanco es dejar el otro abierto.
---

# dp-redteam — dos flancos opuestos

## Pre-check

1. `estado: leido` en el manifest. Hay leyes que atacar.
2. Elige **dos flancos opuestos y nombrados** de `sdd/dominios.yaml`. Opuestos
   de verdad: si los dos empujan en la misma dirección, no has hecho red-team,
   has hecho revisión. Si el caso pide flancos que no existen, añádelos al
   registro con su `ataca:` y su `exige:`.

## Cómo se ataca

Un flanco no es un revisor educado: es el lector más hostil **que tiene razón**.
Escribe desde dentro de su posición, no sobre ella.

Por cada objetivo (una ley, una formulación, el orden del texto):

- **Ataque** — el argumento, en su versión más fuerte.
- **Veredicto** — `se_rompe` | `aguanta` | `aguanta_con_correccion`.
- **Corrección** — la reescritura exacta que blinda. No «habría que matizar»:
  la frase, literal, lista para el escritor.

Cierra con **qué sobrevive** (qué queda en pie, qué se borra entero, y la
condición necesaria para que la pieza no se caiga ante ese lector) y con
**formulaciones recomendadas**: frases-refrán verbatim, auditables una a una
contra el borrador.

## Lo que hace que esto funcione

**Busca la convergencia meta.** Cuando dos flancos opuestos exigen lo mismo
desde direcciones contrarias, eso no es coincidencia: es la regla de
arquitectura de la pieza, y vale más que cualquiera de los dos ataques. En las
dos cartas hechas hasta hoy, la convergencia fue la misma familia —conceder
entero antes del primer «pero», y declarar dentro del texto lo que no se sabe—.

**Un veredicto `se_rompe` es un éxito.** Significa que el ataque encontró algo
antes que un lector hostil. Bórralo entero y dilo; no lo rebajes a matiz.

**Cuidado con la corrección que reimporta lo que expulsó.** El patrón fino:
refutas la intención y la reemplazas por un actor que «estratégicamente se
abstiene» — que es intención otra vez, disfrazada de jugada óptima. Describe la
matriz, no al que mueve.

## Post-check

1. Dos ficheros en `redteam/`, de flancos **opuestos**, ambos con veredictos
   explícitos por objetivo.
2. Cada `se_rompe` tiene su corrección, y la corrección llegó a `sintesis.md`.
3. La sección de formulaciones recomendadas existe y es verbatim: es el
   contrato contra el que se auditará el borrador.
4. Actualiza `manifest.yaml`: `estado: contrastado`, `flancos: [...]`.
