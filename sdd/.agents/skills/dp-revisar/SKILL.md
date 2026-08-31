---
name: dp-revisar
description: Audita una carta ya escrita o publicada cuando algo la ha dejado atrás: un ADR nuevo, un lector que se atasca, o un cambio en la carta de la que depende. Marca hallazgos y propaga por el grafo; no reescribe sola.
---

# dp-revisar — la carta se quedó atrás

Una carta se publica y el mundo sigue: la doctrina crece, un lector la lee de
otra manera, la carta en la que se apoyaba cambia. Esta skill recorre esa deuda
y la registra. Es el único sitio del árbol donde se toca un texto ya publicado.

## Tres disparadores

1. **Deriva doctrinal** — un ADR nuevo deja atrás a las cartas anteriores.
2. **Lectura humana** — alguien se atasca en una frase. No hace falta que la
   doctrina haya cambiado: una carta puede cumplir todas las reglas vigentes y
   aun así no decir lo que quería decir. Este disparador encontró el primer
   hallazgo real del sistema.
3. **Dependencia** (ADR-004) — cambió una carta de la que esta depende. Lo que
   se audita entonces no es la carta entera: es **el pasaje que se apoya en la
   arista**, y la pregunta es si sigue en pie.

El pre-check cambia según cuál sea. Con el segundo, el paso 1 sirve para
descartar deriva, no para buscarla.

## Pre-check

1. Lee los ADR de `sdd/decisions/` **por fecha**. Anota cuáles son posteriores
   a la carta que vas a revisar: solo esos pueden generar hallazgos *por
   deriva*. Si ninguno lo es, dilo — y sigue, porque el hallazgo puede ser de
   lectura.
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

**Dónde se cumple la no-silencio** (precedente:
`democracia-desde-arriba/revisiones/001-2026-08-31.md`):

- **Mantenimiento** —aclarar lo que la frase siempre quiso decir, sin tocar
  ninguna afirmación ni ningún observable—: basta el commit público y el
  fichero de revisión. El post enlaza su procedencia; el rastro es auditable.
- **Cambio de lo afirmado**: nota visible en el propio post, y materia de
  vigilia y carta de seguimiento.

La frontera es si un lector que creyó la versión vieja fue inducido a error
sobre un hecho o una tesis. Si solo se aclara, no.

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

- `ambiguedad` — la frase admite una lectura que **contradice lo que la carta
  defiende**. La clase más grave: no incumple ninguna regla, así que ningún
  check la ve, y puede invertir el sentido de un pasaje entero. Busca dónde el
  texto crea presión de lectura sobre sí mismo —un título, un marco, una
  palabra cargada— y comprueba si las frases que deben resistir esa presión
  aguantan.
- `fuga` — narra el andamiaje sin ganar nada. Se corta.
- `juicio` — podría ser deliberado y funcionar. Se pregunta.
- `deuda` — la carta cumple el espíritu pero no la forma nueva (p. ej. le falta
  el campo de firma). Se arregla sin drama.

Para `ambiguedad`, la prueba que funcionó: **busca dentro de la propia carta
una formulación posterior del mismo argumento**. Si una dice inequívocamente lo
que la otra deja abierto, la ambigua es la que sobra.

## Qué escribes

`sdd/cartas/<slug>/revisiones/NNN-<fecha>.md`: contra qué doctrina se revisó,
los hallazgos clasificados, y **qué se decidió con cada uno** — incluido
«se deja como está, y por qué». Una revisión que no registra lo que se decidió
no dejó de ser una opinión.

## Propagar hacia las dependientes (ADR-004)

**Si has cambiado lo que una carta afirma o formula, no has terminado.**

```sh
sdd/.agents/checks/enlaces.sh   # imprime el grafo inverso al final
```

Toda carta a la derecha de la que tocaste **entra en revisión**: una revisión
propia, con disparador `dependencia`, no una nota al margen de la tuya.

Entrar en revisión no es cambiar. El desenlace más común y perfectamente válido
es «se deja como está, y por qué» — pero registrado, que es la diferencia entre
haberlo comprobado y haberlo supuesto.

No propagues por mantenimiento que no toca el pasaje referido. Para decidirlo,
abre la carta dependiente **por la cita**, no por el principio: lo que importa
es si el alias del wikilink sigue diciendo la verdad sobre la carta de destino.

## Post-check

1. Ningún texto publicado se ha modificado sin que el humano lo sepa.
2. Si cambió lo afirmado, las dependientes tienen su revisión abierta o su
   «se deja como está» razonado. Ninguna arista queda sin mirar.
3. Cada hallazgo tiene su clasificación y su cita literal. Sin cita, no hay
   hallazgo.
4. Si de la revisión sale un cambio doctrinal (la carta vieja reveló un hueco
   en el ADR), eso es un ADR nuevo o una enmienda — no un parche local.
5. `sdd/.agents/checks/all.sh`.
