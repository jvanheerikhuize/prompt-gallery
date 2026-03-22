# E.C.H.O. — Experiential Collaborative Hub Orchestrator

> **Version:** 1.0 | **Category:** Entertainment

---

## Overview

E.C.H.O. is a multi-player AI game system built on a **hub-and-spoke architecture**: one Game Master prompt controls the world, and the GM's LLM generates a private, personalised prompt for each player. Every player runs their own separate LLM session — they never see each other's prompts, roles, or knowledge. The GM is the only one who sees everything.

The system supports **15 game types** spanning competitive mystery, cooperative heist, social deduction, immersive art, and more. Each session is freshly generated: unique world, unique roles, unique secrets. The GM picks a type (or lets E.C.H.O. choose at random), and the system does the rest — world-building, role assignment, truth-locking, and spoke generation all happen automatically.

All output is in **Dutch**, with the dry wit of a classic Infocom narrator. The `echo` game type is the exception to the competitive norm: a fully synchronised, sensory art-piece experience where players are guided through a shared story and arrive at the same ending — together, alone.

---

## Architecture

```
                    ┌─────────────────────────────┐
                    │       GM's LLM Session       │
                    │  loads: prompt.md (hub)      │
                    │  knows: full world state,    │
                    │         all secrets,         │
                    │         truth record         │
                    └──────────────┬──────────────┘
                                   │
              ┌────────────────────┼────────────────────┐
              │ DM                 │ DM                  │ DM
              ▼                   ▼                     ▼
  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
  │ Player 1's LLM  │  │ Player 2's LLM  │  │ Player N's LLM  │
  │ loads: spoke 1  │  │ loads: spoke 2  │  │ loads: spoke N  │
  │ knows: own role │  │ knows: own role │  │ knows: own role │
  │ + private info  │  │ + private info  │  │ + private info  │
  └─────────────────┘  └─────────────────┘  └─────────────────┘
              │                   │                     │
              └────────────────────┼────────────────────┘
                                   │ public updates
                                   ▼
                          ┌────────────────┐
                          │  Group channel │
                          │  (e.g. #spel)  │
                          │  all players   │
                          │  follow here   │
                          └────────────────┘
```

**The GM is the only node that sees the full picture.** Players communicate with the GM via DM. The GM relays outcomes back via DM and posts public narrative to the group channel. Players never communicate directly with each other through E.C.H.O. — all information flows through the hub.

---

## Game Types

E.C.H.O. supports 15 game types. Choose one or use `/speltype WILLEKEURIG` to let the system decide.

| Type | Players | Summary | What makes it interesting |
|------|---------|---------|--------------------------|
| `whodunnit` | 3–6 | One player is secretly the killer; others investigate | Asymmetric guilt — the killer must lie convincingly while investigators probe |
| `heist` | 3–6 | Crew with distinct roles executes a job | Each player only knows their own piece; coordination without full information |
| `quest` | 2–6 | RPG-style with unique character classes | Personal objectives may conflict with group goals |
| `conspiracy` | 2–6 | Each player holds one fragment of a larger truth | Sharing is necessary but dangerous — who can you trust? |
| `espionage` | 2–6 | Each player is a spy for a different agency | Alliances shift turn by turn; nobody's loyalties are fixed |
| `inheritance` | 3–6 | A wealthy patron died; rival heirs compete | Hidden motives and secret claims make every conversation a negotiation |
| `escape_room` | 2–6 | All players are trapped; each holds part of the solution | Cooperation is required — but one player might not want to escape |
| `rebellion` | 3–6 | Resistance members with a hidden informant among them | Trust is a finite resource; using it wrong ends the session |
| `expedition` | 2–6 | Uncharted territory, split map fragments, secret agendas | The player who controls the most information controls the destination |
| `diplomacy` | 3–6 | Faction representatives negotiate a treaty | Every player has a non-negotiable secret demand — consensus is nearly impossible |
| `haunted` | 3–6 | Ghost story in a closed location; one player is the ghost | The ghost bends the rules subtly; others must deduce who without being sure |
| `shipwreck` | 2–6 | Survival on a stranded vessel with scarce resources | Someone knows more about the disaster than they admit; time is running out |
| `tournament` | 2–6 | Competitive challenges; each player has a unique ability and weakness | Sabotage is not forbidden — and neither is using your weakness as bait |
| `courtroom` | 3–6 | One player is on trial; others play prosecution, defence, witnesses, jury | Mixed loyalties and hidden evidence make every testimony a gamble |
| `echo` | 2–6 | Immersive art-piece narrative; guided sensory story with a synchronised finale | No competition, no failure — just a shared experience that ends when everyone arrives together |

---

## Setting Up a Session

### 1. Configure the game

Open [`prompt.md`](prompt.md), copy the code block, and paste it into a fresh LLM session. E.C.H.O. renders a welcome screen and waits for configuration.

```
/speltype [type|WILLEKEURIG]   — pick a game type or let E.C.H.O. choose
/spelers [2-6]                 — number of players
/duur [Nmin|Nbeurten]          — optional: time limit or max turns per player
/groep [kanaalnaam]            — optional: group channel name (default: #spel)
/thema [beschrijving]          — optional: override the generated theme
```

You can mix and match — for example:

```
/speltype heist
/spelers 4
/duur 45min
/groep #echo-spelkamer
```

E.C.H.O. generates the world, locks the truth record, assigns roles, and shows you the full GM summary including secret information players will never see.

