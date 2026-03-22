# E.C.H.O. — Experiential Collaborative Hub Orchestrator

> **Version:** 1.0 | **Category:** Entertainment

---

## Overview

E.C.H.O. is a multi-player text adventure game system built on a hub-and-spoke architecture: one Game Master prompt runs the world, and the GM's LLM generates private player prompts (spokes) that each player loads into their own LLM session. The GM orchestrates, the players act, and E.C.H.O. adjudicates — all in Dutch, with the dry wit of a classic Infocom narrator.

The system supports 14 game types — whodunnit, heist, quest, conspiracy, espionage, inheritance, escape room, rebellion, expedition, diplomacy, haunted, shipwreck, tournament, and courtroom — selected by the GM or drawn at random. Each game type generates an appropriate world, assigns asymmetric roles and private knowledge to each player, and produces self-contained spoke prompts the GM distributes privately. Players never see each other's prompts.

The GM relays player actions to the hub session (`ACTIE SPELER_1: [actie]`), which evaluates outcomes against the locked world truth, updates global state, and tells the GM exactly what to send back to each player — including cascading effects on other players without leaking private information.

---

## Quick Start

1. Open [`prompt.md`](prompt.md) and copy everything inside the code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.) — this is your **GM session**.
3. Paste and send. E.C.H.O. will prompt you to configure the game. Use `/speltype WILLEKEURIG` for a random game type, or pick one from the list. Set `/spelers [N]` for the number of players.
4. Run `GENEREER SPOKE [SPELER_ID]` for each player. E.C.H.O. outputs a filled spoke prompt per player.
5. Send each spoke privately to its player. Each player pastes their spoke into their own fresh LLM session.
6. Players describe their actions to you. You relay them as `ACTIE SPELER_1: [actie]`. E.C.H.O. tells you what happened and what to send back.

---

## Usage Examples

### 1 — Start a random game for three players

```
/speltype WILLEKEURIG
/spelers 3
```

E.C.H.O. selects a game type at random (e.g. `rebellion`), generates a world with a locked truth record, assigns roles with private knowledge and objectives to each of the three players, and displays a GM-only world summary. The game type, theme, and all public facts are shown. Secret facts and the truth record are for the GM only.

---

### 2 — Generate and distribute a player spoke

```
GENEREER SPOKE SPELER_2
```

E.C.H.O. fills in the `prompt-player.md` template with SPELER_2's specific role, private knowledge, objectives, win/fail conditions, and permitted commands. The completed spoke is output as a fenced code block ready to copy and paste privately to that player's LLM session.

---

### 3 — Adjudicate a player action

```
ACTIE SPELER_1: Ik doorzoek de archiefkast in de kelder.
```

E.C.H.O. evaluates the action against the world state, updates any relevant facts, and returns: what actually happened, the exact text to relay back to SPELER_1, and whether any other players are affected — without leaking their private information.

---

### 4 — Inject a world event mid-session

```
/gebeurtenis De stroom valt uit in het hele gebouw.
```

E.C.H.O. applies the event to the world state, updates public facts, and provides the GM with per-player distribution instructions — a message for all players plus any private updates for specific players whose situation is affected differently.

---

## API / Agent Framework

```python
import anthropic, pathlib

# GM session — load the hub prompt
gm_prompt = pathlib.Path("roles/entertainment/echo/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-opus-4-6",
    system=gm_prompt,
    messages=[{"role": "user", "content": "/speltype WILLEKEURIG\n/spelers 3"}],
)
print(response.content[0].text)
```

E.C.H.O. is **stateful** — preserve the full `messages` array across turns so the GM session retains world state. Player spoke sessions are independent stateful instances; preserve their `messages` arrays separately. The `prompt-player.md` template is filled by the GM's LLM, not loaded directly.

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | GM hub prompt — canonical full-length version |
| [`prompt-player.md`](prompt-player.md) | Player spoke template — filled by the GM's LLM per player |
| [`prompt-semanticode.md`](prompt-semanticode.md) | LOSSLESS SemantiCode variant of the GM prompt (compiled by S.C.R.I.B.E.) |
