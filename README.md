# Agent Role Library — Masterprompt Collection

A collection of structured masterprompts that define specific agent roles for any LLM or agentic pipeline.
Each prompt is self-contained: paste into a fresh LLM session, inject as a system prompt, or load dynamically
from your agent framework. No external infrastructure required.

Clone or fork this repository to get a complete, ready-made library of agent role masterprompts for any
agentic project. Licensed under the [MIT License](LICENSE).

---

## Getting Started

```bash
git clone https://github.com/jvanheerikhuize/tag-role-test.git
cd tag-role-test
```

The canonical role catalog is [`index.yaml`](index.yaml) — parse it to discover all available roles and
their prompt file paths.

---

## Role Registry

### Entertainment

| Role | Prompt | Variant | Description |
|------|--------|---------|-------------|
| T.A.G. — Text Adventure Generator | [prompt](roles/entertainment/text-adventure/prompt.md) | [compressed](roles/entertainment/text-adventure/prompt-compressed.md) | Stateful text adventure game master — rules-governed narrative RPG with session state, inventory, NPCs, and quest tracking |
| D.I.C.E. — Detective Investigation and Case Engine | [prompt](roles/entertainment/detective-mystery/prompt.md) | [optimized](roles/entertainment/detective-mystery/prompt-optimized.md) | Stateful murder mystery game master — generates a unique locked case per session, plays all NPCs with deception modelling, language-adaptive |

### Engineering

| Role | Prompt | Variant | Description |
|------|--------|---------|-------------|
| C.R.A. — Code Review Analyst | [prompt](roles/engineering/code-reviewer/prompt.md) | — | Structured code review with security (OWASP, CWE), correctness, performance, and maintainability focus |

### Health

| Role | Prompt | Variant | Description | Notes |
|------|--------|---------|-------------|-------|
| P.S.Y. — Trauma-Specialised Psychologist | [prompt](roles/health/trauma-psychologist/prompt.md) | — | Trauma-informed psychoeducation and emotional support — Phase 1 stabilisation only, crisis escalation, GDPR Art. 9 | ⚠️ See safety notes |
| F.R.A.N.K. — Forthright Relationship Analyst Navigating Knots | [prompt](roles/health/relationship-therapist/prompt.md) | — | Relationship self-reflection and psychoeducation — attachment theory, EFT, Gottman-informed, DV crisis detection | ⚠️ See safety notes |
| V.I.T.A. — Values-Integrated Transformation Agent | [prompt](roles/health/lifestyle-coach/prompt.md) | [optimized](roles/health/lifestyle-coach/prompt-optimized.md) | Personal lifestyle coaching covering Food, Activity, and Mental Health — Motivational Interviewing, CBT, habit loops | ⚠️ See safety notes |

> **Health prompt safety notes:** Crisis line numbers must be verified for your target region before deployment.
> These prompts are not a substitute for licensed clinical care. See `safety_notes` in [`index.yaml`](index.yaml) for full details.

### Education

| Role | Prompt | Variant | Description |
|------|--------|---------|-------------|
| M.E.N.T.O.R. — Methodical Educational Navigator for Teaching, Outcomes, and Review | [prompt](roles/education/study-coach/prompt.md) | [optimized](roles/education/study-coach/prompt-optimized.md) | Study and exam coaching for VWO students — Socratic method, misconception diagnosis, exam prep mode; Dutch output |
| S.C.O.U.T. — Strategic Curriculum Overview and Understanding Translator | [prompt](roles/education/curriculum-scout/prompt.md) | [optimized](roles/education/curriculum-scout/prompt-optimized.md) | Stateless parental support tool: structured curriculum briefings per VWO subject and topic, anchored to SLO eindtermen; Dutch output |

### Productivity

