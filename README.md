# Agent Role Module — Masterprompt Library

A collection of structured masterprompts that define specific agent roles for any LLM or agentic pipeline.
Each prompt is self-contained: paste into a fresh LLM session, inject as a system prompt, or load dynamically
from your agent framework. No external infrastructure required.

This repository can be consumed as a **git submodule** or referenced directly, adding ready-made agent
roles to any agentic project.

---

## Role Registry

The canonical role list lives in [`roles/registry.yaml`](roles/registry.yaml).

### Entertainment

| Role | Prompt | Variant | Description |
|------|--------|---------|-------------|
| T.A.G. — Text Adventure Generator | [roles/entertainment/text-adventure/prompt.md](roles/entertainment/text-adventure/prompt.md) | [compressed](roles/entertainment/text-adventure/prompt-compressed.md) | Game master for an immersive, stateful text adventure |

### Engineering

| Role | Prompt | Variant | Description |
|------|--------|---------|-------------|
| C.R.A. — Code Review Analyst | [roles/engineering/code-reviewer/prompt.md](roles/engineering/code-reviewer/prompt.md) | — | Structured code review with security, quality, and architecture focus |

### Health

| Role | Prompt | Variant | Description | Notes |
|------|--------|---------|-------------|-------|
| P.S.Y. — Trauma-Specialised Psychologist | [roles/health/trauma-psychologist/prompt.md](roles/health/trauma-psychologist/prompt.md) | — | Trauma-informed psychoeducation and emotional support session agent | ⚠️ See safety notes |

> **P.S.Y. safety notes:** Crisis line numbers should be verified for your target region before deployment.
> This prompt is not a substitute for licensed clinical care. See [`roles/registry.yaml`](roles/registry.yaml) for full governance details.

---

## Using a Role

### As a system prompt (API / agent framework)

```python
import anthropic, pathlib

role_prompt = pathlib.Path("roles/engineering/code-reviewer/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": "Review the attached diff..."}],
)
```

### As a paste-in session prompt

1. Open the masterprompt file and copy the content of its code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. The agent will adopt its role and guide you from there.

---

## Repository Structure

```text
roles/
├── registry.yaml                        ← Masterprompt registry (start here)
│
├── entertainment/
│   └── text-adventure/                  ← T.A.G. v2.2
│       ├── prompt.md                    ← Canonical verbose prompt
│       └── prompt-compressed.md         ← Token-efficient variant
│
├── engineering/
│   └── code-reviewer/                   ← C.R.A. v1.0
│       └── prompt.md
│
└── health/
    └── trauma-psychologist/             ← P.S.Y. v1.0
        └── prompt.md

specs/                                   ← Feature specifications (A-SDLC Stage 1 outputs)
stages/                                  ← A-SDLC stage workspaces (01–06)
a-sdlc/                                  ← Governance framework (submodule — read-only)
```

---

## Adding This Repo as a Submodule

```bash
git submodule add https://github.com/<your-org>/tag-role-test roles
git submodule update --init --recursive
```

Then reference individual masterprompts from `roles/roles/<category>/<slug>/prompt.md` in your project.

---

## Adding a New Role

1. Create a directory: `roles/<category>/<slug>/`
2. Add `prompt.md` (and an optional `prompt-compressed.md` for token-heavy prompts)
3. Add an entry to `roles/registry.yaml`
4. Open a change request via the A-SDLC intake process (see [Governance](#governance) below)

---

## Governance

This project is built using the [A-SDLC framework](https://github.com/jvanheerikhuize/a-sdlc) — an Agentic Software
Development Life Cycle defining how software is built, tested, and released when AI agents work
alongside human developers. Compliant with DORA and the EU AI Act out of the box.

### The Six Lifecycle Stages

| Stage | Name | Purpose |
|-------|------|---------|
| 1 | Intent Ingestion | Capture and structure requirements into a Feature Spec |
| 2 | System Design | Architecture, threat modelling, and technical specification |
| 3 | Coding & Implementation | Implementation with quality gates, security scans, and PR review |
| 4 | Testing & Documentation | Verification, documentation, and risk threshold evaluation |
| 5 | Deployment & Release | Production promotion with approval gates and rollback plan |
| 6 | Observability & Maintenance | Continuous monitoring — feeds back into the lifecycle |

All 50 controls (QC, RC, SC, AC, GC) from the A-SDLC framework apply.

- Framework docs: `a-sdlc/README.md`
- Agent operating instructions: `a-sdlc/AGENTS.md`
- Control registry: `a-sdlc/controls/registry.yaml`

---

## Quick Start — New Consumer Project

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

## Keeping Governance Current

```bash
git submodule update --remote a-sdlc
git add a-sdlc
git commit -m "chore: update a-sdlc governance framework"
```
