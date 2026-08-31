---
name: independencia-del-harness
status: accepted
date: 2026-08-31
---

# ADR-003: El repo es independiente del harness — puentes, no implementaciones

**Estado:** Aceptado
**Fecha:** 2026-08-31

## Conclusión

Todo lo que define **cómo se trabaja** en Dear Power —skills del árbol, checks,
doctrina— vive en el repo, en formato agnóstico: `sdd/.agents/`. Ningún
directorio específico de una herramienta contiene substancia.

Lo que un harness concreto necesita para descubrir ese material es un **puente
mínimo**: un fichero que no explica nada y solo obliga a leer el real.

```
sdd/.agents/skills/dp-*/SKILL.md   ← la skill. Substancia. Portable.
sdd/.agents/checks/*.sh            ← los checks. Ejecutables por cualquiera y en CI.
.claude/skills/dp-*/SKILL.md       ← puente: "lee el fichero real y síguelo".
.claude/settings.json              ← puente: hooks que invocan los checks del repo.
```

## La regla del puente

Un puente **no puede contener criterio**. Si resume, parafrasea o adelanta lo
que dice la skill real, el criterio se ha bifurcado y a partir de ahí divergen
en silencio. Un puente contiene, como mucho: el nombre, la descripción de
cuándo aplica, y la orden de leer la ruta real antes de actuar.

Consecuencia práctica: si alguien edita un puente para "mejorarlo", eso es un
bug. La mejora va en `sdd/.agents/`.

## Por qué

- **El repo es el objeto social** (ADR-001). Un colaborador que llegue con otro
  agente, con otro editor o sin ninguno tiene que poder leer cómo se trabaja
  aquí. Si el método vive en el directorio de una herramienta, el repo deja de
  ser autocontenido — el mismo defecto que ADR-002 §6 prohíbe en las cartas.
- **Los checks valen más si corren fuera del agente.** Un script en el repo lo
  puede lanzar un hook, una CI, o una persona antes de un push. La misma
  garantía, tres puertas.
- **La honestidad la garantiza la estructura, no el modelo** (ADR-001). Un
  check que solo existe como párrafo dentro de una skill es una promesa; un
  script invocado por un hook es una barrera.
- Corrige la única ruta de ADR-001 que la realidad desmintió: aquel decía
  `sdd/.agents/skills/dp-*/` y acertaba; lo que no previó es que ningún harness
  la descubre sola. El puente es lo que faltaba, no un cambio de sitio.

## Consecuencias

- `sdd/.agents/README.md` documenta el patrón para quien llegue de fuera.
- Los puentes de `.claude/` se versionan: sirven de arranque inmediato para
  quien use este agente, y son deliberadamente triviales.
- Añadir soporte para otro harness es escribir puentes nuevos, nunca duplicar
  método.
- Los checks se escriben como scripts POSIX sin dependencias, para que la
  tercera puerta (una persona, a mano) siga siendo real.
