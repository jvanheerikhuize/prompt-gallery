# Agent Role Library — Masterprompt Collection

A collection of structured masterprompts that define specific agent roles for any LLM or agentic pipeline.
Each prompt is self-contained: paste into a fresh LLM session, inject as a system prompt, or load dynamically
from your agent framework. No external infrastructure required.

Clone or fork this repository to get a complete, ready-made library of agent role masterprompts for any
agentic project. Licensed under the [MIT License](LICENSE).

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
| F.R.A.N.K. — Forthright Relationship Analyst Navigating Knots | [roles/health/relationship-therapist/prompt.md](roles/health/relationship-therapist/prompt.md) | — | Relationship self-reflection and psychoeducation agent — attachment theory, EFT, Gottman-informed, with calibrated wit | ⚠️ See safety notes |
| V.I.T.A. — Values-Integrated Transformation Agent | [roles/health/lifestyle-coach/prompt.md](roles/health/lifestyle-coach/prompt.md) | [optimized](roles/health/lifestyle-coach/prompt-optimized.md) | Personal lifestyle coaching companion covering Food, Activity, and Mental Health — Motivational Interviewing, CBT, habit loop analysis | ⚠️ See safety notes |

> **Health prompt safety notes:** Crisis line numbers should be verified for your target region before deployment.
> These prompts are not a substitute for licensed clinical care. See [`roles/registry.yaml`](roles/registry.yaml) for full governance details.

### Education

| Role | Prompt | Variant | Description |
|------|--------|---------|-------------|
| M.E.N.T.O.R. — Methodical Educational Navigator for Teaching, Outcomes, and Review | [roles/education/study-coach/prompt.md](roles/education/study-coach/prompt.md) | [optimized](roles/education/study-coach/prompt-optimized.md) | Study and exam coaching companion for VWO students — Socratic method, misconception diagnosis, exam prep mode; Dutch output |
| S.C.O.U.T. — Strategic Curriculum Overview and Understanding Translator | [roles/education/curriculum-scout/prompt.md](roles/education/curriculum-scout/prompt.md) | [optimized](roles/education/curriculum-scout/prompt-optimized.md) | Stateless parental support tool: produces structured curriculum briefings per VWO subject and topic, anchored to SLO eindtermen; Dutch output |

### Utility

| Role | Prompt | Variant | Description |
|------|--------|---------|-------------|
| A.T.L.A.S. — ASCII Topographic Layout and Surveying System | [roles/utility/ascii-cartographer/prompt.md](roles/utility/ascii-cartographer/prompt.md) | — | Stateless ASCII cartography agent — renders proportionally accurate top-view maps from coordinates; supports interior floor plans with polygon wall rendering |
| S.C.R.I.B.E. — Semantic Compression and Reasoning-Informed Brevity Encoder | [roles/utility/semanticode-compiler/prompt.md](roles/utility/semanticode-compiler/prompt.md) | — | Stateless prompt compiler — converts any masterprompt into a token-efficient SemantiCode logic stream with three compression modes (LOSSLESS / BALANCED / AGGRESSIVE) |

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
├── health/
│   ├── trauma-psychologist/             ← P.S.Y. v1.0
│   │   └── prompt.md
│   ├── relationship-therapist/          ← F.R.A.N.K. v1.0
│   │   └── prompt.md
│   └── lifestyle-coach/                 ← V.I.T.A. v1.0
│       ├── prompt.md
│       └── prompt-optimized.md
│
├── education/
│   ├── study-coach/                     ← M.E.N.T.O.R. v1.0
│   │   ├── prompt.md
│   │   └── prompt-optimized.md
│   └── curriculum-scout/               ← S.C.O.U.T. v1.0
│       ├── prompt.md
│       └── prompt-optimized.md
│
└── utility/
    ├── ascii-cartographer/              ← A.T.L.A.S. v1.0
    │   └── prompt.md
    └── semanticode-compiler/            ← S.C.R.I.B.E. v1.0
        └── prompt.md
```

---

## Getting Started

```bash
git clone https://github.com/jvanheerikhuize/tag-role-test.git
cd tag-role-test
```

---

## Adding a New Role

New roles are introduced through a deterministic, agent-executed pipeline defined in
[`specs/DAG-new-role-creation.yaml`](specs/DAG-new-role-creation.yaml).
Open that file in any AI coding agent (Claude Code, Cursor, Copilot, etc.) and use the
prompt below. The agent reads the DAG and guides you step by step — it will not proceed
past human-approval gates without your explicit sign-off.

### Invoke the pipeline

```
Read specs/DAG-new-role-creation.yaml and execute the New Role Introduction pipeline
from node N-00. Guide me through each stage in order, pause at every human_gate, and
do not proceed until I approve.
```

### What the agent will ask you

At **N-01 (COLLECT_INPUTS)** the agent collects the following before doing any work:

| Input | Example |
|-------|---------|
| Role concept | "A negotiation coach grounded in Harvard principled negotiation" |
| Intended category | `entertainment` / `engineering` / `health` / `education` / `utility` |
| Target user | Who will interact with this role and in what context |
| Communication style | Tone (`formal` / `casual` / `warm` / `direct` / `clinical` / `playful`), humor (`none` / `dry` / `sarcastic` / `dark` / `witty`), verbosity (`concise` / `balanced` / `detailed`), and a free-text persona note describing the voice and character |
| Special constraints | GDPR sensitivity, minors, crisis risk, language requirements, etc. |

Everything else — the acronym, slug, masterprompt, SemantiCode variants, registry entry,
README update, commits, and push — is produced by the agent.

### Human gates

The pipeline has three mandatory pause points where you review and approve before work continues:

| Gate | Node | What you review |
|------|------|-----------------|
| Stage 1 approval | N-08 | Feature spec — scope, risk tier, constraints |
| Stage 2 approval | N-11 | System design and threat model |
| Stage 4 approval | N-21 | Test results and documentation completeness |
| Stage 5 acknowledgement | N-26 | Deployed files and commit confirmation |

### Pipeline output

A completed run produces:

- `roles/<category>/<slug>/prompt.md` — canonical masterprompt
- `roles/<category>/<slug>/prompt-semanticode.md` — LOSSLESS SemantiCode variant
- `roles/<category>/<slug>/prompt-optimized.md` — BALANCED SemantiCode variant
- `roles/registry.yaml` — updated with the new role entry
- `README.md` — role table and structure tree updated
- `specs/FEAT-XXXX-<slug>.yaml` — full governance record

See [`specs/DAG-new-role-creation.yaml`](specs/DAG-new-role-creation.yaml) for the complete node-by-node specification.

---

## Keeping Governance Current

This project tracks the [A-SDLC governance framework](https://github.com/jvanheerikhuize/a-sdlc) as a git
submodule. To pull in the latest framework updates:

```bash
git submodule update --remote a-sdlc
git add a-sdlc
git commit -m "chore: update a-sdlc governance framework"
```

---

## License

[MIT](LICENSE) — © 2026 Jerry van Heerikhuize
