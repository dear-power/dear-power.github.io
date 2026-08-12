---
name: acta-fundacional
status: accepted
date: 2026-08-12
---

# ADR-001: Spec-Driven Deliberation — qué es "sdd" en Dear Power

**Estado:** Aceptado
**Fecha:** 2026-08-12

## Conclusión

Dear Power adopta una adaptación de Spec-Driven Development donde el objeto no es código sino **cartas**: razonamientos verificados que llevan a un texto publicado dirigido a un poder. Aquí "sdd" significa **Spec-Driven Deliberation** — deliberación dirigida por specs: conversación y pacto basados en datos y hechos, exigidos por igual a las dos partes. El sistema vive en `sdd/` dentro de este repo, junto al blog, porque la cadena de pensamiento pública **es** la procedencia visible de cada carta y el repo es el objeto social.

## Los cuatro principios

Traducción directa de los principios SDD de ingeniería al discurso:

1. **Ninguna carta sin andamiaje pactado.** Toda pieza recorre el árbol completo: Motivo → Encargo → Verificación → Lecturas → Red-team → Síntesis → Pacto → Carta → Vigilia. No se publica lo que no sobrevivió a su propia verificación adversarial.

2. **El humano decide el qué y firma el pacto; el agente decide el cómo.** Las decisiones que definen la pieza (qué voz humana, qué se omite, cuánta concesión) son gates humanos. El agente propone con opciones y recomendación; no resuelve solo.

3. **La verificación re-levantada gana al material heredado.** Ninguna cifra, cita o fecha se hereda de material previo: se re-levanta desde cero con fuente, fecha y emisor. Lo que no aguanta no es un fracaso del proceso — es un hallazgo que reescribe la sección.

4. **Los límites de alcance son ley** — blast radius sobre afirmaciones en lugar de ficheros. Cada carta declara qué afirmaciones puede hacer y cuáles tiene prohibidas (p. ej. "no atribuir orquestación operativa a nadie"; "los muertos jamás como tasa"; regla de verbo: verbos de posición, no de mano). Una afirmación fuera de límites invalida el paso, aunque sea verdadera.

## El mecanismo PENDING

Heredado intacto: ante ambigüedad, el agente **no juzga — se niega y señala**. Marca `PENDING` con opciones, pros/contras y recomendación, y se detiene. Ningún paso posterior procede con un PENDING abierto. Esto es lo que hace el árbol recorrible por un agente de capacidad media: el estado vive en YAML, no en la cabeza del agente; el criterio vive en el pacto, no en el modelo.

## El árbol de acciones

```
motivo ("algo que decir a un poder")
└─ dp-encargo          → encargo.md (dominios, destinatario, ancla, límites de alcance)
   └─ dp-verificar     → verificacion/hechos.yaml + citas-que-caen        [BLOQUEANTE]
      └─ dp-lecturas   → lecturas/<dominio>.md ×N
         └─ dp-redteam → redteam/<flanco>.md ×2 (flancos opuestos, nombrados)
            └─ dp-sintetizar → sintesis.md + observables.yaml + blindajes
               └─ dp-pactar  → acuerdos/NNN-*.md                          [GATE humano]
                  └─ dp-escribir → borrador.md (lee acuerdos + git log)
                     └─ [GATE humano: aprobación]
                        └─ dp-publicar → post + procedencia enlazada
                           └─ dp-vigilar → observables vencidos → re-verificar → seguimiento
                                └─ (si un falsador dispara → nuevo motivo)
```

Piezas estructurales que el árbol exige y que el SDD de ingeniería no tiene:

- **Doble red-team por flancos nombrados y opuestos** (p. ej. "esto es negacionismo" / "esto es conspiranoia"). Blindar un solo flanco es dejar el otro abierto; los dos flancos suelen imponer la misma disciplina desde direcciones contrarias.
- **Formulación-que-aguanta vs formulación-que-no-aguanta** como artefacto de primera clase en cada lectura: la versión tentadora-pero-falsa se registra junto a la depurada, para que el escritor sepa qué evitar y por qué.
- **Observables fechados con falsador**: cada carta cierra con hechos comprobables por cualquiera, con fecha, y la declaración explícita de cuál haría cambiar de opinión al autor. Las apuestas se registran **antes** de conocer el resultado.
- **Vigilia**: la publicación no cierra el ciclo. Los observables vencidos se re-verifican y generan seguimiento — el feedback llega a quien corresponda también cuando el autor se equivocó.

## El pacto vive en git

Lo acordado con el humano (los gates resueltos, las decisiones de forma, los límites) se registra como ficheros en `acuerdos/` dentro de cada carta, con el formato de este ADR: **conclusión, no debate** (Conclusión / Por qué / Consecuencias). La historia de git es el registro del pacto: un agente que retoma una carta reconstruye qué está decidido leyendo `acuerdos/` y el log, no re-litigando la conversación. Las decisiones se toman en conversación amplia y visible; aquí se registra lo decidido, no dónde se decidió.

## Por qué

- El primer caso real (carta sobre la frontera sur, 2026-08-11) recorrió este árbol a mano: verificación con web local que tumbó 5 datos heredados, 6 lecturas por dominio, doble red-team que reformuló las 4 leyes de la pieza, 3 gates humanos, 4 observables fechados. El sistema existió antes que su estructura; esto la formaliza.
- Un agente de capacidad media puede recorrer un árbol explícito con estado en YAML y gates duros; no puede sostener el método entero en la cabeza. La estructura es la que garantiza la honestidad (humildad simétrica, concesión antes del primer "pero", falsadores), no el talento del modelo.
- La procedencia visible y el repo-como-objeto-social son decisiones de diseño previas del proyecto; poner la cadena de pensamiento en el repo público las cumple estructuralmente en vez de prometerlas.

## Consecuencias

- Estructura futura: `sdd/cartas/<slug>/` (una carpeta por carta, con manifest, verificación, lecturas, red-team, síntesis, acuerdos, observables, borrador), `sdd/dominios.yaml` (registro de lentes), `sdd/destinatarios.yaml` (a quién corresponde el feedback), `sdd/.agents/skills/dp-*/` (las skills del árbol). Se construye por fases, validando cada fase contra el caso real de la frontera sur.
- Los dominios crecen una rama por caso real, no por taxonomía a priori.
