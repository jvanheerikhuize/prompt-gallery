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

> **Health prompt safety notes:** Crisis line numbers should be verified for your target region before deployment.
> These prompts are not a substitute for licensed clinical care. See [`roles/registry.yaml`](roles/registry.yaml) for full governance details.

### Utility

| Role | Prompt | Variant | Description |
|------|--------|---------|-------------|
| A.T.L.A.S. — ASCII Topographic Layout and Surveying System | [roles/utility/ascii-cartographer/prompt.md](roles/utility/ascii-cartographer/prompt.md) | — | Stateless ASCII cartography agent — renders proportionally accurate top-view maps from coordinates; supports interior floor plans with polygon wall rendering |

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
│   └── relationship-therapist/          ← F.R.A.N.K. v1.0
│       └── prompt.md
│
└── utility/
    └── ascii-cartographer/              ← A.T.L.A.S. v1.0
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

1. Create a directory: `roles/<category>/<slug>/`
2. Add `prompt.md` (and an optional `prompt-compressed.md` for token-heavy prompts)
3. Add an entry to `roles/registry.yaml`

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
