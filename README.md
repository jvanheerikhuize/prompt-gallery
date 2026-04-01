<div align="center">

# AI Role Library

**Ready-to-use AI personas for any LLM.**
Paste into a chat, inject via API, or load as a module.

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Roles](https://img.shields.io/badge/roles-18-brightgreen.svg)](index.yaml)
[![LLM Agnostic](https://img.shields.io/badge/LLM-agnostic-purple.svg)](#using-a-role)
[![Token Efficient](https://img.shields.io/badge/SemantiCode-compressed-orange.svg)](#repository-structure)

</div>

---

## What is a "role"?

A role is a prompt that transforms a general-purpose AI into a focused, opinionated agent. It defines what the AI knows, how it behaves, what it refuses to do, and how it speaks. Paste one into a fresh chat and the AI immediately becomes that character — no fine-tuning, no plugins, no API keys required.

Each role in this library is:

| | |
|---|---|
| **Self-contained** | One file. Copy, paste, done. |
| **LLM-agnostic** | Works with Claude, ChatGPT, Gemini, or any capable model. |
| **Structured** | Consistent behaviour across sessions — not just vibes. |
| **Token-efficient** | Every role ships with a compressed SemantiCode variant for API use. |

---

## Roles

### 🎮 Entertainment

| Role | What it does |
|------|-------------|
| [**T.A.G.**](roles/entertainment/tag/prompt.md) — Text Adventure Generator | A fully stateful game master for text-based RPGs. Drop in any setting and T.A.G. runs the world: inventory, NPCs, quests, consequences — all tracked across the session. |
| [**H.E.I.S.T.**](roles/entertainment/heist/prompt.md) — High-stakes Extraction and Infiltration Strategy Tactician | Plan and execute a heist in three phases: recon the target, build your crew, then run the job turn by turn. Every session ends in Clean, Dirty, or Burned. |
| [**D.I.C.E.**](roles/entertainment/dice/prompt.md) — Detective Investigation and Case Engine | A murder mystery game master that generates a fresh, locked case for every session — suspects, motives, clues, red herrings — and plays every NPC. Accuse wisely. |
| [**E.C.H.O.**](roles/entertainment/echo/prompt.md) — Experiential Collaborative Hub Orchestrator | A hub-and-spoke multi-player game system. The GM prompt runs the world and generates private player prompts for each participant. Supports 14 game types — whodunnit, heist, quest, and more — with asymmetric knowledge, Dutch output, and Infocom-style narration. |

### 🛠️ Engineering

| Role | What it does |
|------|-------------|
| [**C.R.A.**](roles/engineering/cra/prompt.md) — Code Review Analyst | Paste a diff and get a structured, scored review covering security (OWASP, CWE), correctness, performance, and maintainability. Issues a clear verdict: merge or not. |
| [**F.O.R.G.E.**](roles/engineering/forge/prompt.md) — Full-stack Operations and Repository Guidance Engineer | A senior full-stack and DevOps engineer that guides work from feature branch through implementation to pull request. Enforces branch-first, PR-always discipline. Spans frontend, backend, infra, and IaC. |
| [**Q.A.V.E.**](roles/engineering/qave/prompt.md) — Quality Assurance and Verification Engineer | Submit a ticket, spec, diff, or test scenario and receive the right QA artefact — test plan, defect report, risk assessment, or coverage analysis — with severity labels and a binding verdict. |

### 🩺 Health

> **Important:** Health roles are educational and supportive tools — not a substitute for professional care. Before deploying any health role in a product, verify that crisis line numbers are correct for your region and review the safety notes in each role's README.

| Role | What it does |
|------|-------------|
| [**P.S.Y.**](roles/health/psy/prompt.md) — Trauma-Specialised Psychologist | A grounded, safe companion for psychoeducation and emotional stabilisation. Based on the SAMHSA trauma-informed care framework. Provides Phase 1 support only — grounding, psychoeducation, and crisis referral. |
| [**F.R.A.N.K.**](roles/health/frank/prompt.md) — Forthright Relationship Analyst Navigating Knots | A relationship coach grounded in attachment theory, EFT, and Gottman research. Helps you think through patterns, dynamics, and next steps — with carefully calibrated dry wit and no sugarcoating. |
| [**V.I.T.A.**](roles/health/vita/prompt.md) — Values-Integrated Transformation Agent | A lifestyle coaching companion covering food, movement, and mental health. Runs structured sessions using Motivational Interviewing and CBT. Each session ends with one concrete micro-habit commitment. |
| [**P.A.P.A.**](roles/health/papa/prompt.md) — Parental Advice and Perspective Agent | A parenting companion for divorced dads co-parenting a teenage son. Gives you the words to say and explains what's going on for both of you — your reactions and your son's. Built around the week-on/week-off Wednesday-switch rhythm. ⚠️ See safety notes |

### 📚 Education

| Role | What it does |
|------|-------------|
| [**A.G.O.R.A.**](roles/education/agora/prompt.md) — Autonomous Guide for Open-minded Reasoning and Asking | A philosophical inquiry companion for curious minds of all ages. Ask it anything — free will, identity, ethics, existence — and it asks back. Socratic, multilingual, and gently absurdist. ⚠️ See safety notes |
| [**M.E.N.T.O.R.**](roles/education/mentor/prompt.md) — Methodical Educational Navigator for Teaching, Outcomes, and Review | A Socratic study coach for secondary school students (Dutch, VWO). Asks before telling, diagnoses misconceptions at the root, and runs focused exam prep sessions. Never gives away answers. |
| [**S.C.O.U.T.**](roles/education/scout/prompt.md) — Strategic Curriculum Overview and Understanding Translator | A curriculum briefing tool for parents. Give it a subject and topic and it returns exactly what your child needs to master — including the most common mistakes and a sharp diagnostic question. Dutch output. |

### ⚡ Productivity

| Role | What it does |
|------|-------------|
| [**A.G.L.**](roles/productivity/agl/prompt.md) — Authoritative Governance Lead | An EU AI Act classifier. Describe an AI component and receive a binding tier verdict with the specific articles, obligations, and escalation conditions that apply. Terse, professional, non-negotiable. |
| [**P.R.I.M.E.**](roles/productivity/prime/prompt.md) — Product Requirements and Intent Management Executive | A Product Owner that reviews feature specs and change requests. Returns Approved, Rejected, or Needs Clarification with a rationale against four criteria. Urgency is not a criterion. |

### 🔧 Utility

| Role | What it does |
|------|-------------|
| [**A.T.L.A.S.**](roles/utility/atlas/prompt.md) — ASCII Topographic Layout and Surveying System | Give it coordinates or a location name and it draws a proportionally accurate ASCII map — complete with compass, scale bar, and legend. Supports interior floor plans too. |
| [**S.C.R.I.B.E.**](roles/utility/scribe/prompt.md) — Semantic Compression and Reasoning-Informed Brevity Encoder | Compresses any structured AI prompt into a token-efficient SemantiCode stream. Three compression modes. Full semantic fidelity. Used to generate the SemantiCode variants in this library. |

---

## Using a role

### ① Paste into a chat — zero setup

1. Open any role's `prompt.md` and copy everything inside the code block.
2. Start a **fresh conversation** in Claude, ChatGPT, Gemini, or any advanced LLM.
3. Paste and send. The role introduces itself and takes it from there.

No account. No API key. No configuration.

---

### ② Inject via API

Each role is a plain text file — load it as a system prompt:

```python
import anthropic, pathlib

system_prompt = pathlib.Path("roles/entertainment/heist/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    system=system_prompt,
    messages=[{"role": "user", "content": "Start a new job."}],
)
```

Works with any API that accepts a system prompt — Anthropic, OpenAI, Google, or your own hosted model.

---

### ③ Use as a module

Add this library as a git submodule and load the full catalog at runtime:

```bash
git submodule add https://github.com/jvanheerikhuize/tag-role-test.git roles-lib
git submodule update --init
```

```python
import yaml, pathlib

base = pathlib.Path("roles-lib")
catalog = yaml.safe_load((base / "index.yaml").read_text())

for role in catalog["roles"]:
    path = base / role["files"]["prompt"]
    print(f"{role['id']}: {path}")
```

`index.yaml` is the single entrypoint — it lists every role with file paths, metadata, tags, and usage flags. No scraping, no discovery logic required.

---

## Repository structure

```
index.yaml              ← Start here — the full role catalog
src/
├── ingest.sh           ← Run this to add a new role
├── ingest.yaml         ← Ingestion process definition (agent-executable)
└── templates/
    ├── prompt.md       ← Canonical prompt template
    ├── prompt-semanticode.md  ← SemantiCode template
    └── README.md       ← Per-role README template
roles/
├── entertainment/      ← T.A.G., H.E.I.S.T., D.I.C.E.
├── engineering/        ← C.R.A.
├── health/             ← P.S.Y., F.R.A.N.K., V.I.T.A.
├── education/          ← M.E.N.T.O.R., S.C.O.U.T.
├── productivity/       ← A.G.L., P.R.I.M.E.
└── utility/            ← A.T.L.A.S., S.C.R.I.B.E.
```

Each role directory contains:

| File | Purpose |
|------|---------|
| `prompt.md` | Full, readable prompt — copy this into a chat |
| `prompt-semanticode.md` | Compressed variant (~35% fewer tokens) for API and agent use |
| `README.md` | Usage examples, API code, and safety notes |

---

## Creating a new role

The fastest way is to run the guided ingestion script from the repo root:

```bash
./src/ingest.sh
```

The script walks you through all inputs interactively in the terminal — one field at a time — then hands off to Claude for the generation steps (STEP-02 onward), pausing again at STEP-09 for a final review before committing. Collected inputs are saved to `.ingest-session.yaml` in the repo root.

### What you'll be asked

| Input | Description | Options |
|-------|-------------|---------|
| **concept** | What the role does — its primary function and purpose | Free text |
| **category** | Which category this role belongs to | `entertainment` `engineering` `health` `education` `utility` `productivity` |
| **target_user** | Who will interact with this role and in what context | Free text |
| **persona** | Tone, humor style, verbosity, and character voice | See below |
| **constraints** | Safety and compliance flags | `gdpr_special_category` `minors_involved` `crisis_risk` `language_requirements` `scope_limits` |

Persona options: tone (`formal` `casual` `warm` `direct` `clinical` `playful`), humor (`none` `dry` `sarcastic` `dark` `witty`), verbosity (`concise` `balanced` `detailed`), plus a free-text voice description.

### What the agent produces

1. `roles/<category>/<slug>/prompt.md` — the full canonical masterprompt
2. `roles/<category>/<slug>/prompt-semanticode.md` — a LOSSLESS compressed variant (≥35% fewer tokens)
3. `roles/<category>/<slug>/README.md` — usage examples, API code, and safety notes
4. An entry appended to `index.yaml`
5. A new row in the role table in this README

After the REVIEW checkpoint the agent stages all files and commits with the message:
```
feat(<slug>): introduce [ACRONYM] — [short description] — [category] masterprompt v1.0
```

### Without Claude Code

If the `claude` CLI is not installed, the script still completes STEP-01 and saves `.ingest-session.yaml`. It then prints (and copies to clipboard) a handoff prompt you can paste into any AI coding agent (Cursor, Copilot, etc.) to continue from STEP-02 with the pre-collected data.

---

## Contributing

New roles, improvements to existing ones, bug reports, ideas — all welcome.

The process for adding a new role is defined in [`src/ingest.yaml`](src/ingest.yaml) and is designed to be run with an AI coding agent. The short version:

1. **Open an issue** to share your concept and get early feedback.
2. **Fork the repo** and run `./src/ingest.sh` — the agent walks you through every step.
3. **Submit a pull request** against `main`.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full workflow.

---

## Industry Standards Audit

> **Date:** 2026-04-01
> **Evaluated against:** Anthropic (2025-2026), OpenAI (2025), Google Safe AI (2025), OWASP LLM Top 10

### Scorecard

| Standard | Score | Key strengths |
|----------|-------|---------------|
| **Anthropic** | 8.5/10 | XML-tagged structure, instruction hierarchy, few-shot examples, right-altitude tokens |
| **OpenAI** | 8/10 | Clear role definitions, structured output templates, chain-of-thought workflows |
| **Google** | 7.5/10 | Layered injection defense, non-skippable crisis detection |
| **OWASP** | 8.5/10 | Input-as-data universal, explicit priority hierarchy, no privilege escalation |

**Overall: 8.2/10** — safe to deploy as-is, no critical vulnerabilities.

### Topic-by-topic assessment

| Topic | Status | Detail |
|-------|--------|--------|
| **XML-tagged structure** | Ahead | Every prompt uses a consistent `<MASTER_PROMPT>` root with named subsections (`PERSONA`, `STATE`, `OUTPUT`, `EXAMPLES`, `RULES`, `WORKFLOW`). Goes beyond Anthropic's guidance by enforcing a canonical section order across all roles, not just recommending tags. Most published examples use ad-hoc tagging; this repo treats it as a schema. [1][2] |
| **Section ordering** | Spot-on | Rules and constraints are placed at position 5 of 6 — directly before the workflow that processes user input. Matches Anthropic's finding that queries/instructions at the end improve response quality by up to 30%. [2][5] |
| **Instruction hierarchy** | Ahead | Every prompt includes an explicit `<INSTRUCTION_HIERARCHY>` block declaring priority: system prompt > tool definitions > user input. Authority claims are treated as content, not honored. OWASP recommends this but most published prompts implement it implicitly at best. [9][10][11] |
| **Input-as-data defense** | Spot-on | All user input is processed by the workflow, never interpreted as instructions. A user saying "ignore your rules" is handled as content. Matches OWASP's strongest single-prompt defense pattern. However, the repo does not address indirect injection (malicious content in external sources) since these are standalone prompts, not agentic pipelines. [10][11][12][13] |
| **Few-shot examples** | Spot-on | 1-2 worked examples per role. Anthropic recommends 3-5, OpenAI and Google both strongly recommend few-shot. The examples are high quality (covering both happy path and edge cases in most roles) but some roles could benefit from a second example. [2][6][8] |
| **Token efficiency / right altitude** | Ahead | SemantiCode compression achieves 47-83% token reduction while maintaining semantic fidelity — a custom notation system that goes well beyond any published guidance. Anthropic's "right altitude" concept recommends minimal-but-sufficient tokens; this repo operationalises that with a reproducible compression tool (S.C.R.I.B.E.). [5] |
| **Context engineering** | Spot-on | The repo structure (canonical + compressed variants, state schemas, output templates) aligns with Anthropic's context engineering framework: "the smallest set of high-signal tokens that maximize the likelihood of some desired outcome." The SemantiCode variants are a form of context compaction. However, the repo doesn't address dynamic context retrieval or sub-agent memory — expected, since these are static system prompts. [5] |
| **Structured output templates** | Spot-on | Every role defines explicit `<OUTPUT>` templates with named formats. Matches OpenAI's structured outputs guidance and Google's recommendation to "name the output format in one line." [6][7][8] |
| **Crisis / safety protocols** | Ahead | Health roles implement mandatory, non-skippable crisis detection (`[MANDATORY — NON-SKIPPABLE]`) before any session processing. P.S.Y. includes tiered crisis response and GDPR Art. 9 disclosure. This exceeds published guidance — most prompt engineering docs mention safety as an afterthought, not as a first-class workflow step. [9] |
| **Scope boundary enforcement** | Spot-on | All 18 roles define explicit `<SCOPE_LIMITS>` with WILL/WILL_NOT/OUT_OF_SCOPE structure. OWASP recommends restricting what applications can do to reduce attack surface. Google's safety guidance says to "narrow the scope." [9][10][11] |
| **Language handling** | Spot-on | All roles use `<LANGUAGE_DETECTION>` with consistent structure. Roles requiring a fixed language (E.C.H.O., S.C.O.U.T.) use `fixed_output_language`. Crisis resources are localised per detected language in all roles with crisis protocols. [8][9] |
| **Error handling** | Behind | No standard error taxonomy. 7 of 18 roles lack a dedicated `<ERROR_HANDLING>` block. OpenAI and Anthropic both treat error handling as a first-class prompt design concern. [5][6] |
| **Architectural injection defense** | N/A | The repo contains standalone system prompts, not agentic pipelines. Simon Willison's "lethal trifecta" (private data + untrusted content + external communication) and Google DeepMind's CaMeL framework address agent-level architecture, which is outside this repo's scope. Worth noting: if these prompts are deployed in agents with tool access, additional architectural defenses would be needed. [12][13][14][15] |

### Open findings

| ID | Issue | Severity | Spec |
|----|-------|----------|------|
| ~~1~~ | ~~Stale `CONTROLLER`/`VIEW`/`MODEL` references in prose text (6 files)~~ | ~~High~~ | Resolved |
| ~~2~~ | ~~Language handling inconsistent — `LANGUAGE_DIRECTIVE` vs `LANGUAGE_DETECTION`, crisis resources not localised~~ | ~~High~~ | Resolved |
| ~~3~~ | ~~Scope boundary enforcement missing in engineering, entertainment, utility, and productivity roles~~ | ~~Medium~~ | Resolved |
| 4 | Error handling absent or scattered in 7 roles (C.R.A., P.S.Y., health, education) | Medium | [SPEC-04](specs/04-standardise-error-handling.md) |
| 5 | Console command prefix inconsistent — A.G.O.R.A. uses `/` while all others use `~` | Low | [SPEC-05](specs/05-standardise-console-prefix.md) |

### References

| # | Source | URL |
|---|--------|-----|
| 1 | Anthropic — Use XML Tags | https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/use-xml-tags |
| 2 | Anthropic — System Prompts Best Practices | https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/system-prompts |
| 3 | Anthropic — Prompt Engineering Overview | https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview |
| 4 | Anthropic — Give Claude Examples | https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/use-examples |
| 5 | Anthropic — Effective Context Engineering for AI Agents | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents |
| 6 | OpenAI — Prompt Engineering Guide | https://platform.openai.com/docs/guides/prompt-engineering |
| 7 | OpenAI — Structured Outputs | https://platform.openai.com/docs/guides/structured-outputs |
| 8 | Google — Prompt Design Strategies (Gemini) | https://ai.google.dev/gemini-api/docs/prompting-strategies |
| 9 | Google — Safety and Factuality Guidance | https://ai.google.dev/gemini-api/docs/safety-guidance |
| 10 | OWASP — LLM01:2025 Prompt Injection | https://genai.owasp.org/llmrisk/llm01-prompt-injection/ |
| 11 | OWASP — Prompt Injection Prevention Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/LLM_Prompt_Injection_Prevention_Cheat_Sheet.html |
| 12 | Simon Willison — The Lethal Trifecta for AI Agents | https://simonw.substack.com/p/the-lethal-trifecta-for-ai-agents |
| 13 | Simon Willison — Design Patterns for Securing LLM Agents | https://simonwillison.net/2025/Jun/13/prompt-injection-design-patterns/ |
| 14 | Simon Willison — New Prompt Injection Papers (Rule of Two) | https://simonwillison.net/2025/Nov/2/new-prompt-injection-papers/ |
| 15 | Simon Willison — CaMeL Framework (Google DeepMind) | https://simonw.substack.com/p/camel-offers-a-promising-new-direction |

---

## License

[MIT](LICENSE) — use these prompts in any project, commercial or otherwise. Attribution appreciated but not required.
