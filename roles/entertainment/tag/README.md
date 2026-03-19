# T.A.G. — Text Adventure Generator

> **Version:** 2.2 | **Category:** Entertainment

---

## Overview

T.A.G. is a stateful, LLM-powered text adventure game master. It generates an immersive, logically consistent world and tracks state across the full session — inventory, location, NPC relationships, discovered lore, and world rules. Tone is classic Infocom: dry wit, precise description, no hand-holding.

T.A.G. runs entirely in a single LLM chat session. No external tools or infrastructure required.

---

## Quick Start

1. Open the [`prompt.md`](prompt.md) file and copy the content of the code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. T.A.G. will introduce the world and await your first action.

---

## Usage Examples

### 1 — Starting the game

After loading the prompt, T.A.G. opens with a scene introduction. No input required to start — just wait for the first room description and then act.

```
> look
```

T.A.G. will describe your surroundings in detail. Classic verb-noun commands work: `look`, `go north`, `take sword`, `talk to innkeeper`, `inventory`.

---

### 2 — Exploring and interacting

```
> examine the locked chest
> use iron key on chest
> take the map inside
```

T.A.G. maintains consistent world state. If you pick up an item, it is gone from the room. If you break a lock, it stays broken. NPC reactions evolve based on prior interactions.

---

### 3 — Dialogue and lore

```
> ask the old wizard about the dark forest
```

T.A.G. generates contextually aware dialogue. NPCs have opinions, secrets, and consistent personalities. Asking the same NPC twice will yield consistent answers (or deliberate evasion if appropriate).

---

### 4 — Failure states

T.A.G. does not prevent death or failure. If you attack a guard in a fortified castle with a butter knife, you will lose. The game enforces consequence — this is by design.

```
> attack the castle guard
```

T.A.G. will narrate the outcome faithfully, including game-over conditions if applicable.

---

## API / Agent Framework

```python
import anthropic, pathlib

role_prompt = pathlib.Path("roles/entertainment/text-adventure/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": "look"}],
)
print(response.content[0].text)
```

**Note:** T.A.G. is stateful. When using the API, maintain the full `messages` array across turns to preserve game state. Do not start a new session mid-game.

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical verbose masterprompt (recommended) |
| [`prompt-semanticode.md`](prompt-semanticode.md) | LOSSLESS SemantiCode variant |
