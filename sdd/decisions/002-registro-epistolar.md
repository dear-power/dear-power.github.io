---
name: registro-epistolar
status: accepted
date: 2026-08-31
---

# ADR-002: El registro epistolar — la carta no enseña su andamiaje

**Estado:** Aceptado
**Fecha:** 2026-08-31

## Conclusión

Una carta de Dear Power es un *address* dentro de un hilo unidireccional con
un destinatario que **ya está en la conversación**. No es un informe, ni una
clase, ni la memoria del proceso que la produjo.

ADR-001 fija cómo se *piensa* una carta. Este fija cómo *suena*, y añade la
regla que ADR-001 no cubría: **el árbol `sdd/` existe para que la carta esté
apoyada, no para volcarse en ella.** Cuando el método se ve, la carta ha
fallado aunque cada frase sea verdadera.

## Los cinco principios del registro

1. **La carta habla dentro de un hilo; no lo abre.** El destinatario llega con
   contexto: es un poder que vive en el asunto del que se le escribe. Lo que
   ya sabe se referencia de paso y se sigue adelante. Desarrollarlo invierte la
   relación —quien explica se coloca por encima— y eso contradice el motivo
   declarado del proyecto: que el autor tampoco tenía ni idea en puestos mucho
   más simples.

2. **La extensión la fija el destinatario, no el tema.** No hay una longitud
   canónica. Al poder que ya tiene el contexto se le referencia y la carta es
   corta. Al lector al que se le entrega una herramienta para leer lo que le
   cuentan, el desarrollo **es** el regalo, y la carta puede ser larga sin
   dejar de cumplir este ADR (caso `frontera-sur`). La pregunta no es "¿cuánto
   ocupa?" sino "¿para quién es cada párrafo, y ese ya lo sabía?".

3. **El hueco se deja no diciendo.** Nunca diciendo que no se dice. «Usted se
   sabe la lista igual que yo» es lo contrario de dejar un hueco: es
   ocuparlo con el anuncio de que se deja.

4. **La carta no narra su propio andamiaje.** Los movimientos del método
   —conceder antes del primer «pero», registrar un falsador, acotar lo que no
   se afirma, dejar el hueco— **se ejecutan, no se anuncian**. Fugas típicas,
   con el artefacto que estaban recitando:

   | Fuga | Artefacto narrado |
   |---|---|
   | «le concedo lo suyo, porque quien lo regatea hace trampa» | concesión previa obligatoria del red-team |
   | «usted se sabe la lista igual que yo» | el hueco del principio 3 |
   | «no se la voy a vender como tal» | `verificacion/` — citas que caen |
   | «que quede claro qué no estoy diciendo» | límites de alcance del encargo |
   | «y me mojo, para que valga» | `observables.yaml` — apuesta pre-registrada |
   | «nada de lo que sigue va contra eso» | el orden del texto pactado en síntesis |

   En su lugar: la concesión se hace afirmando el valor de lo concedido, sin la
   palabra «concedo». El falsador se enuncia como predicción a secas. Los
   límites se cumplen **no afirmando lo prohibido**, no listando lo que no se
   afirma.

5. **El hilo previo sí se cita; el andamiaje no.** «Escribí aquí que…»
   referido a una carta publicada es el hilo unidireccional real: el
   destinatario puede ir a leerlo. Esa es la diferencia operativa —lo público
   y verificable por el destinatario es conversación; lo interno al método es
   costura—.

6. **La carta es autocontenida en sentido; apoyada desde fuera en prueba.**
   El hueco del principio 3 se deja en la **justificación**, jamás en el
   **significado**. Quien lee solo la carta, sin entrar en `sdd/` ni en las
   cartas anteriores, no pierde nada del argumento: pierde la posibilidad de
   auditarlo. Dos consecuencias exactas:

   - **Toda referencia carga lo que refiere.** No se cita una carta anterior
     por su título ni un hecho por su fuente: se reenuncia la afirmación en la
     misma frase que la cita. «Escribí aquí que las dos fuerzas que aceptan las
     mismas reglas son aliadas naturales» cumple —dice lo que dice el
     antecedente—; «como ya expliqué en la carta anterior» no cumple.
   - **Prohibida la referencia interna.** Nada de «según la verificación»,
     «como se vio en la lectura de…», «por lo pactado». El lector no tiene esos
     documentos delante y el destinatario no tiene por qué buscarlos.

   Referenciar de paso (principio 1) y ser autocontenida no se contradicen:
   se referencia **la prueba**, no **la idea**. «Atenas con su liga detrás»
   basta para entender la frase sin saber nada de la Liga de Delos; quien
   quiera la fecha y la fuente entra en `verificacion/`.

