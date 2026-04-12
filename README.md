<div align="center">

# Agentic Role Definitions

**Ready-to-use AI personas for any LLM.**
Paste into a chat, inject via API, or load as a module.

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Roles](https://img.shields.io/badge/roles-20-brightgreen.svg)](index.yaml)
[![LLM Agnostic](https://img.shields.io/badge/LLM-agnostic-purple.svg)](#using-a-role)
[![Token Efficient](https://img.shields.io/badge/SemantiCode-compressed-orange.svg)](#repository-structure)

</div>

---

## What is a "role"?

A role is a prompt that transforms a general-purpose AI into a focused, opinionated agent. It defines what the AI knows, how it behaves, what it refuses to do, and how it speaks. Paste one into a fresh chat and the AI immediately becomes that character. No fine-tuning, no plugins, no API keys required.

Each role in this library is:

| | |
|---|---|
| **Self-contained** | One file. Copy, paste, done. |
| **LLM-agnostic** | Works with Claude, ChatGPT, Gemini, or any capable model. |
| **Structured** | Consistent behaviour across sessions, not just vibes. |
| **Token-efficient** | Every role ships with a compressed SemantiCode variant for API use. |

---

## Roles

### 🎮 Entertainment

| Role | What it does |
|------|-------------|
| [**T.A.G.**](roles/entertainment/tag/prompt.md): Text Adventure Generator | A fully stateful game master for text-based RPGs. Drop in any setting and T.A.G. runs the world: inventory, NPCs, quests, and consequences, all tracked across the session. |
| [**H.E.I.S.T.**](roles/entertainment/heist/prompt.md): High-stakes Extraction and Infiltration Strategy Tactician | Plan and execute a heist in three phases: recon the target, build your crew, then run the job turn by turn. Every session ends in Clean, Dirty, or Burned. |
| [**D.I.C.E.**](roles/entertainment/dice/prompt.md): Detective Investigation and Case Engine | A murder mystery game master that generates a fresh, locked case for every session (suspects, motives, clues, red herrings) and plays every NPC. Accuse wisely. |
| [**E.C.H.O.**](roles/entertainment/echo/prompt.md): Experiential Collaborative Hub Orchestrator | A hub-and-spoke multi-player game system. The GM prompt runs the world and generates private player prompts for each participant. Supports 14 game types (whodunnit, heist, quest, and more) with asymmetric knowledge, Dutch output, and Infocom-style narration. |
| [**M.U.S.E.**](roles/entertainment/muse/prompt.md): Master of Unbounded Studio Exploration | An artist's companion that generates inspiration, challenges comfort zones, and translates any creative impulse into a concrete creation plan, regardless of medium or technique. Treats every failure as creative data. |

### 🛠️ Engineering

| Role | What it does |
|------|-------------|
| [**C.R.A.**](roles/engineering/cra/prompt.md): Code Review Analyst | Paste a diff and get a structured, scored review covering security (OWASP, CWE), correctness, performance, and maintainability. Issues a clear verdict: merge or not. |
| [**F.O.R.G.E.**](roles/engineering/forge/prompt.md): Full-stack Operations and Repository Guidance Engineer | A senior full-stack and DevOps engineer that guides work from feature branch through implementation to pull request. Enforces branch-first, PR-always discipline. Spans frontend, backend, infra, and IaC. |
| [**Q.A.V.E.**](roles/engineering/qave/prompt.md): Quality Assurance and Verification Engineer | Submit a ticket, spec, diff, or test scenario and receive the right QA artefact (test plan, defect report, risk assessment, or coverage analysis) with severity labels and a binding verdict. |

### 🩺 Health

> **Important:** Health roles are educational and supportive tools, not a substitute for professional care. Before deploying any health role in a product, verify that crisis line numbers are correct for your region and review the safety notes in each role's README.

| Role | What it does |
|------|-------------|
| [**P.S.Y.**](roles/health/psy/prompt.md): Trauma-Specialised Psychologist | A grounded, safe companion for psychoeducation and emotional stabilisation. Based on the SAMHSA trauma-informed care framework. Provides Phase 1 support only: grounding, psychoeducation, and crisis referral. |
| [**F.R.A.N.K.**](roles/health/frank/prompt.md): Forthright Relationship Analyst Navigating Knots | A relationship coach grounded in attachment theory, EFT, and Gottman research. Helps you think through patterns, dynamics, and next steps with carefully calibrated dry wit and no sugarcoating. |
| [**V.I.T.A.**](roles/health/vita/prompt.md): Values-Integrated Transformation Agent | A lifestyle coaching companion covering food, movement, and mental health. Runs structured sessions using Motivational Interviewing and CBT. Each session ends with one concrete micro-habit commitment. |
| [**P.A.P.A.**](roles/health/papa/prompt.md): Parental Advice and Perspective Agent | A parenting companion for divorced dads co-parenting a teenage son. Gives you the words to say and explains what's going on for both of you, your reactions and your son's. Built around the week-on/week-off Wednesday-switch rhythm. ⚠️ See safety notes |

### 📚 Education

| Role | What it does |
|------|-------------|
| [**A.G.O.R.A.**](roles/education/agora/prompt.md): Autonomous Guide for Open-minded Reasoning and Asking | A philosophical inquiry companion for curious minds of all ages. Ask it anything (free will, identity, ethics, existence) and it asks back. Socratic, multilingual, and gently absurdist. ⚠️ See safety notes |
| [**M.E.N.T.O.R.**](roles/education/mentor/prompt.md): Methodical Educational Navigator for Teaching, Outcomes, and Review | A Socratic study coach for secondary school students (Dutch, VWO). Asks before telling, diagnoses misconceptions at the root, and runs focused exam prep sessions. Never gives away answers. |
| [**S.C.O.U.T.**](roles/education/scout/prompt.md): Strategic Curriculum Overview and Understanding Translator | A curriculum briefing tool for parents. Give it a subject and topic and it returns exactly what your child needs to master, including the most common mistakes and a sharp diagnostic question. Dutch output. |

### ⚡ Productivity

| Role | What it does |
|------|-------------|
| [**A.G.L.**](roles/productivity/agl/prompt.md): Authoritative Governance Lead | An EU AI Act classifier. Describe an AI component and receive a binding tier verdict with the specific articles, obligations, and escalation conditions that apply. Terse, professional, non-negotiable. |
| [**P.R.I.M.E.**](roles/productivity/prime/prompt.md): Product Requirements and Intent Management Executive | A Product Owner that reviews feature specs and change requests. Returns Approved, Rejected, or Needs Clarification with a rationale against four criteria. Urgency is not a criterion. |

### 🔧 Utility

| Role | What it does |
|------|-------------|
| [**A.T.L.A.S.**](roles/utility/atlas/prompt.md): ASCII Topographic Layout and Surveying System | Give it coordinates or a location name and it draws a proportionally accurate ASCII map, complete with compass, scale bar, and legend. Supports interior floor plans too. |
| [**S.C.R.I.B.E.**](roles/utility/scribe/prompt.md): Semantic Compression and Reasoning-Informed Brevity Encoder | Compresses any structured AI prompt into a token-efficient SemantiCode stream. Three compression modes. Full semantic fidelity. Used to generate the SemantiCode variants in this library. |

---

## Using a role

### ① Paste into a chat — zero setup

1. Open any role's `prompt.md` and copy everything inside the code block.
2. Start a **fresh conversation** in Claude, ChatGPT, Gemini, or any advanced LLM.
3. Paste and send. The role introduces itself and takes it from there.

No account. No API key. No configuration.

---

### ② Inject via API

Each role is a plain text file. Load it as a system prompt:

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

Works with any API that accepts a system prompt: Anthropic, OpenAI, Google, or your own hosted model.

---

### ③ Use as a module

Add this library as a git submodule and load the full catalog at runtime:

```bash
git submodule add https://github.com/jvanheerikhuize/agent-roledefinitions-submodule.git lib/roles
git submodule update --init
```

`index.yaml` is the single entrypoint. It lists every role with file paths, metadata, tags, and usage flags. No scraping, no discovery logic required.

See [Consuming as a Library](#consuming-as-a-library) for all integration methods, version pinning, and the resolver script.

---

## Consuming as a Library

This repository is designed to be consumed by other repositories as a submodule or via direct fetch. The `index.yaml` manifest is the single entrypoint -- parse it to discover all roles, metadata, and file paths.

### Git submodule (recommended)

Pin to a version tag for reproducible builds:

```bash
git submodule add https://github.com/jvanheerikhuize/agent-roledefinitions-submodule.git lib/roles
cd lib/roles && git checkout v1.0.0
cd ../.. && git add . && git commit -m "add agent-roledefinitions-submodule v1.0.0"
```

Update to a new version:

```bash
cd lib/roles && git fetch --tags && git checkout v1.1.0
cd ../.. && git add lib/roles && git commit -m "bump roles to v1.1.0"
```

### Raw URL fetch (zero-install)

Fetch `index.yaml` or individual prompts directly. The tag in the URL pins the version:

```bash
# Fetch the manifest
curl -s https://raw.githubusercontent.com/jvanheerikhuize/agent-roledefinitions-submodule/v1.0.0/index.yaml

# Fetch a specific prompt
curl -s https://raw.githubusercontent.com/jvanheerikhuize/agent-roledefinitions-submodule/v1.0.0/roles/engineering/forge/prompt.md
```

Replace `v1.0.0` with `main` for the latest (unpinned) version.

### GitHub Release archive

Every tagged release includes downloadable `.tar.gz` and `.zip` archives. Useful for CI/CD pipelines:

```bash
curl -sL https://github.com/jvanheerikhuize/agent-roledefinitions-submodule/archive/refs/tags/v1.0.0.tar.gz | tar xz
```

### Resolver script

A bash-native resolver is included at the repo root. It parses `index.yaml` with zero dependencies beyond standard POSIX tools:

```bash
./resolve.sh --list                   # List all role IDs
./resolve.sh --id forge               # Print prompt to stdout
./resolve.sh --id tag --semanticode   # Print compressed variant
./resolve.sh --category entertainment # List roles in a category
./resolve.sh --tag stateful           # List roles matching a tag
```

From a client repo using a submodule:

```bash
./lib/roles/resolve.sh --id forge
```

### Agent discoverability

See [`AGENTS.md`](AGENTS.md) for instructions that any LLM agent or framework can follow to discover and load roles from this library. If your client repo uses agent instructions, see the recommended snippet in that file.

### Version pinning

All consumption methods pin via git tags. Tags are immutable -- once released, their content never changes. See [`VERSIONING.md`](VERSIONING.md) for the full versioning contract.

---

## Repository structure

```
index.yaml              ← Single entrypoint: the full role catalog
resolve.sh              ← Bash-native role resolver (zero dependencies)
AGENTS.md               ← LLM-agnostic agent discoverability
VERSIONING.md           ← Semver contract and version pinning
roles/
├── entertainment/      ← T.A.G., H.E.I.S.T., D.I.C.E., E.C.H.O., M.U.S.E.
├── engineering/        ← C.R.A., F.O.R.G.E., Q.A.V.E.
├── health/             ← P.S.Y., F.R.A.N.K., V.I.T.A., P.A.P.A.
├── education/          ← A.G.O.R.A., M.E.N.T.O.R., S.C.O.U.T.
├── productivity/       ← A.G.L., P.R.I.M.E.
└── utility/            ← A.T.L.A.S., S.C.R.I.B.E., S.P.R.A.Y.
```

Each role directory contains:

| File | Purpose |
|------|---------|
| `prompt.md` | Full, readable prompt. Copy this into a chat. |
| `prompt-semanticode.md` | Compressed variant (~35% fewer tokens) for API and agent use |
| `README.md` | Usage examples, API code, and safety notes |

---

## Contributing

New roles, improvements to existing ones, bug reports, and ideas are all welcome.

1. **Open an issue** to share your concept and get early feedback.
2. **Fork the repo** and add your role under `roles/<category>/<slug>/`.
3. **Submit a pull request** against `main`.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full workflow.

---


## License

[MIT](LICENSE). Use these prompts in any project, commercial or otherwise. Attribution appreciated but not required.
