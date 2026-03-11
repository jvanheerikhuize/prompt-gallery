# A-SDLC Consumer Template

A language- and platform-agnostic project template for agentic, spec-driven software development.

Governed by the [A-SDLC framework](https://github.com/jvanheerikhuize/a-sdlc) — an Agentic Software
Development Life Cycle defining how software is built, tested, and released when AI agents work
alongside human developers. Compliant with DORA and the EU AI Act out of the box.

---

## Quick Start

### 1. Create your project from this template

On GitHub: **Use this template → Create a new repository**, then clone it.

```bash
git clone https://github.com/<your-org>/<your-project>.git
cd <your-project>
```

### 2. Initialise the governance submodule

```bash
git submodule update --init --recursive
```

### 3. Configure your project

Edit `asdlc-consumer.yaml` — set the project name, description, stack, and team.

### 4. Open in your AI coding agent

The agent reads `AGENTS.md` as its entry point.
It will load the core directives and governance framework before any work begins.

### 5. Start your first feature

```bash
cp stages/01-intent-ingestion/artifacts/inputs/CR-0000-template.yaml \
   stages/01-intent-ingestion/artifacts/inputs/CR-0001-my-feature.yaml
# Fill in the change request, then hand it to the agent
```

---

## Repository Structure

```text
<project>/
├── a-sdlc/                          ← Governance framework (submodule — read-only)
│
├── .agent/                          ← Tool-agnostic agent config (the canonical source)
│   ├── settings.yaml                ← Startup sequence, paths, rules, read-only boundaries
│   └── README.md                    ← How the config is structured
│
├── AGENTS.md                        ← Primary agent entry point — all agents read this first
│
├── README.md                        ← This file
├── asdlc-consumer.yaml              ← Project configuration (fill in when creating a sibling)
│
├── specs/                           ← Feature specifications (output of Stage 1)
│   └── FEAT-0000-template.yaml      ← Template — do not fill in directly
│
└── stages/                          ← Stage workspaces
    ├── 01-intent-ingestion/
    │   └── artifacts/
    │       ├── inputs/              ← Submit change requests here
    │       └── outputs/             ← Agent-produced artifacts
    ├── 02-system-design/artifacts/outputs/
    ├── 03-coding-implementation/artifacts/outputs/
    ├── 04-testing-documentation/artifacts/outputs/
    ├── 05-deployment-release/artifacts/outputs/
    └── 06-observability-maintenance/artifacts/outputs/
```

---

## Agent Support

This template is fully agent-agnostic. `AGENTS.md` is the single entry point — any AI coding assistant reads it directly. Structured configuration for programmatic consumption is in `.agent/settings.yaml`.

---

## The Six Lifecycle Stages

| Stage | Name | Purpose |
| ----- | ---- | ------- |
| 1 | Intent Ingestion | Capture and structure requirements into a Feature Spec |
| 2 | System Design | Architecture, threat modelling, and technical specification |
| 3 | Coding & Implementation | Implementation with quality gates, security scans, and PR review |
| 4 | Testing & Documentation | Verification, documentation, and risk threshold evaluation |
| 5 | Deployment & Release | Production promotion with approval gates and rollback plan |
| 6 | Observability & Maintenance | Continuous monitoring — feeds back into the lifecycle |

---

## Governance

All 50 controls (QC, RC, SC, AC, GC) from the A-SDLC framework apply.
Provides DORA and EU AI Act compliance coverage.

- Framework docs: `a-sdlc/README.md`
- Agent operating instructions: `a-sdlc/AGENTS.md`
- Control registry: `a-sdlc/controls/registry.yaml`
- Regulatory mappings: `a-sdlc/regulatory/compliance-matrix.yaml`

---

## Keeping Governance Current

```bash
git submodule update --remote a-sdlc
git add a-sdlc
git commit -m "chore: update a-sdlc governance framework"
```

Review `a-sdlc/` changes before committing — governance updates may introduce new controls or modify delegation patterns.