## La firma

Fijada a partir de cómo se firmó la primera carta publicada (2026-07-06) y de
la regla de handles del README: **los handles son epistolares y
resonance-matched por idioma, nunca traducidos** —el ancla es la forma de
dirigirse *a* un poder—.

Tres piezas, y las tres son obligatorias:

| Pieza | Dónde vive | Valor |
|---|---|---|
| Fórmula de cierre | última línea del cuerpo | **es:** «Con respeto, y claro.» · **en:** "Plainly, and with respect." |
| Handle | `signoff:` en el front matter | **es:** «A Quien Corresponda» · **en:** "Dear Power" |
| Destinatario | `to:` en el front matter | el rol pactado en el acuerdo de destinatario de esa carta |

- El handle **no se traduce**: «A Quien Corresponda» no es la versión española
  de "Dear Power", es su equivalente por resonancia —las dos son la fórmula
  con la que una carta se dirige a un poder sin nombrarlo—. Un idioma nuevo se
  incorpora acuñando su handle, no traduciendo ninguno de los dos.
- La fórmula de cierre sigue la misma lógica: «Con respeto, y claro.» es el
  equivalente por resonancia de "Plainly, and with respect." de `about.md`, no
  su traducción.
- `signoff:` es obligatorio aunque el layout tenga `default: site.title`: el
  default es el handle **inglés**, y una carta en español que lo omita se
  firmará "Dear Power" sin avisar.
- `to:` nombra un **rol**, nunca un nombre propio, en coherencia con
  `destinatarios.yaml`.

## La prueba del referente

Para auditar un borrador, frase a frase: **¿a qué apunta esta frase?**

- Al mundo, al destinatario o al autor → se queda.
- Al procedimiento que produjo la carta → es una fuga y se corta.
- A un documento que el lector no tiene delante → rompe el principio 6 y se
  reescribe hasta que cargue su propio sentido.

El caso límite útil: una frase puede ser honesta, verdadera y exigida por el
red-team y aun así ser una fuga. Lo que el red-team exige es el **efecto**
(que la concesión esté hecha antes del primer «pero»), no la **declaración**
del efecto.

## Por qué

- La procedencia visible ya vive en `sdd/`, pública y auditable. Precisamente
  por eso la carta puede ser breve y no tiene que demostrar dentro de sí que
  fue verificada: quien dude, entra en la carpeta.
- Cada anuncio del método le pide al destinatario que evalúe el procedimiento
  del autor en lugar de la afirmación. Desplaza el objeto de la carta.
- Anunciar una concesión la anula: convierte un gesto de respeto en una
  maniobra declarada.
- El primer caso que forzó esto: la carta `democracia-desde-arriba`
  (2026-08-31) necesitó tres versiones —v1 descartada por larga y didáctica,
  v2 por narrar su andamiaje— para llegar al registro. Los acuerdos 004 y 005
  de esa carta son la instancia; este ADR es la regla.

## Consecuencias

- `dp-escribir` lee este ADR antes de escribir, y audita el borrador con la
  prueba del referente antes de darlo por terminado.
- El descarte por registro es un ciclo normal, no un fallo: las versiones
  descartadas se registran en `nota-version` del borrador con su motivo, para
  que la corrección no se pierda al recomponer el contexto.
- `cartas/_plantillas/` no cambia: este ADR gobierna el borrador, no los
  artefactos internos. Dentro de `lecturas/`, `redteam/` y `sintesis.md` el
  vocabulario del método es obligatorio; en `borrador.md` está prohibido.
- `borrador.md` lleva en su front matter los campos de publicación ya
  resueltos (`lang`, `to`, `signoff`), para que `dp-publicar` sea un traslado
  mecánico y la firma no se decida el día de publicar.
- Los acuerdos 004 y 005 de `democracia-desde-arriba` quedan como instancias
  de esta decisión y no se re-litigan.
