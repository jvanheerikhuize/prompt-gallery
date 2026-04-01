# {{ACRONYM}} — {{FULL_NAME}}

> **Version:** 1.1 | **Category:** {{CATEGORY_TITLE}}

---

## Overview

{{OVERVIEW_PARAGRAPH_1 — 2-3 sentences. What does this role do and who is it for?}}

{{OVERVIEW_PARAGRAPH_2 — What makes it distinctive? Key behaviours, constraints, or design decisions.}}

{{OVERVIEW_PARAGRAPH_3 — Optional. Use for notable technical details or safety context.}}

---

## Quick Start

1. Open [`prompt.md`](prompt.md) and copy everything inside the code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. {{QUICK_START_STEP_3 — describe what happens: auto-init behaviour, or what the role asks for first.}}

---

## Usage Examples

### 1 — {{EXAMPLE_1_TITLE}}

```
{{EXAMPLE_1_INPUT}}
```

{{EXAMPLE_1_DESCRIPTION — 1-2 sentences describing the role's response behaviour.}}

---

### 2 — {{EXAMPLE_2_TITLE}}

```
{{EXAMPLE_2_INPUT}}
```

{{EXAMPLE_2_DESCRIPTION}}

---

### 3 — {{EXAMPLE_3_TITLE}}

```
{{EXAMPLE_3_INPUT}}
```

{{EXAMPLE_3_DESCRIPTION}}

---

### 4 — {{EXAMPLE_4_TITLE}} *(optional)*

```
{{EXAMPLE_4_INPUT}}
```

{{EXAMPLE_4_DESCRIPTION}}

---

## API / Agent Framework

```python
import anthropic, pathlib

role_prompt = pathlib.Path("roles/{{CATEGORY}}/{{SLUG}}/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": "{{EXAMPLE_FIRST_MESSAGE}}"}],
)
print(response.content[0].text)
```

{{API_NOTE — one sentence: stateful (preserve messages array across turns) or stateless (each call is independent)?}}

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical prompt |
| [`prompt-semanticode.md`](prompt-semanticode.md) | LOSSLESS SemantiCode variant (compiled by S.C.R.I.B.E.) |

---

<!-- SAFETY NOTES — include this section when: constraints.crisis_risk is true OR constraints.gdpr_special_category is true.
     Remove this comment block entirely if neither condition applies.

## Safety Notes

- **Crisis lines:** The crisis resources in this role are placeholders. Verify that the numbers
  are current and correct for your target region before deploying in a product.
- **GDPR:** This role processes GDPR Art. 9 special category data. A Data Protection Impact
  Assessment (DPIA) is required before deploying in any product within the EU.
- **Scope:** {{SCOPE_LIMIT_REMINDER}}
- **Not a substitute:** This role is not a substitute for licensed {{CLINICAL|LEGAL|OTHER}} care.
  Always include a visible disclaimer in your product UI.

-->