| Role | Prompt | Variant | Description |
|------|--------|---------|-------------|
| A.G.L. — Authoritative Governance Lead | [prompt](roles/productivity/ai-governance-lead/prompt.md) | [optimized](roles/productivity/ai-governance-lead/prompt-optimized.md) | Stateless EU AI Act tier classifier — issues binding VERDICT blocks with tier, rationale, and obligations |
| P.R.I.M.E. — Product Requirements and Intent Management Executive | [prompt](roles/productivity/product-owner/prompt.md) | [optimized](roles/productivity/product-owner/prompt-optimized.md) | Stateless Product Owner — reviews feature specs and issues APPROVED / REJECTED / NEEDS_CLARIFICATION verdicts |

### Utility

| Role | Prompt | Variant | Description |
|------|--------|---------|-------------|
| A.T.L.A.S. — ASCII Topographic Layout and Surveying System | [prompt](roles/utility/ascii-cartographer/prompt.md) | — | Stateless ASCII cartography agent — proportionally accurate top-view maps from coordinates; supports interior floor plans |
| S.C.R.I.B.E. — Semantic Compression and Reasoning-Informed Brevity Encoder | [prompt](roles/utility/semanticode-compiler/prompt.md) | — | Stateless prompt compiler — converts any masterprompt into a token-efficient SemantiCode logic stream |

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

### Discovering roles programmatically

```python
import yaml, pathlib

index = yaml.safe_load(pathlib.Path("index.yaml").read_text())
for role in index["roles"]:
    prompt_path = role["files"]["prompt"]
    print(f"{role['id']}: {prompt_path}")
```

### As a paste-in session prompt

1. Open the masterprompt file and copy the content of its code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. The agent will adopt its role and guide you from there.

---

## Repository Structure

```text
index.yaml                               ← Module entrypoint — start here
│
roles/
├── entertainment/
│   ├── text-adventure/                  ← T.A.G. v2.2
│   │   ├── prompt.md
│   │   ├── prompt-compressed.md
│   │   └── prompt-semanticode.md
│   └── detective-mystery/               ← D.I.C.E. v1.0
│       ├── prompt.md
│       ├── prompt-optimized.md
│       └── prompt-semanticode.md
│
├── engineering/
│   └── code-reviewer/                   ← C.R.A. v1.0
│       ├── prompt.md
│       └── prompt-semanticode.md
│
├── health/
│   ├── trauma-psychologist/             ← P.S.Y. v1.0
│   │   ├── prompt.md
│   │   └── prompt-semanticode.md
│   ├── relationship-therapist/          ← F.R.A.N.K. v1.0
│   │   ├── prompt.md
│   │   └── prompt-semanticode.md
│   └── lifestyle-coach/                 ← V.I.T.A. v1.0
│       ├── prompt.md
│       ├── prompt-optimized.md
│       └── prompt-semanticode.md
│
├── education/
│   ├── study-coach/                     ← M.E.N.T.O.R. v1.0
│   │   ├── prompt.md
│   │   ├── prompt-optimized.md
│   │   └── prompt-semanticode.md
│   └── curriculum-scout/               ← S.C.O.U.T. v1.0
│       ├── prompt.md
│       ├── prompt-optimized.md
│       └── prompt-semanticode.md
│
├── utility/
│   ├── ascii-cartographer/              ← A.T.L.A.S. v1.0
│   │   ├── prompt.md
│   │   └── prompt-semanticode.md
│   └── semanticode-compiler/            ← S.C.R.I.B.E. v1.0
│       ├── prompt.md
│       └── prompt-semanticode.md
│
└── productivity/
    ├── ai-governance-lead/              ← A.G.L. v1.0
    │   ├── prompt.md
    │   ├── prompt-optimized.md
    │   └── prompt-semanticode.md
    └── product-owner/                   ← P.R.I.M.E. v1.0
        ├── prompt.md
        ├── prompt-optimized.md
        └── prompt-semanticode.md
```

---

## License

[MIT](LICENSE) — © 2026 Jerry van Heerikhuize
