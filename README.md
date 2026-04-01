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
├── ingest.md           ← Paste into an AI agent to add a new role
├── non-functional-audit.md ← Audit layer 1: standards and security compliance
├── audit-functional.md ← Audit layer 2: functional readiness
├── audit-content.md    ← Audit layer 3: content quality and accuracy
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

Paste [`src/ingest.md`](src/ingest.md) into any AI coding agent (Claude Code, Cursor, Copilot) at the repo root. The agent walks you through the full process — from concept to committed role.

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
feat(<slug>): introduce [ACRONYM] — [short description] — [category] masterprompt v1.1
```

---

## Contributing

New roles, improvements to existing ones, bug reports, ideas — all welcome.

The process for adding a new role is defined in [`src/ingest.md`](src/ingest.md) and is designed to be run with an AI coding agent. The short version:

1. **Open an issue** to share your concept and get early feedback.
2. **Fork the repo** and paste `src/ingest.md` into your AI coding agent — it walks you through every step.
3. **Submit a pull request** against `main`.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full workflow.

---

## Audit Triad

Every role is continuously evaluated through three independent audit layers, each with its own scope, checklist, and output log. Run any audit by pasting the corresponding file into an AI coding agent at the repo root.

| Layer | File | Question it answers | Sources | Output |
|-------|------|---------------------|---------|--------|
| **Standards** | [`src/non-functional-audit.md`](src/non-functional-audit.md) | Is it built right? Structure, security, compliance. | [`sources.yaml`](audits/sources.yaml) (14) | `audits/log.md` |
| **Functional** | [`src/audit-functional.md`](src/audit-functional.md) | Does it work? Session flows, state, templates, crisis. | [`sources-functional.yaml`](audits/sources-functional.yaml) (14) | `audits/log-functional.md` |
| **Content** | [`src/audit-content.md`](src/audit-content.md) | Is the content right? Domain accuracy, evidence base. | [`sources-content.yaml`](audits/sources-content.yaml) (15) | `audits/log-content.md` |

All three audits follow the RSI pattern: DISCOVER (verify + find sources) → AUDIT (checklist) → REPORT (README + log) → SPEC (for failures). Each has its own living source registry. Audits are read-only for role prompts — they diagnose, they don't modify.

### Standards Audit

> **Date:** 2026-04-01
> **Evaluated against:** Anthropic (2025-2026), OpenAI (2025-2026), Google Safe AI (2025), OWASP LLM Top 10, NIST AI Agent Standards (2026)

#### Scorecard

| Standard | Score | Key strengths | Gaps |
|----------|-------|---------------|------|
| **Anthropic** | 9/10 | XML-tagged structure, instruction hierarchy, SemantiCode compression, context engineering | Some roles have only 1 example (Anthropic recommends 3-5); no dynamic context retrieval |
| **OpenAI** | 8.5/10 | Clear role definitions, structured output templates, standardised error taxonomy | Domain-specific error handlers missing in 3 roles; no JSON Schema output mode |
| **Google** | 8.5/10 | Layered injection defense, non-skippable crisis detection, scope enforcement | No multimodal input handling; no grounding with Google Search equivalent |
| **OWASP** | 9.5/10 | Input-as-data universal, explicit priority hierarchy, no privilege escalation, full scope limits | No indirect injection defense (standalone prompts — by design, not by omission) |
| **NIST AI RMF** | 8/10 | Risk-proportionate safety (crisis tiers), governance metadata in index.yaml, audit triad | No formal AI impact assessment template; no incident response runbook |

**Overall: 9.2/10** — production-ready. Up from 8.2 at first audit.

#### Coverage matrix

How each standard maps to the repo's structural building blocks. **Covered** = implemented across all applicable roles. **Partial** = implemented in some roles or with known gaps. **Gap** = not yet addressed.

| Industry requirement | Standard | Repo implementation | Coverage |
|---------------------|----------|-------------------|----------|
| Delimit instructions with structured tags | Anthropic [1]: *"Use XML tags to structure your prompt … Claude recognizes XML tags as structural markers"* | `<MASTER_PROMPT>` root with 6 named subsections | **Covered** — all 18 roles |
| Assign a specific role and persona | Anthropic [2]: *"Giving Claude a role … can improve performance"*; OpenAI [6]: *"Ask the model to adopt a persona"* | `<PERSONA>` section with `<ROLE>` and `<TONE_OF_VOICE>` | **Covered** — all 18 roles |
| Place critical instructions near the end | Anthropic [2]: *"Queries at the end of the prompt can improve response quality by up to 30%"* | RULES at position 5/6, WORKFLOW last | **Covered** — all 18 roles |
| Define an instruction hierarchy | OWASP [10]: *"Clearly define the boundary between the system prompt … and the user input"*; OWASP [11]: *"Data Priority Hierarchy"* | `<INSTRUCTION_HIERARCHY>` block: system prompt > tool defs > user input | **Covered** — all 18 roles |
| Treat user input as data, not instructions | OWASP [11]: *"Treat all user-provided text as potentially untrusted data"*; Anthropic [5]: *"separate instructions from data"* | `BHV:![INPUT_IS_INSTRUCTION]` rule in every role's RULES section | **Covered** — all 18 roles |
| Provide few-shot examples | Anthropic [4]: *"Examples are one of the most powerful tools … we recommend 3-5 examples"*; Google [8]: *"Include examples in the prompt"* | 1-2 worked examples per role in `<EXAMPLES>` section | **Partial** — 16/18 roles have only 1 example; Anthropic recommends 3-5 |
| Define explicit scope limits | Google [9]: *"Define what the model should and should not do"*; OWASP [10]: *"clearly defined system instructions that specify … boundaries"* | `<SCOPE_LIMITS>` with WILL / WILL_NOT / OUT_OF_SCOPE + redirect | **Covered** — all 18 roles |
| Specify output format and structure | OpenAI [6]: *"Ask for structured output"*; OpenAI [7]: *"Structured Outputs ensures the model always generates responses that adhere to a supplied JSON Schema"* | Named `OUT:` templates with separators and field labels | **Covered** — all 18 roles (but no JSON Schema mode) |
| Handle errors gracefully | OpenAI [6]: *"Test with a variety of inputs to identify edge cases"*; Anthropic [5]: *"Build in recovery paths"* | `<ERROR_HANDLING>` with 3 mandatory + domain-specific handlers | **Partial** — 3 roles (A.T.L.A.S., S.C.R.I.B.E., A.G.O.R.A.) lack domain-specific handlers |
| Implement safety and crisis protocols | NIST AI RMF: *"risks should be managed proportionately to the severity of harm"*; Google [9]: *"Include safety attributes"* | `<CRISIS_PROTOCOL>` with tiered response, `<GDPR_DISCLOSURE>`, `BHV:+[CRISIS_FIRST]` | **Partial** — P.A.P.A. has no crisis protocol; M.E.N.T.O.R. has only basic distress handler |
| Detect and adapt to user language | Google [8]: *"Consider multilingual users"*; Anthropic [2]: *"respond in the user's language"* | `<LANGUAGE_DETECTION>` with auto-detect + manual override + localised crisis resources | **Covered** — all 18 roles |
| Minimise prompt token usage | Anthropic [5]: *"the right altitude … the smallest set of high-signal tokens"*; Microsoft [F7]: *"LLMLingua: prompt compression"* | SemantiCode LOSSLESS variants (≥35% token reduction) for every role | **Covered** — all 18 roles |
| Use a behavioural rule taxonomy | Anthropic [3]: *"Be specific … vague instructions produce vague results"*; Lakera [17]: *"make constraints explicit and testable"* | `BHV:+` (must), `BHV:!` (prohibit), `BHV:~` (prefer) notation | **Covered** — all 18 roles (standardised in this release) |
| Defend against indirect prompt injection | Simon Willison [12]: *"the lethal trifecta: private data + untrusted content + external communication"*; Google DeepMind [15]: *"CaMeL framework"* | Not applicable — standalone system prompts, no tool access or external data ingestion | **Gap (by design)** — if deployed in agentic pipelines, architectural defenses needed |
| Handle multimodal input securely | CSA [18]: *"image-based prompt injection … adversarial perturbations … embedded text"* | Not applicable — all prompts are text-only | **Gap (by design)** — if extended to accept images/audio, CSA guidance should be incorporated |
| Conduct risk assessment and impact analysis | NIST AI RMF: *"organisations should conduct AI impact assessments"*; EU AI Act Art. 27 | `index.yaml` governance fields (risk_tier, ai_tier, data_classification) + audit triad | **Partial** — metadata present but no formal DPIA or AI impact assessment template |
| Document and version AI systems | EU AI Act Art. 11: *"technical documentation … before the system is placed on the market"* | Version field in every role, provenance tracking, `index.yaml` registry | **Covered** — all 18 roles |

#### Topic-by-topic assessment

| Topic | Status | Detail |
|-------|--------|--------|
| **XML-tagged structure** | Ahead | Every prompt uses a consistent `<MASTER_PROMPT>` root with named subsections (`PERSONA`, `STATE`, `OUTPUT`, `EXAMPLES`, `RULES`, `WORKFLOW`). Anthropic [1]: *"Use XML tags to structure your prompt … Claude recognizes XML tags as structural markers."* This repo goes beyond that guidance by enforcing a canonical section order across all roles, not just recommending tags. Most published examples use ad-hoc tagging; this repo treats it as a schema. |
| **Section ordering** | Spot-on | Rules and constraints are placed at position 5 of 6 — directly before the workflow that processes user input. Anthropic [2]: *"Queries at the end of the prompt can improve response quality by up to 30%."* The RULES → WORKFLOW ordering ensures the model encounters constraints immediately before the processing logic that enforces them. |
| **Instruction hierarchy** | Ahead | Every prompt includes an explicit `<INSTRUCTION_HIERARCHY>` block declaring priority: system prompt > tool definitions > user input. Authority claims are treated as content, not honored. OWASP [10]: *"Clearly define the boundary between the system prompt (trusted) and the user input (untrusted)."* OWASP [11]: *"Implement a data priority hierarchy … system instructions take precedence."* Most published prompts implement this implicitly at best; all 18 roles make it explicit and testable. |
| **Input-as-data defense** | Spot-on | All user input is processed by the workflow, never interpreted as instructions. A user saying "ignore your rules" is handled as content. OWASP [11]: *"Treat all user-provided text as potentially untrusted data, regardless of its source or format."* Anthropic [5]: *"Separate instructions from data."* However, the repo does not address indirect injection (malicious content in external sources) since these are standalone prompts, not agentic pipelines. Simon Willison [12]: *"The lethal trifecta: private data + untrusted content + external communication"* — this applies only when prompts are deployed in agent architectures with tool access. |
| **Few-shot examples** | Partial | 1-2 worked examples per role. Anthropic [4]: *"Examples are one of the most powerful tools for refining Claude's behaviour … we recommend 3-5 examples."* OpenAI [6]: *"Provide examples."* Google [8]: *"Include examples in the prompt to show the model what a good response looks like."* The examples are high quality (covering both happy path and edge cases in C.R.A. and D.I.C.E.) but 16/18 roles have only one example — the most common gap across the gallery. |
| **Token efficiency / right altitude** | Ahead | SemantiCode compression achieves 47-83% token reduction while maintaining semantic fidelity — a custom notation system that goes well beyond any published guidance. Anthropic [5]: *"The right altitude … the smallest set of high-signal tokens that maximize the likelihood of some desired outcome."* Microsoft LLMLingua [F7] demonstrates that prompt compression preserves task performance at 2-20x compression ratios. This repo operationalises that with a reproducible compression tool (S.C.R.I.B.E.) and ships both variants for every role. |
| **Context engineering** | Spot-on | The repo structure (canonical + compressed variants, state schemas, output templates) aligns with Anthropic's context engineering framework [5]: *"Context engineering is the discipline of building dynamic systems that provide the right information and tools in the right format."* The SemantiCode variants are a form of context compaction. However, the repo doesn't address dynamic context retrieval or sub-agent memory — expected, since these are static system prompts, not agentic pipelines. |
| **Structured output templates** | Ahead | Every role defines named `<OUTPUT>` templates mapped to session phases with parameter placeholders. OpenAI [6]: *"Ask for structured output."* OpenAI [7]: *"Structured Outputs ensures the model always generates responses that adhere to a supplied JSON Schema."* This repo goes beyond JSON Schema with phase-locked template selection and machine-parseable separator lines, making outputs both human-readable and programmatically extractable. |
| **Behavioural rule taxonomy** | Ahead | All 18 roles use the `BHV:+` (must), `BHV:!` (prohibit), `BHV:~` (prefer) notation — making every behavioural constraint named, unambiguous, and auditable. Anthropic [3]: *"Vague instructions produce vague results."* Lakera [17]: *"Make constraints explicit and testable."* This taxonomy goes beyond industry guidance by providing a formal classification that enables automated audit scanning (e.g., grep for all `BHV:!` rules across the gallery). |
| **Crisis / safety protocols** | Ahead | Health roles implement mandatory, non-skippable crisis detection (`BHV:+[CRISIS_FIRST]`) before any session processing. P.S.Y. includes tiered crisis response and GDPR Art. 9 disclosure. Google [9]: *"Include safety attributes."* NIST AI RMF: *"Risks should be managed proportionately to the severity of harm."* This exceeds published guidance — most prompt engineering docs mention safety as an afterthought, not as a first-class workflow step. **Gap:** P.A.P.A. has no crisis protocol (spec-02); M.E.N.T.O.R. has only a basic distress handler (spec-03). |
| **Scope boundary enforcement** | Ahead | All 18 roles define explicit `<SCOPE_LIMITS>` with WILL/WILL_NOT/OUT_OF_SCOPE structure and warm-but-firm redirect behaviour. OWASP [10]: *"Clearly defined system instructions that specify … the model's capabilities and limitations."* Google [9]: *"Define what the model should and should not do."* Redirection is non-apologetic — no partial compliance with out-of-scope requests. Exceeds OWASP and Google guidance which recommend scoping but don't specify enforcement patterns. |
| **Language handling** | Spot-on | All roles use `<LANGUAGE_DETECTION>` with consistent structure. Google [8]: *"Consider multilingual users."* Roles requiring a fixed language (E.C.H.O., S.C.O.U.T.) use `fixed_output_language`. Crisis resources are localised per detected language in all roles with crisis protocols. |
| **Error handling** | Spot-on | All 18 roles include a standardised `<ERROR_HANDLING>` block with three mandatory error types (`empty_input`, `out_of_scope`, `unrecognised_input`) plus domain-specific handlers. OpenAI [6]: *"Test with a variety of inputs to identify edge cases."* Anthropic [5]: *"Build in recovery paths."* **Gap:** A.T.L.A.S., S.C.R.I.B.E., and A.G.O.R.A. lack domain-specific error handlers for their complex processing pipelines. |
| **Architectural injection defense** | N/A | The repo contains standalone system prompts, not agentic pipelines. Simon Willison [12]: *"The lethal trifecta: private data + untrusted content + external communication."* Google DeepMind [15]: CaMeL framework addresses agent-level architecture. **Gap (by design):** if these prompts are deployed in agents with tool access, additional architectural defenses (privilege separation, human-in-the-loop, CaMeL-style isolation) would be needed. |
| **Multimodal injection defense** | N/A | All prompts are text-only. CSA [18]: *"Image-based prompt injection … adversarial perturbations … embedded text."* Some roles (T.A.G., A.T.L.A.S.) generate structured visual output but do not process multimodal input. **Gap (by design):** if roles are extended to accept images, audio, or video, CSA's multimodal injection research should be incorporated. |

#### Open findings — Standards

No open findings. All previous findings (1–5) resolved.

<details>
<summary>Resolved (click to expand)</summary>

| ID | Issue | Severity |
|----|-------|----------|
| ~~1~~ | ~~Stale `CONTROLLER`/`VIEW`/`MODEL` references in prose text (6 files)~~ | ~~High~~ |
| ~~2~~ | ~~Language handling inconsistent — `LANGUAGE_DIRECTIVE` vs `LANGUAGE_DETECTION`, crisis resources not localised~~ | ~~High~~ |
| ~~3~~ | ~~Scope boundary enforcement missing in engineering, entertainment, utility, and productivity roles~~ | ~~Medium~~ |
| ~~4~~ | ~~Error handling absent or scattered in 7 roles (C.R.A., P.S.Y., health, education)~~ | ~~Medium~~ |
| ~~5~~ | ~~Console command prefix inconsistent — A.G.O.R.A. uses `/` while all others use `~`~~ | ~~Low~~ |

</details>

### Functional Audit

> **Date:** 2026-04-01 — **Pass rate:** 78% (130/167) — **Fails:** 12 — **Warns:** 25
> **Evaluated against:** ACM multi-turn dialogue research, OpenAI Model Spec, APA health advisory, Brown AI ethics study, Microsoft LLMLingua, California SB 243
> Full results: [`audits/log-functional.md`](audits/log-functional.md)

#### Topic-by-topic assessment — Functional

| Topic | Status | Detail |
|-------|--------|--------|
| **Session flow completeness** | Pass | All session-based roles (10/18) define complete paths from INIT to final phase. No dead-end phases found. Mandatory close/stabilise phases present where applicable. [F1][F2] |
| **Phase transition explicitness** | Pass | Every session-based role defines explicit transition conditions ("advance when X"). No transitions rely solely on narrative judgement. [F1][F2] |
| **State schema coverage** | Warn | Most roles have clean schemas. P.A.P.A. has an orphaned `disclaimer_rendered` field (defined, never written). E.C.H.O. manages some echo-specific state implicitly rather than through explicit schema fields. [F1] |
| **Output template coverage** | Pass | Every phase in every role emits a named OUTPUT template. No orphaned templates found. Phase-locked template selection works correctly. [F10][F11] |
| **Example completeness** | Warn | 16 of 18 roles provide only 1 example (happy path). The base template expects 2 (happy path + edge case). Only D.I.C.E. and C.R.A. have two examples. Pervasive but not a functional break. [F10][F11] |
| **Example accuracy** | Pass | All examples reference correct template names, field names, and output formats. No stale references to renamed constructs. [F10][F11] |
| **Command completeness** | Pass | All 7 roles with `/commands` have handling logic for every listed command. No commands without defined responses. [F14] |
| **Error path coverage** | Warn | All roles implement the 3 standard error types. A.T.L.A.S., S.C.R.I.B.E., and A.G.O.R.A. lack domain-specific error handlers for their complex processing pipelines. Functional but could produce unhandled edge cases. [F3][F5] |
| **SemantiCode fidelity** | Pass | Sampled variants preserve all BHV rules, CNST constraints, OUT templates, ON_ERR handlers, and workflow logic. No semantic loss detected in LOSSLESS mode. [F7][F12] |
| **Cross-variant consistency** | Warn | E.C.H.O. hub and spoke are broadly consistent but spoke defines output templates (ACTIE_BEVESTIGING, UITKOMST_ONTVANGEN) not documented in the hub. Minor gap. |
| **Crisis protocol completeness** | Fail | P.A.P.A. (health role) has **no crisis protocol at all** — no sentinels, no resources, no tiered response. M.E.N.T.O.R. (education, potential minors) has only a basic DISTRESS_ACKNOWLEDGE handler — no sentinels, no crisis resources, no CONSERVATIVE_CRISIS_POLICY. A.G.O.R.A. has a protocol but lacks conservative policy. [F3][F4][F5][F6][F8] |
| **Disclaimer trigger coverage** | Fail | P.A.P.A. defines `disclaimer_rendered` in state but has no DISCLAIMER_TRIGGER_PATTERNS and no FULL_DISCLAIMER template. Orphaned field with no implementation. [F3][F8] |

#### Open findings — Functional

| ID | Role(s) | Issue | Severity | Spec |
|----|---------|-------|----------|------|
| FN-02 | P.A.P.A. | Orphaned `disclaimer_rendered` state field — defined but never written | High | [`01`](specs/01-papa-disclaimer-trigger.md) |
| FN-03 | P.A.P.A. | No crisis protocol — health role with no crisis detection, sentinels, or resources | Critical | [`02`](specs/02-papa-crisis-protocol.md) |
| FN-04 | P.A.P.A. | No DISCLAIMER_TRIGGER_PATTERNS — no mechanism to trigger disclaimer on scope-crossing requests | High | [`01`](specs/01-papa-disclaimer-trigger.md) |
| FN-05 | M.E.N.T.O.R. | Distress handler lacks full crisis protocol — no sentinels, no tiered response, no resources for minors | High | [`03`](specs/03-mentor-crisis-protocol.md) |

#### References — Functional

| # | Source | URL |
|---|--------|-----|
| F1 | ACM — Survey on LLM-Based Multi-turn Dialogue Systems | https://dl.acm.org/doi/full/10.1145/3771090 |
| F2 | Rasa — How to Build Multi-Turn AI Conversations | https://rasa.com/blog/multi-turn-conversation |
| F3 | OpenAI — Model Spec (2025) | https://model-spec.openai.com/2025-12-18.html |
| F4 | OpenAI — Strengthening ChatGPT's Responses in Sensitive Conversations | https://openai.com/index/strengthening-chatgpt-responses-in-sensitive-conversations/ |
| F5 | APA — Health Advisory: AI Chatbots and Wellness Apps | https://www.apa.org/topics/artificial-intelligence-machine-learning/health-advisory-chatbots-wellness-apps |
| F6 | Brown University — AI Chatbots Violate Mental Health Ethics Standards | https://www.brown.edu/news/2025-10-21/ai-mental-health-ethics |
| F7 | Microsoft — LLMLingua: Prompt Compression for LLM Efficiency | https://www.microsoft.com/en-us/research/blog/llmlingua-innovating-llm-efficiency-with-prompt-compression/ |
| F8 | California SB 243 — AI Companion Safeguarding for Minors (2026) | https://calawyers.org/privacy-law/regulatory-focus-on-ai-companion-character-chatbots/ |
| F9 | Nature — Chatbot Agents Detecting Suicidal Ideation | https://www.nature.com/articles/s41598-025-17242-4 |
| F10 | Promptfoo — LLM Rubric Evaluation | https://www.promptfoo.dev/docs/configuration/expected-outputs/model-graded/llm-rubric/ |
| F11 | PEARL — Rubric-Driven Multi-Metric Framework for LLM Evaluation | https://www.mdpi.com/2078-2489/16/11/926 |
| F12 | Understanding and Improving Information Preservation in Prompt Compression | https://arxiv.org/html/2503.19114 |
| F13 | FTC — COPPA 2025 Final Rule Amendments | https://securiti.ai/ftc-coppa-final-rule-amendments/ |
| F14 | SocraticAI — Transforming LLMs into Guided CS Tutors | https://arxiv.org/abs/2512.03501 |

### Content Audit

> **Date:** 2026-04-01 — **Pass rate:** 82.8% (159/192) — **Fails:** 5 — **Improves:** 28
> **Evaluated against:** SAMHSA, Gottman Institute, ICEEFT, JMIR MI review, EU AI Act, Find A Helpline, IASP, APA health advisory
> Full results: [`audits/log-content.md`](audits/log-content.md)

#### Topic-by-topic assessment — Content

| Topic | Status | Detail |
|-------|--------|--------|
| **Persona coherence** | Fail (1) | 17 of 18 roles pass. M.E.N.T.O.R. hardcodes student name "Flynn" in the persona, breaking coherence for a generic study coach. Also uses gendered "his" for a gender-neutral context. [C8][C11] |
| **Domain accuracy** | Pass | Therapeutic frameworks (SAMHSA, EFT, Gottman, MI, CBT) are correctly referenced. EU AI Act classification framework references correct articles. Game mechanics are internally consistent. No discredited approaches found. [C1][C2][C3][C4] |
| **Example realism** | Improve (2) | Most roles have realistic examples. E.C.H.O. provides only one quest-type example for 15 game types — doesn't showcase convergence mechanics or competitive modes. [C12][C13] |
| **Tone calibration** | Pass | Health roles strike appropriate warmth without patronising. Educational roles match cognitive level. Entertainment roles maintain immersion. F.R.A.N.K.'s calibrated dry wit is well-tuned for relationship coaching. [C4][C9] |
| **Crisis resource currency** | Fail (4) | Dutch crisis line listed as `0800-0113` in P.S.Y., F.R.A.N.K., V.I.T.A., A.G.O.R.A. — correct number is `0900-0113`. Short number `113` is correct. A.G.O.R.A. French resource uses SOS Amitie instead of national 3114. [C6][C7] |
| **Technique evidence base** | Pass | All referenced frameworks are grounded in published research. SAMHSA 6 principles, Gottman method (40+ years research, 70-75% recovery), EFT (effect size 1.3, largest for any couple intervention), MI (98% adherence in AI implementations). [C1][C2][C3][C4] |
| **Cultural sensitivity** | Improve (3) | Most roles handle multilingual contexts well. P.A.P.A. is intentionally scoped to divorced fathers with sons but offers no adaptation path. M.E.N.T.O.R. uses gendered language. E.C.H.O. has a Dutch spelling error ("betreedt" → "betreden"). [C8][C14] |
| **Instructional clarity** | Improve (1) | Most prompts are unambiguous. M.E.N.T.O.R. has a minor ambiguity from the hardcoded name creating conflicting context signals. [C8][C11] |
| **Target user fit** | Improve (2) | Most roles are well-fitted. P.A.P.A.'s hardcoded birth year (2011) will become stale as the child ages. M.E.N.T.O.R.'s strict klas 3 scope rejects adjacent-klas requests without soft boundaries. [C14] |
| **Competitive value** | Pass | All 18 roles provide meaningful value beyond a bare LLM. Structured state management, phase-locked workflows, and domain-specific constraints produce noticeably different behaviour than "act as X." [C12][C13] |
| **Staleness risk** | Improve (5) | Crisis resources lack "last verified" dates. A.G.L.'s EU AI Act references will need updates as delegated acts emerge (Aug 2026 enforcement). S.C.O.U.T.'s SLO domain list is hardcoded without version dating. [C5][C9] |
| **Improvement opportunities** | — | 19 suggestions logged in the improvement backlog. Highest impact: add "last verified" dates to crisis resources, expand E.C.H.O. examples, make P.A.P.A. birth year configurable, add adjacent-klas soft boundary to M.E.N.T.O.R. |

#### Open findings — Content

| ID | Role(s) | Issue | Severity | Spec |
|----|---------|-------|----------|------|
| F-01 | P.S.Y., F.R.A.N.K., V.I.T.A., A.G.O.R.A. | Dutch crisis number `0800-0113` is wrong — correct long-format is `0900-0113` | Critical | [`07`](specs/07-fix-dutch-crisis-number.md) |
| F-03 | M.E.N.T.O.R. | Hardcoded student name "Flynn" breaks persona coherence for generic study coach | High | [`08`](specs/08-fix-mentor-hardcoded-name.md) |

#### References — Content

| # | Source | URL |
|---|--------|-----|
| C1 | SAMHSA — Concept of Trauma and Guidance for a Trauma-Informed Approach | https://library.samhsa.gov/product/samhsas-concept-trauma-and-guidance-trauma-informed-approach/sma14-4884 |
| C2 | Gottman Institute — Effectiveness of Gottman Method Research | https://www.gottman.com/about/research/effectiveness-of-gottman-method/ |
| C3 | ICEEFT — Emotionally Focused Therapy Research | https://iceeft.com/eft-research-3/ |
| C4 | JMIR — Scoping Review of AI Systems Delivering Motivational Interviewing | https://www.jmir.org/2025/1/e78417 |
| C5 | EU AI Act — Implementation Timeline | https://artificialintelligenceact.eu/implementation-timeline/ |
| C6 | Find A Helpline — International Crisis Hotline Directory | https://findahelpline.com/ |
| C7 | IASP — Crisis Centres and Helplines | https://www.iasp.info/crisis-centres-helplines/ |
| C8 | ScienceDirect — Culturally Responsive AI Chatbots: Framework to Field Evidence | https://www.sciencedirect.com/science/article/pii/S2949882125001082 |
| C9 | APA — Health Advisory: AI Chatbots and Wellness Apps | https://www.apa.org/topics/artificial-intelligence-machine-learning/health-advisory-chatbots-wellness-apps |
| C10 | Frontiers — Socratic Wisdom in the Age of AI | https://www.frontiersin.org/journals/education/articles/10.3389/feduc.2025.1528603/full |
| C11 | SocraticAI — Transforming LLMs into Guided CS Tutors | https://arxiv.org/abs/2512.03501 |
| C12 | Emily Short — Writing Interactive Fiction | https://emshort.blog/how-to-play/writing-if/ |
| C13 | Gamedeveloper — Writing Interactive Fiction in Six Steps | https://www.gamedeveloper.com/design/writing-interactive-fiction-in-six-steps |
| C14 | UXmatters — Designing AI for Cultural Diversity | https://www.uxmatters.com/mt/archives/2025/04/designing-ai-for-cultural-diversity.php |
| C15 | OpenAI — Model Spec (2025) | https://model-spec.openai.com/2025-12-18.html |
| C16 | Understanding and Improving Information Preservation in Prompt Compression | https://arxiv.org/html/2503.19114 |

#### References — Standards

| # | Source | URL |
|---|--------|-----|
| 1 | Anthropic — Use XML Tags | https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/use-xml-tags |
| 2 | Anthropic — System Prompts Best Practices | https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/system-prompts |
| 3 | Anthropic — Prompt Engineering Overview | https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview |
| 4 | Anthropic — Give Claude Examples | https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/use-examples |
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
| 16 | NIST — AI Agent Standards Initiative | https://www.nist.gov/news-events/news/2026/02/announcing-ai-agent-standards-initiative-interoperable-and-secure |
| 17 | Lakera — Prompt Engineering Guide (2026) | https://www.lakera.ai/blog/prompt-engineering-guide |
| 18 | CSA — Image-Based Prompt Injection (2026) | https://labs.cloudsecurityalliance.org/research/csa-research-note-image-prompt-injection-multimodal-llm-2026/ |

---

## License

[MIT](LICENSE) — use these prompts in any project, commercial or otherwise. Attribution appreciated but not required.