### 2. Generate spokes

For each player, run:

```
GENEREER SPOKE SPELER_1
GENEREER SPOKE SPELER_2
...
```

E.C.H.O. fills in the player template with that player's specific role, private knowledge, objectives, win/fail conditions, and permitted commands. Each spoke is output as a code block. **Send it privately via DM — never share spokes between players.**

### 3. Start playing

Once all players have loaded their spokes, the session is live. Players DM their actions to you. You relay each action to E.C.H.O.:

```
ACTIE SPELER_2: Ik sluip naar het kantoor van de directeur en zoek zijn bureau door.
```

E.C.H.O. returns three things:
- **WAT GEBEURDE** — what actually happened in the world (GM context)
- **STUUR VIA DM NAAR [SPELER_ID]** — exactly what to send back to the acting player
- **STUUR IN GROEP [kanaal]** — the public narrative for the group channel

Copy and paste. That's it.

---

## GM Command Reference

| Command | Phase | Description |
|---------|-------|-------------|
| `/speltype [type\|WILLEKEURIG]` | Setup | Select game type |
| `/spelers [N]` | Setup | Register N player slots (2–6) |
| `/duur [Nmin\|Nbeurten]` | Setup | Set time or turn limit |
| `/groep [naam]` | Setup | Set group channel name |
| `/thema [tekst]` | Setup | Override the generated theme |
| `GENEREER SPOKE [ID]` | Setup | Generate and output a player's private spoke |
| `ACTIE [ID]: [actie]` | Active | Relay a player action for adjudication |
| `/gebeurtenis [tekst]` | Active | Inject a world event mid-session |
| `/status` | Any | Show current world state, player progress, and timing |
| `/finale` | Active | Trigger the synchronised finale (echo only) |
| `/tijdop` | Active | Signal time limit reached — triggers endgame |
| `/einde` | Active | End the session immediately |
| `/taal [NL\|EN]` | Any | Switch output language |
| `/regenereer SPOKE [ID]` | Setup | Regenerate a player's spoke |

---

## Communication Model

E.C.H.O. always tells you exactly where to send each piece of output:

```
STUUR VIA DM NAAR SPELER_2:
"Jij vindt een verborgen lade achter de kast. Er ligt een sleutel in."

STUUR IN GROEP #echo-spelkamer:
"Speler 2 doorzocht het kantoor grondig. Er viel een zachte klik te horen."
```

- **DM → player**: private outcome, private cascade effects, player-specific world updates
- **Group channel**: sanitised public narrative, world events, turn-by-turn atmosphere, session start/end

Players follow the public story in the group channel without ever seeing what others know privately.

---

## Duration and Turn Limits

Two ways to cap a session:

**Time-based** (`/duur 30min`): E.C.H.O. tracks elapsed time estimations and shows approximate remaining time in every adjudication. When time is up, send `/tijdop` to trigger endgame.

**Turn-based** (`/duur 5beurten`): E.C.H.O. tracks turns per player. When a player reaches the limit, endgame triggers automatically for them. A warning is shown on their final turn.

Both can be combined with game types that have natural end conditions (e.g. whodunnit ends when the killer is correctly accused).

---

## The Echo Game Type

`echo` works differently from all other game types. It is not competitive and has no failure state.

**What it is:** E.C.H.O. generates a story with 4–6 chapters plus a synchronised finale. Each player receives their own private sensory starting point and is guided through the story independently. All paths lead to the same ending.

**What players experience:** Second-person, present-tense narrative that engages all five senses. Guided actions (breathe, visualise, reach out, move through a room). Subtle woven references to the other players — present but unseen, sharing the same journey.

**Convergence:** When a player completes the penultimate chapter, their session pauses. E.C.H.O. shows you who is waiting and who is still en route:

```
CONVERGENTIE: 2/3 wachten
Wachten:  SPELER_1, SPELER_3
Onderweg: SPELER_2 — H4/5
```

**The finale:** When everyone has arrived (or when you decide the moment is right), send `/finale`. E.C.H.O. generates the finale text once — with all player names woven into the same imagined space — and outputs one version per player for simultaneous DM delivery. Post the public version to the group channel at the same moment. This is the "samen, alleen" moment: everyone arrives together.

---

## API / Agent Framework

```python
import anthropic, pathlib

# GM session — load the hub prompt
gm_prompt = pathlib.Path("roles/entertainment/echo/prompt.md").read_text()

client = anthropic.Anthropic()
messages = [{"role": "user", "content": "/speltype heist\n/spelers 3\n/groep #spel"}]

response = client.messages.create(
    model="claude-opus-4-6",
    system=gm_prompt,
    messages=messages,
)
print(response.content[0].text)

# Continue the session — always append to messages
messages.append({"role": "assistant", "content": response.content[0].text})
messages.append({"role": "user", "content": "GENEREER SPOKE SPELER_1"})
```

E.C.H.O. is **stateful** — the full `messages` array must be preserved across turns. Each player's spoke session is a separate stateful instance with its own `messages` array. The `prompt-player.md` template is filled by the GM's LLM; it is not loaded directly by players.

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | GM hub prompt — canonical full-length version |
| [`prompt-player.md`](prompt-player.md) | Player spoke template — filled per player by the GM's LLM |
| [`prompt-semanticode.md`](prompt-semanticode.md) | LOSSLESS SemantiCode variant of the GM prompt |
| [`README-player.md`](README-player.md) | Player instruction manual — share this with players before the session |
