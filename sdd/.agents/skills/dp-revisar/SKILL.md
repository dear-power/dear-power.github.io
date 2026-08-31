---
name: dp-revisar
description: Audita cartas ya escritas o publicadas contra la doctrina vigente (ADRs y acuerdos de hoy), cuando el repo ha evolucionado desde que se escribieron. Marca hallazgos; no reescribe sola.
---

# dp-revisar — la doctrina cambió, las cartas no

El método de Dear Power crece por casos reales: un ADR nuevo nace casi siempre
de una carta que lo forzó. El efecto secundario es que **toda carta anterior a
un ADR se escribió sin él**. Esta skill recorre esa deuda.

## Pre-check

1. Lee los ADR de `sdd/decisions/` **por fecha**. Anota cuáles son posteriores
   a la carta que vas a revisar: solo esos pueden generar hallazgos.
2. Lee `acuerdos/` de esa carta. Una decisión pactada en su día **no es un
   hallazgo**: es historia. Solo cuenta como hallazgo si un ADR posterior la
   contradice.
3. Determina el estado: **borrador** o **publicado**. Cambia todo lo demás.

## La regla que gobierna esta skill

> **Lo publicado no se reescribe en silencio.**

| Estado | Qué puedes hacer |
|---|---|
| Borrador, sin publicar | Proponer la reescritura. Sigue siendo gate humano. |
| Publicado | **Nunca editar el texto sin decirlo.** Registrar el hallazgo, y si es sustantivo, tratarlo como motivo de seguimiento (ADR-001, vigilia). |

Un blog que corrige su pasado a escondidas es exactamente el objeto que
`frontera-sur` critica: una posición que se emite y se ajusta sin dejar rastro.
Corregir una errata es mantenimiento; cambiar lo que la carta afirmaba es un
hecho nuevo, y se cuenta.

## Cómo se audita

Frase a frase, con **la prueba del referente** (ADR-002): ¿a qué apunta esta
frase? Mundo, destinatario o autor → se queda. Al procedimiento que produjo la
carta → fuga. A un documento que el lector no tiene delante → rompe la
autocontención.

Además, por cada ADR posterior a la carta, sus reglas propias. Y de la
verificación: **¿ha vencido algún hecho?** Una cifra correcta en su día puede
haber sido superada; eso es materia de `dp-vigilar`, pero se detecta aquí.

## Marcar, no arreglar

Este es el punto donde la skill se equivoca sola si la dejas.

Muchos hallazgos son **juicio, no defecto**. El caso canónico: ADR-002 prohíbe
narrar el andamiaje, pero una carta cuyo destinatario es un lector al que se le
entrega una herramienta puede legítimamente señalar lo que hace —eso es
pedagogía, no costura—. La distinción no la puede resolver un grep, y tampoco
tú sin el humano.

Por cada hallazgo, entrega: **la cita literal**, la regla que roza, **el ADR y
su fecha**, y una clasificación honesta:

- `fuga` — narra el andamiaje sin ganar nada. Se corta.
- `juicio` — podría ser deliberado y funcionar. Se pregunta.
- `deuda` — la carta cumple el espíritu pero no la forma nueva (p. ej. le falta
  el campo de firma). Se arregla sin drama.

## Qué escribes

`sdd/cartas/<slug>/revisiones/NNN-<fecha>.md`: contra qué doctrina se revisó,
los hallazgos clasificados, y **qué se decidió con cada uno** — incluido
«se deja como está, y por qué». Una revisión que no registra lo que se decidió
no dejó de ser una opinión.

## Post-check

1. Ningún texto publicado se ha modificado sin que el humano lo sepa.
2. Cada hallazgo tiene su clasificación y su cita literal. Sin cita, no hay
   hallazgo.
3. Si de la revisión sale un cambio doctrinal (la carta vieja reveló un hueco
   en el ADR), eso es un ADR nuevo o una enmienda — no un parche local.
4. `sdd/.agents/checks/all.sh`.
