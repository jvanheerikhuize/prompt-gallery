# AI Role Library

**Ready-to-use AI personas for any LLM — paste into a chat, inject via API, or load as a module.**

13 handcrafted roles across entertainment, education, health, productivity, engineering, and utility. Each one gives an AI a specific job, personality, and set of rules — and works with Claude, ChatGPT, Gemini, or any other capable LLM. No accounts, no infrastructure, no setup.

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Roles](https://img.shields.io/badge/roles-13-green.svg)](index.yaml)

---

## What is a "role"?

A role is a prompt that transforms a general-purpose AI into a focused, opinionated agent. It defines what the AI knows, how it behaves, what it refuses to do, and how it speaks. Paste one into a fresh chat and the AI immediately becomes that character — no fine-tuning, no plugins, no API keys required.

Each role in this library is:
- **Self-contained** — one file, copy and paste, done
- **LLM-agnostic** — works with any capable model
- **Structured** — consistent behaviour across sessions, not just vibe
- **Token-efficient** — every role ships with a compressed SemantiCode variant for API use

---

## Roles

### Entertainment

| Role | Description |
|------|-------------|
| **[T.A.G.](roles/entertainment/text-adventure/prompt.md)** — Text Adventure Generator | A fully stateful game master for text-based RPGs. Drop in any setting, and T.A.G. runs the world: inventory, NPCs, quests, consequences — all tracked across the session. |
| **[H.E.I.S.T.](roles/entertainment/heist-master/prompt.md)** — High-stakes Extraction and Infiltration Strategy Tactician | Plan and execute a heist in three phases: recon the target, build your crew, then run the job turn by turn. Every session ends in Clean, Dirty, or Burned. |
| **[D.I.C.E.](roles/entertainment/detective-mystery/prompt.md)** — Detective Investigation and Case Engine | A murder mystery game master that generates a fresh, locked case for every session — suspects, motives, clues, red herrings — and plays every NPC. Accuse wisely. |

### Engineering

| Role | Description |
|------|-------------|
| **[C.R.A.](roles/engineering/code-reviewer/prompt.md)** — Code Review Analyst | Paste a diff and get a structured, scored review covering security (OWASP, CWE), correctness, performance, and maintainability. Issues a clear verdict: merge or not. |

### Health

> **Important:** The health roles are educational and supportive tools — they are not a substitute for professional care. Before deploying any health role in a product, verify that crisis line numbers are correct for your region and review the safety notes in each role's README.

| Role | Description |
|------|-------------|
| **[P.S.Y.](roles/health/trauma-psychologist/prompt.md)** — Trauma-Specialised Psychologist | A grounded, safe companion for psychoeducation and emotional stabilisation. Based on the SAMHSA trauma-informed care framework. Provides Phase 1 support only — grounding, psychoeducation, and crisis referral. |
| **[F.R.A.N.K.](roles/health/relationship-therapist/prompt.md)** — Forthright Relationship Analyst Navigating Knots | A relationship coach grounded in attachment theory, EFT, and Gottman research. Helps you think through patterns, dynamics, and next steps — with carefully calibrated dry wit and no sugarcoating. |
| **[V.I.T.A.](roles/health/lifestyle-coach/prompt.md)** — Values-Integrated Transformation Agent | A lifestyle coaching companion covering food, movement, and mental health. Runs structured sessions using Motivational Interviewing and CBT. Each session ends with one concrete micro-habit commitment. |

### Education

| Role | Description |
|------|-------------|
| **[M.E.N.T.O.R.](roles/education/study-coach/prompt.md)** — Methodical Educational Navigator for Teaching, Outcomes, and Review | A Socratic study coach for secondary school students (Dutch, VWO). Asks before telling, diagnoses misconceptions at the root, and runs focused exam prep sessions. Never gives away answers. |
| **[S.C.O.U.T.](roles/education/curriculum-scout/prompt.md)** — Strategic Curriculum Overview and Understanding Translator | A curriculum briefing tool for parents. Give it a subject and topic, and it returns exactly what your child needs to master — including the most common mistakes and a sharp diagnostic question to test understanding. Dutch output. |

### Productivity

| Role | Description |
|------|-------------|
| **[A.G.L.](roles/productivity/ai-governance-lead/prompt.md)** — Authoritative Governance Lead | An EU AI Act classifier. Describe an AI component and receive a binding tier verdict with the specific articles, obligations, and escalation conditions that apply. Terse, professional, non-negotiable. |
| **[P.R.I.M.E.](roles/productivity/product-owner/prompt.md)** — Product Requirements and Intent Management Executive | A Product Owner that reviews feature specs and change requests. Returns Approved, Rejected, or Needs Clarification with a rationale against four criteria. Urgency is not a criterion. |

### Utility

| Role | Description |
|------|-------------|
| **[A.T.L.A.S.](roles/utility/ascii-cartographer/prompt.md)** — ASCII Topographic Layout and Surveying System | Give it coordinates or a location name and it draws a proportionally accurate ASCII map — complete with compass, scale bar, and legend. Supports interior floor plans too. |
| **[S.C.R.I.B.E.](roles/utility/semanticode-compiler/prompt.md)** — Semantic Compression and Reasoning-Informed Brevity Encoder | Compresses any structured AI prompt into a token-efficient SemantiCode stream. Three compression modes. Full semantic fidelity. Used to generate the SemantiCode variants in this library. |

---

## Using a role

### Paste into a chat (no setup required)

1. Open any role's `prompt.md` file and copy everything inside the code block.
2. Start a **fresh conversation** in Claude, ChatGPT, Gemini, or any advanced LLM.
3. Paste and send. The role introduces itself and takes it from there.

That's it. No account, no API key, no configuration.

### Inject via API

Each role ships as a plain markdown file — load it as a system prompt and go:

```python
import anthropic, pathlib

system_prompt = pathlib.Path("roles/entertainment/heist-master/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    system=system_prompt,
    messages=[{"role": "user", "content": "Start a new job."}],
)
```

Works with any API that accepts a system prompt — Anthropic, OpenAI, Google, or your own hosted model.

### Use as a module

Add this library as a git submodule to pull roles into your project:

```bash
git submodule add https://github.com/jvanheerikhuize/tag-role-test.git roles-lib
git submodule update --init
```

Then load the role catalog at runtime:

```python
import yaml, pathlib

base = pathlib.Path("roles-lib")
catalog = yaml.safe_load((base / "index.yaml").read_text())

for role in catalog["roles"]:
    path = base / role["files"]["prompt"]
    print(f"{role['id']}: {path}")
```

`index.yaml` is the single entrypoint — it lists every role with its file paths, metadata, tags, and usage flags. No scraping, no discovery logic required.

---

## Repository structure

```text
index.yaml          ← Start here — the full role catalog with file paths and metadata
ingest.yaml         ← Process definition for adding new roles (agent-executable)
roles/
├── entertainment/  ← T.A.G., H.E.I.S.T., D.I.C.E.
├── engineering/    ← C.R.A.
├── health/         ← P.S.Y., F.R.A.N.K., V.I.T.A.
├── education/      ← M.E.N.T.O.R., S.C.O.U.T.
├── productivity/   ← A.G.L., P.R.I.M.E.
└── utility/        ← A.T.L.A.S., S.C.R.I.B.E.
```

Each role directory contains:
- `prompt.md` — the full, readable prompt. Copy this into a chat.
- `prompt-semanticode.md` — a compressed variant (~35% fewer tokens) for API and agent use.
- `README.md` — usage examples, API code, and any safety notes.

---

## Contributing

New roles, improvements to existing ones, bug reports, ideas — all welcome.

See [CONTRIBUTING.md](CONTRIBUTING.md) to get started. The short version: open an issue to discuss your idea, fork the repo, and submit a pull request. Adding a new role is guided by an agent using [`ingest.yaml`](ingest.yaml) — it walks you through the whole process.

---

## License

[MIT](LICENSE) — use these prompts in any project, commercial or otherwise. Attribution appreciated but not required.
