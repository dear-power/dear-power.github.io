---
carta: frontera-sur
numero: 003
estado: aceptado
fecha: 2026-08-12
ratificado: 2026-09-01
---

# Acuerdo 003: La capa de verificación nombra; la carta abstrae

## Conclusión

**Opción (a), ratificada en el gate del 2026-09-01.** La regla de abstracción
(cero nombres propios) aplica a la CARTA, no a su cadena de procedencia: la
tabla de hechos nombra emisores, medios y fechas porque una verificación sin
emisor no es verificable por el lector. La cadena pública identifica por tanto
el caso concreto que la carta abstrae.

**Criterio que fija el humano al ratificar, y que va más allá de lo que este
acuerdo preguntaba:**

> Nombrar es correcto **mientras haya hechos y no sea acusatorio**.

Es decir: la línea no está entre nombrar y no nombrar, sino entre **atribuir un
hecho con su emisor y su fecha** —legítimo— y **atribuir intención o culpa a un
nombre propio** —prohibido, y ya cubierto por los límites de alcance del
encargo y por la regla de verbo del flanco `conspiranoia`—.

**Opciones que se consideraron:**
- (a) **Cadena concreta pública** ← ACEPTADA: la procedencia es completa y
  auditable desde el día uno; el referente es reconocible por cualquier lector
  informado de todos modos, y las piezas concretas del arco lo nombrarán.
- (b) **Cadena abstracta hasta publicar las piezas concretas:** la verificación
  con nombres se retiene en privado y se publica junto a la segunda carta del
  arco. Protege la abstracción; aplaza la auditabilidad.

## Por qué (b) ya no era elegible

La tabla de hechos es **pública en un repositorio público desde el 2026-08-12**
(commit `843d2c4`), tres semanas antes de este gate. Este mismo acuerdo lo
advertía: «revertir es posible pero lo publicado pudo ser indexado». Retirarla
no deshace el indexado y además contradice la práctica que el proyecto
estableció después: ADR-004 y el campo `procedencia` hacen que cada carta
publicada enlace su cadena desde el propio post.

El gate se decidió en parte solo, por el paso del tiempo. Se ratifica lo que ya
era el estado de hecho en vez de fingir que seguía abierto.

## Pregunta que este criterio deja abierta

Si nombrar es correcto cuando hay hechos y no hay acusación, **¿por qué la
carta abstrae?** La abstracción deja de justificarse por prudencia y pasa a
justificarse solo como dispositivo retórico (quitar señal partidista y adjetivo
moral). Eso la mantiene en pie, pero la ata al **destinatario**: sigue abierto
si la pieza es un *address* a un poder o una herramienta para un lector, y esa
decisión puede reabrir el registro. Ver la revisión de 2026-09-01.

## Por qué

- La abstracción de la carta es un dispositivo retórico (quitar señal
  partidista y adjetivo moral), no un anonimato: "ninguna cifra sin emisor
  nombrado" y "cero nombres propios" son reglas de capas distintas.
- La procedencia visible es principio del proyecto: prometer verificación sin
  enseñar las fuentes sería exactamente lo que la carta critica.

## Consecuencias

- El repo publica la tabla de hechos tal cual está en
  `verificacion/hechos.yaml`. Ya ocurría desde el commit `843d2c4`.
- Al publicar, el post enlaza su cadena con el campo `procedencia` (ADR-004),
  como ya hacen las dos cartas publicadas.
- El criterio «hechos sí, acusación no» pasa a ser el filtro de toda mención a
  un nombre propio en cualquier capa de esta carta.
