---
name: grafo-de-cartas
status: accepted
date: 2026-08-31
---

# ADR-004: El grafo de cartas — la referencia se declara y se propaga

**Estado:** Aceptado
**Fecha:** 2026-08-31

## Conclusión

Las cartas de Dear Power no son piezas sueltas: se apoyan unas en otras. Ese
apoyo deja de ser una frase suelta en el texto y pasa a ser una **arista
declarada**, con tres consecuencias: se escribe con wikilink, se declara en el
front matter, y **obliga a revisar las cartas dependientes cuando la carta de
la que dependen cambia**.

Amplía ADR-002 §5 («el hilo previo sí se cita; el andamiaje no»), que decía
*qué* se puede citar pero no *cómo* ni *qué obliga*.

## La notación

La forma canónica vive en `sdd/`, donde el wikilink es la referencia:

```markdown
Escribí aquí que [[el-aliado-natural-del-pp-es-el-psoe|las dos fuerzas que
aceptan las mismas reglas son aliadas naturales]].
```

- **El identificador es el slug del post**, no el de la carta. Lo que el lector
  puede ir a leer es el post; algunas cartas publicadas son anteriores a `sdd/`
  y no tienen carpeta.
- **El alias tras `|` es obligatorio** y carga lo que la referencia refiere
  (ADR-002 §6): un lector que no siga el enlace no pierde el argumento.

Y en el front matter, la arista explícita:

```yaml
depende_de: [el-aliado-natural-del-pp-es-el-psoe]
```

## Al publicar

GitHub Pages construye con Jekyll nativo y **no ejecuta plugins propios**, así
que `[[...]]` no puede renderizarse. El wikilink se resuelve a la forma nativa:

```markdown
[las dos fuerzas ... son aliadas naturales]({% post_url 2026-07-06-el-aliado-natural-del-pp-es-el-psoe %})
```

`post_url` se elige sobre una URL escrita a mano porque **una arista rota es
un error de build, no un enlace 404 silencioso**. Pero eso no se delega en el
despliegue: un build fallido tira el sitio **entero**, no solo esa página. La
arista la verifica `enlaces.sh` antes del commit (todo `{% post_url X %}` de
un post resuelve a `_posts/X.md`; nada de forma sin argumento). El build de
Pages es la última red, no la primera.

**Nunca metas `{% ... %}` de ejemplo fuera de `_posts/`.** Liquid corre antes
que Markdown y no respeta los backticks: `{% post_url %}` sin argumento dentro
de un fichero de `sdd/` tiró el build el 2026-09-01. Por eso `sdd/` y
`.claude/` están en `exclude` de `_config.yml`, y `enlaces.sh` falla si esas
exclusiones desaparecen.

El `depende_de` se copia tal cual al front matter del post, igual que `lang`,
`to` y `signoff`.

## La propagación

> **Si cambia el contenido de una carta, toda carta que dependa de ella entra
> en revisión.**

No «se revisa automáticamente»: **entra en revisión**, que es un acto con gate
humano (`dp-revisar`). El agente no decide solo si la dependiente sigue en pie.

Aplica cuando cambia lo que la carta **afirma o formula**. No aplica a
mantenimiento que no toca el pasaje referido — y quién decide eso es quien hace
la revisión, con la cita delante.

El caso que lo motiva es real: la carta de agosto se apoya en que dos fuerzas
que aceptan las mismas reglas son aliadas naturales. Si esa tesis se matizara o
cayera, el pasaje central de la de agosto —«esa aceptación mutua **es** la
democracia»— quedaría colgando de algo que ya no se sostiene, y nadie se
enteraría.

## Por qué

- Una referencia en prosa es invisible para cualquier herramienta: no se puede
  seguir hacia atrás. Una arista declarada sí, y el grafo inverso es lo que
  convierte «habría que revisar las que dependan» en una lista.
- El riesgo real de un cuerpo de cartas que crece no es contradecirse en una
  pieza: es que una pieza vieja se corrija y las que se apoyaban en ella sigan
  en pie citando algo que su autor ya retiró. Eso es exactamente lo que
  `frontera-sur` critica —una posición que se ajusta sin dejar rastro—, hecho
  con uno mismo.
- El alias obligatorio impide que el grafo degrade la carta: la arista es para
  la máquina, el alias es para el lector, y el lector no debe pagar por la
  máquina.

## Consecuencias

- `sdd/.agents/checks/enlaces.sh` valida el grafo: que cada wikilink resuelva a
  un post existente, que esté declarado en `depende_de`, que no haya
  declaraciones huérfanas, y que el post publicado no conserve `[[...]]` sin
  resolver. Imprime además el grafo inverso.
- `dp-revisar` gana el tercer disparador: **dependencia**.
- `dp-carta`, al escribir, usa wikilink para toda referencia a una carta
  anterior y declara la arista.
- Las cartas anteriores a este ADR entran en deuda: se resuelven por revisión,
  no en masa.
