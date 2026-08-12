---
carta: frontera-sur
numero: 003
estado: propuesto
fecha: 2026-08-12
---

# Acuerdo 003 [PROPUESTO]: La capa de verificación nombra; la carta abstrae

## Conclusión (propuesta — PENDING, bloquea publicación)

La regla de abstracción (cero nombres propios) aplica a la CARTA, no a su
cadena de procedencia: la tabla de hechos nombra emisores, medios y fechas
porque una verificación sin emisor no es verificable por el lector. La cadena
pública identifica por tanto el caso concreto que la carta abstrae.

**Opciones:**
- (a) **Cadena concreta pública** (recomendada): la procedencia es completa y
  auditable desde el día uno; el referente es reconocible por cualquier lector
  informado de todos modos, y las piezas concretas del arco lo nombrarán.
- (b) **Cadena abstracta hasta publicar las piezas concretas:** la verificación
  con nombres se retiene en privado y se publica junto a la segunda carta del
  arco. Protege la abstracción; aplaza la auditabilidad.

## Por qué

- La abstracción de la carta es un dispositivo retórico (quitar señal
  partidista y adjetivo moral), no un anonimato: "ninguna cifra sin emisor
  nombrado" y "cero nombres propios" son reglas de capas distintas.
- La procedencia visible es principio del proyecto: prometer verificación sin
  enseñar las fuentes sería exactamente lo que la carta critica.

## Consecuencias

- Si (a): este repo publica la tabla de hechos tal cual está en
  `verificacion/hechos.yaml`. Ya ocurre desde este commit; revertir es posible
  pero lo publicado pudo ser indexado.
- Si (b): `verificacion/` se despubdica hasta la segunda pieza del arco.
- En ambos casos, la carta no enlaza su procedencia hasta resolverse este
  acuerdo.
