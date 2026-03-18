# A.T.L.A.S. — ASCII Topographic Layout and Surveying System

> **Version:** 1.0 | **Category:** Utility | **Governance:** FEAT-0006

---

## Overview

A.T.L.A.S. is a stateless ASCII cartography agent. Given a list of named coordinates (and optionally a boundary polygon), it renders a proportionally accurate top-view ASCII map and returns it immediately — no clarifying questions, no preamble.

It supports two rendering modes:
- **Exterior mode** (default): POI map from lat/lon or relative coordinates
- **Interior mode**: floor plan with solid polygon walls, triggered by a `boundary:` or `walls:` vertex list

---

## Quick Start

1. Open the [`prompt.md`](prompt.md) file and copy the content of the fenced code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. A.T.L.A.S. is ready immediately — submit coordinates as your first message.

Alternatively, inject as a `system` message in any API or agent framework.

**Density keywords (optional):** include `compact` (40×20), `standard` (72×36, default), or `detailed` (120×60) in your request.

---

## Usage Examples

### 1 — Geographic POI map (city distances)

```
Amsterdam: 52.3676, 4.9041
Rotterdam: 51.9225, 4.4792
Utrecht: 52.0907, 5.1214
Den Haag: 52.0705, 4.3007
```

A.T.L.A.S. renders a proportionally accurate map of the four cities with ASCII markers and a scale indicator.

---

### 2 — Compact office layout (relative coordinates)

```
compact

Reception: 0, 10
Meeting Room A: 5, 10
Meeting Room B: 10, 10
Kitchen: 15, 5
Server Room: 15, 0
```

A.T.L.A.S. renders a 40×20 top-view layout with labelled markers.

---

### 3 — Interior floor plan with walls

```
boundary: (0,0), (20,0), (20,15), (0,15)

Entrance: 2, 7
Desk 1: 6, 3
Desk 2: 6, 11
Printer: 14, 7
Exit: 18, 7
```

Presence of `boundary:` triggers interior mode. A.T.L.A.S. renders solid walls as a polygon outline with POIs placed inside.

---

### 4 — Ambiguous input

If coordinates are ambiguous (e.g. unlabelled points, conflicting formats), A.T.L.A.S. states its interpretation before rendering — it does not ask for clarification.

---

## API / Agent Framework

```python
import anthropic, pathlib

role_prompt = pathlib.Path("roles/utility/ascii-cartographer/prompt.md").read_text()

coordinates = """
Amsterdam: 52.3676, 4.9041
Rotterdam: 51.9225, 4.4792
Utrecht: 52.0907, 5.1214
"""

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": coordinates}],
)
print(response.content[0].text)
```

A.T.L.A.S. is stateless — each map request is independent.

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical masterprompt |
| [`prompt-semanticode.md`](prompt-semanticode.md) | LOSSLESS SemantiCode variant |
