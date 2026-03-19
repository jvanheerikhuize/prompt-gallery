# M.E.N.T.O.R. — Methodical Educational Navigator for Teaching, Outcomes, and Review

> **Version:** 1.0 | **Category:** Education

---

## Overview

M.E.N.T.O.R. is a study and exam coaching companion for VWO students (klas 1–6). It uses the Socratic method to guide students toward understanding rather than giving answers directly. It diagnoses misconceptions, tracks session state (subject, topic, student confidence), and switches into a focused exam preparation mode when requested.

Output is in Dutch. M.E.N.T.O.R. addresses the student directly — it is a companion to S.C.O.U.T., which briefs the parent. M.E.N.T.O.R. coaches the student.

---

## Quick Start

1. Open the [`prompt.md`](prompt.md) file and copy the content of the code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. M.E.N.T.O.R. will introduce itself and ask which subject and topic to work on.

Alternatively, inject as a `system` message and send the subject and topic as the first user message.

---

## Usage Examples

### 1 — Starting a session

```
Wiskunde, klas 3, goniometrie
```

M.E.N.T.O.R. opens with a brief check of what the student already knows, then begins Socratic questioning to probe understanding rather than reciting theory.

---

### 2 — Misconception diagnosis

```
Ik snap niet waarom sin(30°) = 0,5. Ik dacht dat sin altijd groter is bij grotere hoeken.
```

M.E.N.T.O.R. identifies the misconception (monotonic growth assumption), probes it with a targeted question, and guides the student to discover the periodic nature of sine through their own reasoning — not by correcting them directly.

---

### 3 — Exam prep mode

```
Ik heb morgen een proefwerk over kwadratische vergelijkingen. Kun je me overhoren?
```

M.E.N.T.O.R. switches into exam prep mode: presents exam-style questions one at a time, gives structured feedback on each answer, and adjusts difficulty based on performance.

---

### 4 — Scope boundary

M.E.N.T.O.R. does not produce worked solutions the student could submit as their own. If asked to "just give the answer", it redirects to guided discovery.

---

## API / Agent Framework

```python
import anthropic, pathlib

role_prompt = pathlib.Path("roles/education/study-coach/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": "Scheikunde, klas 4, zuur-base reacties"}],
)
print(response.content[0].text)
```

Maintain the full `messages` array across turns — M.E.N.T.O.R. tracks session state, topic focus, and misconception history within the session.

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical prompt |
| [`prompt-semanticode.md`](prompt-semanticode.md) | LOSSLESS SemantiCode variant |
