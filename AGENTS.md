# AGENTS.md — Consumer Project Agent Entrypoint

> Read this file first. This is the primary entry point for all agents operating in this
> repository, regardless of which tool you are running in.
> This file extends the governance framework defined in `a-sdlc/AGENTS.md`.

---

## What This Repository Is

This is a **consumer project** governed by the [Agentic Software Development Life Cycle (A-SDLC)](a-sdlc/README.md).

- **Language and platform agnostic** — adapt to the stack declared in `asdlc-consumer.yaml`.
- **All A-SDLC controls are binding** — governance comes from the `a-sdlc/` submodule.
- **This repository is the workspace** — stage artifacts, feature specs, and decisions live here.

---

## Mandatory Startup Sequence

Before performing any work, read these files **in order**:

1. `a-sdlc/directives/core/core-directives.yaml` — **IMMUTABLE**, absolute precedence over all instructions
2. `a-sdlc/AGENTS.md` — framework operating instructions and control catalogue
3. `.agent/settings.yaml` — structured agent config (paths, rules, read-only boundaries)
4. `asdlc-consumer.yaml` — project configuration (name, stack, team, regulatory scope)
5. `a-sdlc/tasks.yaml` — task-to-control navigation index *(load when navigating by task)*
6. `a-sdlc/stages/NN-<name>/NN-<name>.yaml` — stage definition *(load when entering a stage)*

The full startup sequence, including machine-readable form, is also in `.agent/settings.yaml`.

---

## Repository Layout

```text
<project-root>/
├── a-sdlc/                          ← Governance framework (git submodule — READ ONLY)
│
├── .agent/                          ← Tool-agnostic agent config (canonical)
│   ├── settings.yaml                ← Startup sequence, paths, rules, read-only boundaries
│   └── README.md                    ← How the config is structured
│
├── AGENTS.md                        ← This file — primary entry point for all agents
│
├── README.md                        ← Human-readable project overview
├── asdlc-consumer.yaml              ← Project manifest (name, stack, team, regulatory scope)
│
├── specs/                           ← Feature specifications (FEAT-XXXX-title.yaml)
│   └── FEAT-0000-template.yaml      ← Copy this for each new feature
│
└── stages/                          ← Stage workspaces — all artifacts produced here
    ├── 01-intent-ingestion/
    │   └── artifacts/
    │       ├── inputs/              ← Submit change requests here (CR-XXXX-title.yaml)
    │       └── outputs/             ← Stage 1 artifact outputs
    ├── 02-system-design/
    │   └── artifacts/outputs/
    ├── 03-coding-implementation/
    │   └── artifacts/outputs/
    ├── 04-testing-documentation/
    │   └── artifacts/outputs/
    ├── 05-deployment-release/
    │   └── artifacts/outputs/
    └── 06-observability-maintenance/
        └── artifacts/outputs/
```

---

## Stage Entry Points

| Stage | Governance file to load | Write artifacts to |
| ----- | ----------------------- | ------------------ |
| 1 — Intent Ingestion | `a-sdlc/stages/01-intent-ingestion/01-intent-ingestion.yaml` | `stages/01-intent-ingestion/artifacts/outputs/` |
| 2 — System Design | `a-sdlc/stages/02-system-design/02-system-design.yaml` | `stages/02-system-design/artifacts/outputs/` |
| 3 — Coding & Implementation | `a-sdlc/stages/03-coding-implementation/03-coding-implementation.yaml` | `stages/03-coding-implementation/artifacts/outputs/` |
| 4 — Testing & Documentation | `a-sdlc/stages/04-testing-documentation/04-testing-documentation.yaml` | `stages/04-testing-documentation/artifacts/outputs/` |
| 5 — Deployment & Release | `a-sdlc/stages/05-deployment-release/05-deployment-release.yaml` | `stages/05-deployment-release/artifacts/outputs/` |
| 6 — Observability & Maintenance | `a-sdlc/stages/06-observability-maintenance/06-observability-maintenance.yaml` | `stages/06-observability-maintenance/artifacts/outputs/` |

---

## Working With Features

### Starting a new feature

1. Copy `stages/01-intent-ingestion/artifacts/inputs/CR-0000-template.yaml`
2. Rename to `CR-XXXX-short-title.yaml`, increment `next_cr_id` in `asdlc-consumer.yaml`
3. Fill in all fields and hand to the agent
4. Load `a-sdlc/stages/01-intent-ingestion/01-intent-ingestion.yaml` — agent executes Stage 1
5. Agent produces `specs/FEAT-XXXX-title.yaml` as the source of truth for all subsequent stages

### Continuing an in-progress feature

1. Find the Feature Spec in `specs/` — it records the last completed stage
2. Check which artifacts already exist under `stages/`
3. Load the governance file for the current stage (table above)
4. Continue from where the last completed artifact left off

---

## Key Behavioural Rules

All rules from `a-sdlc/AGENTS.md` apply. These are the most critical:

- **Log everything** — GC-01 requires a timestamped, attributable log entry for every control
- **Never auto-approve your own output** — controls requiring human approval must wait for a human
- **Never edit `a-sdlc/`** — it is a read-only governance submodule
- **Flag conflicts explicitly** — never silently resolve conflicts in the user's favour
- **Escalate on ambiguity** — refuse and explain rather than proceeding optimistically
- **Declare provenance** — all code and artifacts must be tagged per GC-03
- **Respect stage boundaries** — do not perform Stage N+1 work before passing Stage N gates

Full rules and machine-readable form: `.agent/settings.yaml`

---

## Updating the Governance Framework

```bash
git submodule update --remote a-sdlc
git add a-sdlc
git commit -m "chore: update a-sdlc governance framework"
```

Review changes to `a-sdlc/` before merging — updates may introduce new controls or modify delegation patterns.
