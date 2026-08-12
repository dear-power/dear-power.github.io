# sdd — Spec-Driven Deliberation

El sistema de pensamiento de Dear Power: el árbol que recorre una carta desde el motivo hasta la vigilia posterior a su publicación. Qué significa y por qué existe: [ADR-001, acta fundacional](decisions/001-acta-fundacional.md).

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
| [frontera-sur](cartas/frontera-sur/manifest.yaml) | borrador | Setenta mil salieron… (título en PENDING) |

## Decisiones

| # | Título | Estado | Fecha |
|---|--------|--------|-------|
| [001](decisions/001-acta-fundacional.md) | Acta fundacional — qué es "sdd" aquí | Aceptado | 2026-08-12 |
