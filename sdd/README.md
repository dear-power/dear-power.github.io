# sdd — Spec-Driven Deliberation

El sistema de pensamiento de Dear Power: el árbol que recorre una carta desde el motivo hasta la vigilia posterior a su publicación. Qué significa y por qué existe: [ADR-001, acta fundacional](decisions/001-acta-fundacional.md). Cómo suena la carta que sale de él —y por qué no enseña este andamiaje—: [ADR-002, registro epistolar](decisions/002-registro-epistolar.md).

Cada carta publicada en el blog enlaza aquí su cadena completa: encargo, verificación de hechos, lecturas por dominio, red-team, síntesis, acuerdos y observables fechados. La procedencia no se promete — se enseña.

## Anatomía

```
sdd/
├── decisions/            ← ADRs del sistema
├── dominios.yaml         ← registro de lentes disciplinares y flancos de red-team
├── destinatarios.yaml    ← a quién corresponde el feedback, y por qué canal
└── cartas/
    ├── _plantillas/      ← esquemas de cada artefacto
    └── <slug>/           ← una carpeta por carta
        ├── manifest.yaml       ← estado operativo (fuente de verdad, ADR-001 §5)
        ├── encargo.md          ← tema, dominios, destinatario, límites de alcance
        ├── verificacion/       ← hechos re-levantados desde cero, con fuentes
        ├── lecturas/           ← una ley estructural por lente
        ├── redteam/            ← ataques por flancos opuestos y nombrados
        ├── sintesis.md         ← convergencia, divergencia, blindajes
        ├── acuerdos/           ← lo pactado en cada gate humano
        ├── observables.yaml    ← falsadores fechados, apuestas pre-registradas
        └── borrador.md         ← la carta, escrita conforme a todo lo anterior
```

## Cartas

| Slug | Estado | Título de trabajo |
|------|--------|-------------------|
| [aliado-natural](cartas/aliado-natural/manifest.yaml) | publicado | [El aliado natural del PP es el PSOE](../_posts/2026-07-06-el-aliado-natural-del-pp-es-el-psoe.md) — backfill, sin cadena original |
| [frontera-sur](cartas/frontera-sur/manifest.yaml) | borrador | Setenta mil salieron… (título en PENDING) |
| [democracia-desde-arriba](cartas/democracia-desde-arriba/manifest.yaml) | publicado | [Qué pereza, pero me toca ser anarquista](../_posts/2026-08-31-que-pereza-pero-me-toca-ser-anarquista.md) |

## Decisiones

| # | Título | Estado | Fecha |
|---|--------|--------|-------|
| [001](decisions/001-acta-fundacional.md) | Acta fundacional — qué es "sdd" aquí | Aceptado | 2026-08-12 |
| [002](decisions/002-registro-epistolar.md) | El registro epistolar — la carta no enseña su andamiaje | Aceptado | 2026-08-31 |
| [003](decisions/003-independencia-del-harness.md) | El repo es independiente del harness — puentes, no implementaciones | Aceptado | 2026-08-31 |
| [004](decisions/004-grafo-de-cartas.md) | El grafo de cartas — la referencia se declara y se propaga | Aceptado | 2026-08-31 |
