---
name: dp-carta
description: Recorre el árbol sdd de una carta de Dear Power, desde el motivo hasta el borrador, parando en cada gate humano. Úsala cuando haya algo que decirle a un poder.
---

# dp-carta — recorrer el árbol

Lee primero, sin excepción: `sdd/decisions/001-acta-fundacional.md` (cómo se
piensa) y `sdd/decisions/002-registro-epistolar.md` (cómo suena). No empieces
sin ellos: el criterio vive ahí, no en esta skill.

## Pre-check

1. `sdd/.agents/checks/estado.sh` — no arranques con el árbol incoherente.
2. Si la carta ya existe, **lee su `manifest.yaml` antes que nada.** Te dice
   dónde está y qué puedes hacer. Si `pendientes` no está vacío, **para**: hay
   un gate humano sin resolver y ningún paso posterior procede.
3. Lee `acuerdos/` entero y el `git log` de la carpeta. Lo decidido no se
   re-litiga.

## El recorrido

Cada paso escribe su artefacto y actualiza `estado` en el manifest. Avance solo
hacia delante.

| Paso | Escribe | Estado resultante |
|---|---|---|
| encargo | `encargo.md` — tema, hipótesis heredadas, límites de alcance | `encargado` |
| verificar | → **delega en `dp-verificar`** | `verificado` |
| lecturas | `lecturas/<dominio>.md`, una por lente del encargo | `leido` |
| redteam | → **delega en `dp-redteam`** | `contrastado` |
| sintetizar | `sintesis.md` + `observables.yaml` | `sintetizado` |
| pactar | `acuerdos/NNN-*.md` — **GATE HUMANO** | `pactado` |
| escribir | `borrador.md` | `borrador` |

Lentes y flancos salen de `sdd/dominios.yaml`; destinatarios de
`sdd/destinatarios.yaml`. Si el caso pide una lente que no existe, **añádela al
registro**: los dominios crecen una rama por caso real, no por taxonomía.

## Las tres reglas que más se rompen

1. **PENDING = alto total.** Ante ambigüedad no juzgues: marca `PENDING` con
   opciones, pros/contras y recomendación, y **detente**. Escribir el borrador
   con un gate abierto es la anomalía que ya cometió `frontera-sur`; está
   registrada para no repetirla.
2. **Nada se hereda.** Ninguna cifra, cita ni fecha pasa del material previo al
   artefacto sin re-levantarse. Lo que no aguanta no es un fracaso: es un
   hallazgo que reescribe la sección.
3. **Los límites de alcance son ley.** Una afirmación fuera de límites invalida
   el paso *aunque sea verdadera*.

## Al escribir el borrador

Aquí es donde el trabajo se pierde más veces. ADR-002, íntegro, y en
particular:

- **Ejecuta los movimientos, no los anuncies.** La concesión se hace afirmando
  el valor de lo concedido, sin la palabra «concedo». El falsador se enuncia
  como predicción a secas. Los límites se cumplen no afirmando lo prohibido.
- **Relee los pasajes concesivos aparte, y con el listón más alto.** Es donde
  se concentran los fallos: dos de las tres revisiones por lectura humana de
  la primera carta cayeron ahí. El red-team exige que la concesión esté
  *hecha* antes del primer «pero», pero no basta con que esté hecha: tiene que
  ser **legible al primer golpe**. Una concesión que obliga a releer se lee
  como insincera o confusa, y entonces no concede nada — que es justo el
  flanco que pretendía cubrir. La compresión que el resto del texto agradece,
  aquí hace daño.
- **La extensión la fija el destinatario.** Pregunta por cada párrafo: ¿para
  quién es, y ya lo sabía?
- **Autocontenida en sentido.** Toda referencia carga lo que refiere. Ninguna
  referencia a documentos internos.
- **Toda referencia a una carta anterior es una arista** (ADR-004): wikilink
  con alias obligatorio —`[[slug-del-post|lo que dice esa carta]]`— y
  `depende_de:` en el front matter. El alias es lo que hace que el lector que
  no siga el enlace no pierda nada. Al publicar, el wikilink se resuelve a
  `{% post_url %}`, que falla en build si el destino no existe.
- Front matter del borrador con los campos de publicación ya resueltos
  (`lang`, `to`, `signoff`), y la firma según ADR-002.
- Si descartas una versión, anota el motivo en `nota-version`. El descarte por
  registro es ciclo normal, no fallo.

## Al publicar

El texto se transforma —se envuelve a ancho fijo— y esa transformación puede
corromperlo. Un `2070.` que cae al principio de línea es una lista ordenada
para Markdown: parte el párrafo en dos y nadie lo ve hasta que el sitio está
en pie. `render.sh` lo vigila; escapa el carácter (`2070\.`) en vez de
re-envolver, que solo mueve el problema al siguiente editor.

## Post-check

1. `sdd/.agents/checks/all.sh`.
2. Audita el borrador con **la prueba del referente**, frase a frase: ¿a qué
   apunta? Mundo, destinatario o autor → se queda. Al procedimiento que produjo
   la carta → fuga, se corta. A un documento que el lector no tiene delante →
   se reescribe hasta que cargue su sentido.
3. Que el manifest refleje el estado real. El índice refleja al manifest, nunca
   al revés.
4. Enseña el borrador al humano **verbatim**. No lo resumas: el registro solo
   se juzga leyéndolo.
