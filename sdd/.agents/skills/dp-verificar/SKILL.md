---
name: dp-verificar
description: Re-levanta desde cero los hechos de una carta de Dear Power y produce verificacion/hechos.yaml con las citas que caen. Paso bloqueante — ningún paso posterior procede sin él.
---

# dp-verificar — la verificación re-levantada

**Bloqueante.** Nada avanza hasta que exista la tabla de hechos.

## Pre-check

1. Existe `encargo.md` y declara sus hipótesis de partida como **herencia no
   contrastada**.
2. Tienes buscador web. Sin él no hay verificación, hay memoria — y la memoria
   es exactamente lo que este paso desconfía.

## La regla

**Ninguna cifra, cita o fecha se hereda.** Cada una se re-levanta desde cero
con **emisor nombrado, fecha y procedencia declarada** (oficial / afín /
hostil / independiente / regional). Que una afirmación venga del propio hilo
de pensamiento del autor no la exime: al contrario, es la que más se cae.

Lo que no aguanta **no es un fracaso del proceso — es un hallazgo**. Se
registra en `citas_que_caen` con qué decía, qué dice la realidad, y cómo hay
que reformular. Una ley que sobrevive a que se le caiga su cifra favorita sale
más fuerte, no más débil.

## Qué escribes

`verificacion/hechos.yaml`:

- `veredicto_global` — qué aguanta, qué cae, qué se estrecha. Sé explícito
  sobre la diferencia entre **la forma fuerte** de una hipótesis y **la débil**:
  casi siempre cae la primera y sobrevive la segunda, y confundirlas es cómo se
  publica una exageración de buena fe.
- `citas_que_caen` — una entrada por afirmación caída, con su reformulación.
- `tabla` — una entrada por hecho: `afirmacion`, `fuente`, `fecha`, `aguanta`
  (si | no | parcial), `url`, `nota`.

Si una lente del encargo impone reglas propias (p. ej. «los muertos con
horquilla honesta por emisor, jamás como tasa»), se aplican **aquí también**,
no solo en la carta.

## Busca el contraejemplo, no solo la confirmación

Un patrón sin su lista de excepciones es una anécdota. Por cada caso que
confirma la hipótesis, busca activamente el que la rompería. Si no encuentras
ninguno, dilo — «no se halló contraejemplo en la muestra revisada» es un
resultado; «el patrón es universal» es una afirmación que no has verificado.

## Post-check

1. Toda entrada de la tabla tiene emisor **y** fecha. Sin excepción.
2. `citas_que_caen` no está vacío por comodidad: si nada cayó, o el material
   previo era excepcional o no buscaste lo suficiente. Justifícalo.
3. El `veredicto_global` dice explícitamente qué hipótesis **cambia de estatus**
   (de premisa a ilustración, de ley a correlación). Ese es el entregable real.
4. Actualiza `manifest.yaml`: `estado: verificado`, `fechas.verificacion`.
