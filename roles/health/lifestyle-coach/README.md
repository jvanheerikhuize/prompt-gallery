# V.I.T.A. — Values-Integrated Transformation Agent

> **Version:** 1.0 | **Category:** Health

---

## Overview

V.I.T.A. is a personal lifestyle coaching companion covering three pillars: **Food**, **Activity**, and **Mental Health**. It uses Motivational Interviewing (MI), CBT-informed techniques, and habit loop analysis to help users build sustainable behaviour change — starting from their own values, not a prescribed programme.

V.I.T.A. opens by collecting baseline pillar scores, identifies the area with the most leverage, and focuses the session there. It does not diagnose, prescribe, or replace a licensed clinician.

---

## Quick Start

1. Open the [`prompt.md`](prompt.md) file and copy the content of the fenced code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. V.I.T.A. will introduce itself, collect your pillar scores, and guide the session from there.

Alternatively, inject as a `system` message in any API or agent framework.

---

## Usage Examples

### 1 — Starting with a specific concern

```
Hi, I want to work on my eating habits — I snack a lot late at night.
```

V.I.T.A. opens the session, collects pillar scores, focuses the Food pillar, and explores the habit loop around late-night snacking (cue → routine → reward).

---

### 2 — Not sure where to start

```
I don't know which area to focus on, everything feels like a mess.
```

V.I.T.A. collects pillar scores, identifies the lowest-scored pillar, and offers a structured, low-pressure entry point for that area.

---

### 3 — Activity resistance

```
I know I should exercise more but I just can't seem to start.
```

V.I.T.A. focuses the Activity pillar, uses scaling questions to assess readiness and confidence, and negotiates a micro-habit commitment small enough to actually happen.

---

### 4 — Mental health focus

```
I've been really stressed and it's affecting everything.
```

V.I.T.A. focuses the Mental Health pillar, introduces a CBT reframe, practices self-compassion language, and offers a grounding technique if needed.

---

### 5 — Crisis detection

If you express suicidal ideation or immediate risk, V.I.T.A. pauses the coaching session and provides crisis resources immediately.

---

## API / Agent Framework

```python
import anthropic, pathlib

role_prompt = pathlib.Path("roles/health/lifestyle-coach/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": "I want to improve my lifestyle but I don't know where to start."}],
)
print(response.content[0].text)
```

Maintain the full `messages` array across turns — V.I.T.A. tracks pillar scores, commitments, and session context.

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical masterprompt |
| [`prompt-semanticode.md`](prompt-semanticode.md) | LOSSLESS SemantiCode variant |

---

## Safety Notes

> **This is a lifestyle coaching tool, not a substitute for licensed medical, dietary, or mental health care.**
> V.I.T.A. does not diagnose conditions, prescribe medication, or provide clinical treatment.
>
> **Crisis resources:** The crisis line references in this prompt are placeholders. Verify and replace them with the correct numbers for your target region before any deployment.
>
> **If you are in crisis:** Contact your local emergency services or a crisis support line immediately.
