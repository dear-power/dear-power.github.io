# sdd/.agents — cómo se trabaja aquí

Este directorio contiene el método operativo de Dear Power en formato agnóstico:
no depende de ninguna herramienta concreta. Ver [ADR-003](../decisions/003-independencia-del-harness.md).

```
.agents/
├── skills/dp-*/SKILL.md   ← qué hace cada paso del árbol, y sus checks
└── checks/*.sh            ← verificaciones ejecutables (hook, CI o a mano)
```

## Las skills

| Skill | Cuándo | Nodo del árbol (ADR-001) |
|---|---|---|
| [dp-carta](skills/dp-carta/SKILL.md) | hay algo que decirle a un poder | recorre el árbol entero, para en cada gate |
| [dp-verificar](skills/dp-verificar/SKILL.md) | hay que fundamentar hechos | `verificacion/` — **bloqueante** |
| [dp-redteam](skills/dp-redteam/SKILL.md) | hay leyes que atacar | `redteam/` — dos flancos opuestos |
| [dp-revisar](skills/dp-revisar/SKILL.md) | la doctrina cambió y hay cartas viejas | (nuevo) auditar lo escrito contra los ADR de hoy |
| [dp-vigilar](skills/dp-vigilar/SKILL.md) | venció un observable | `observables.yaml` → seguimiento |

`dp-carta` delega en `dp-verificar` y `dp-redteam` porque son los nodos caros y
los que más se relanzan sueltos. Los demás pasos los recorre él mismo.

## Los checks

Ejecutables sin dependencias, desde la raíz del repo:

```sh
sdd/.agents/checks/all.sh              # todo
sdd/.agents/checks/estado.sh           # coherencia de manifests y PENDING
sdd/.agents/checks/fugas.sh            # ADR-002: andamiaje narrado en borradores/posts
sdd/.agents/checks/firma.sh            # ADR-002: firma y campos de publicación
```

Salen con código ≠ 0 si algo falla, para que un hook o una CI puedan bloquear.
**Un check que falla no siempre es un error**: `fugas.sh` señala candidatos que
exigen juicio humano. Lee lo que imprime antes de cambiar nada.

Una carta puede saltarse la máquina de estados declarando `anomalia:` en su
manifest **con el motivo escrito**. `estado.sh` lo degrada a aviso. El coste de
la excepción es justificarla y que quede en git; sin motivo, no cuenta.

## Los hooks

`hooks/` contiene los wrappers que un harness invoca. La lógica está aquí, no
en la configuración del harness (ADR-003), así que sirven igual para una CI o
para un `pre-commit` de git:

| Wrapper | Cuándo | Efecto |
|---|---|---|
| [pre-commit.sh](hooks/pre-commit.sh) | antes de un commit | **bloquea** si `estado` o `firma` fallan |
| [post-edit.sh](hooks/post-edit.sh) | tras editar un borrador o un post | **avisa** de candidatos a fuga; nunca bloquea |

## Para quien llegue con otro agente

Léete, en este orden: [ADR-001](../decisions/001-acta-fundacional.md) (cómo se
piensa una carta), [ADR-002](../decisions/002-registro-epistolar.md) (cómo
suena), [ADR-003](../decisions/003-independencia-del-harness.md) (por qué esto
está aquí y no en el directorio de tu herramienta). Después, la skill del paso
que te toque.
