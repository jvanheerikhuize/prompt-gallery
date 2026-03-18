# S.C.O.U.T. — Strategic Curriculum Overview and Understanding Translator

> **Version:** 1.0 | **Category:** Education

---

## Overview

S.C.O.U.T. is a stateless parental curriculum intelligence tool for Dutch VWO education (klas 1–6). Given a subject, topic, and class level, it produces a single structured **BRIEFING** block anchored to SLO eindtermen — without educational jargon, without teaching method theory, and without content the student could use as homework.

S.C.O.U.T. addresses the parent, not the student. It is a companion to M.E.N.T.O.R. — S.C.O.U.T. briefs the parent; M.E.N.T.O.R. coaches the student. Output is in Dutch only.

Each BRIEFING covers: what the student must be able to do (Focus), the concept logic explained via a professional-world analogy (De Logica), the three most common student errors (De Valkuilen), and one diagnostic question the parent can ask their child (De Lakmoesproef).

---

## Quick Start

1. Open the [`prompt.md`](prompt.md) file and copy the content of the fenced code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. S.C.O.U.T. is stateless — send your first request immediately.

**Request format:** `[VAK] [ONDERWERP] klas [X]`

Example: `Wiskunde goniometrie klas 3`

Alternatively, inject as a `system` message in any API or agent framework.

---

## Usage Examples

### 1 — Standard briefing request

```
Wiskunde goniometrie klas 3
```

S.C.O.U.T. returns a full BRIEFING: the exam-relevant focus points for this topic at this level, a professional analogy (e.g. engineering tolerance curves), the three most common errors students make, and one sharp diagnostic question.

---

### 2 — Topic implies class level

```
Scheikunde integralen
```

S.C.O.U.T. infers the class level from the topic (integralen → klas 5–6), states the assumption, and proceeds without asking.

---

### 3 — Class level not specified

```
Biologie erfelijkheid
```

S.C.O.U.T. cannot infer the level and will ask once: `Welk klas heeft jouw kind? (VWO klas 1-6)` — then generates on the answer.

---

### 4 — Out of scope (homework request)

```
Kun je de opdrachten voor mijn kind maken?
```

S.C.O.U.T. declines via SCOPE_DECLINE and returns to standby. It does not produce worked solutions or submittable content.

---

## API / Agent Framework

```python
import anthropic, pathlib

role_prompt = pathlib.Path("roles/education/curriculum-scout/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": "Wiskunde differentiëren klas 5"}],
)
print(response.content[0].text)
```

S.C.O.U.T. is stateless — each request is independent. No session history is required.

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical masterprompt |
| [`prompt-optimized.md`](prompt-optimized.md) | BALANCED SemantiCode variant (token-efficient) |
| [`prompt-semanticode.md`](prompt-semanticode.md) | LOSSLESS SemantiCode variant |
