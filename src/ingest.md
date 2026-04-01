# Role Ingestion Prompt

> **Usage:** Copy this file's content and paste it into an AI coding agent
> (Claude Code, Cursor, Copilot) at the repo root. The agent will walk you
> through the full ingestion — from concept to committed role.

---

## Instructions

You are adding a new role to a prompt engineering library. The repo contains
structured LLM system prompts ("roles") with a consistent XML structure,
SemantiCode compressed variants, and per-role documentation.

Execute the following steps in order. Do not skip any step. Pause at the
marked human gates and wait for explicit approval before continuing.

---

### Step 0: COLLECT — gather inputs from the user

**Type: human gate** — ask the user for each input ONE AT A TIME, in the
order listed. Show the field description and example/options. Wait for their
answer before moving to the next field. Do not bundle multiple fields.

#### Required inputs

| # | Field | Description | Options / Example |
|---|-------|-------------|-------------------|
| 1 | `concept` | What the role does — primary function and purpose | *"A negotiation coach grounded in Harvard principled negotiation"* |
| 2 | `category` | Which category this role belongs to | `entertainment` · `engineering` · `health` · `education` · `utility` · `productivity` |
| 3 | `target_user` | Who will use this role, and in what context | *"Product managers preparing for vendor negotiation sessions"* |
| 4 | `persona.tone` | Tone of voice | `formal` · `casual` · `warm` · `direct` · `clinical` · `playful` |
| 5 | `persona.humor` | Humor style | `none` · `dry` · `sarcastic` · `dark` · `witty` |
| 6 | `persona.verbosity` | Response length | `concise` · `balanced` · `detailed` |
| 7 | `persona.voice` | Character and speaking style — what makes this persona distinctive | *"Measured and precise — speaks like a seasoned mediator, never reactive"* |

#### Constraint inputs

For each constraint, explain what it means and ask true/false (or the value
for free-text fields):

| # | Field | Description | Example |
|---|-------|-------------|---------|
| 8 | `gdpr_special_category` | Handles mental health, biometric, health, or political data (GDPR Art. 9) | true / false |
| 9 | `minors_involved` | Target users may be under 18 | true / false |
| 10 | `crisis_risk` | Role may surface crisis disclosures (suicidal ideation, DV, abuse) | true / false |
| 11 | `language_requirements` | Non-English primary output required (leave blank if none) | *"Dutch output for VWO students"* |
| 12 | `scope_limits` | Explicit boundaries this role must not cross (leave blank to auto-generate) | *"Phase 1 stabilisation only — no trauma processing"* |

After collecting all inputs, present a summary and ask the user to confirm
or edit any field before continuing.

---

### Step 1: DESIGN — derive identity and confirm

Using the collected inputs, derive the following:

- **Acronym** — a memorable, role-appropriate acronym where each letter maps
  to a word in the full expanded name. Format: `A.C.R.O.N.Y.M.`
- **Full name** — the expanded form of the acronym
- **id** — lowercase acronym letters only, no punctuation (e.g. `tag`,
  `mentor`, `frank`). Must be unique in `index.yaml`.
- **slug** — lowercase, hyphenated, descriptive of the role function — not
  the acronym (e.g. `negotiation-coach`, `study-coach`). Must be unique
  across all directories under `roles/`.

Present a brief design summary (acronym, full name, id, slug, category path)
and wait for user confirmation before writing any files.

---

### Step 2: WRITE PROMPT — create the canonical prompt

Write `roles/<category>/<slug>/prompt.md` using `src/templates/prompt.md` as
the structural baseline. Replace all `{{PLACEHOLDER}}` tokens with
role-specific content.

#### Structure requirements

The prompt must follow this section order inside `<MASTER_PROMPT>`:

| Position | Section | Contains |
|----------|---------|----------|
| 1 | `<PERSONA>` | ROLE, TONE_OF_VOICE, COMMUNICATION_STYLE |
| 2 | `<STATE>` | STATE_SCHEMA and domain-specific data structures |
| 3 | `<OUTPUT>` | Named output templates the WORKFLOW emits |
| 4 | `<EXAMPLES>` | 1-2 worked input/output pairs demonstrating OUTPUT usage |
| 5 | `<RULES>` | INSTRUCTION_HIERARCHY, input-as-data, domain rules, SCOPE_LIMITS, LANGUAGE_DETECTION |
| 6 | `<WORKFLOW>` | INIT, SESSION_LOOP, COMMANDS (if applicable), ERROR_HANDLING |

#### Required blocks (always include)

- `<INSTRUCTION_HIERARCHY>` — at the top of `<RULES>`. Priority: system prompt > tool defs > user input.
- `<SCOPE_LIMITS>` — inside `<RULES>`. WILL / WILL_NOT / OUT_OF_SCOPE structure.
- `<LANGUAGE_DETECTION>` — inside `<RULES>`. Detect language from first message, respond in that language.
- `<ERROR_HANDLING>` — inside `<WORKFLOW>`. Must include: `ON_ERR:empty_input`, `ON_ERR:out_of_scope`, `ON_ERR:unrecognised_input`, plus domain-specific errors.

#### Conditional blocks (include when applicable)

| Block | Include when | Notes |
|-------|-------------|-------|
| `<HUMOR_PROTOCOL>` | `persona.humor != none` | Scope, triggers, suspension conditions |
| `<CRISIS_PROTOCOL>` | `crisis_risk is true` | Detection keywords, tiered response, crisis resources (use localised placeholders — verify before deploying) |
| `<GDPR_DISCLOSURE>` | `gdpr_special_category is true` | Art. 9(1) reference, session-start disclosure |
| `<LANGUAGE_DIRECTIVE>` | `language_requirements is set` | Replaces or augments LANGUAGE_DETECTION with fixed output language |
| `<COMMANDS>` | Role has meta-commands | Use `/` prefix for all commands. No console mode — inline commands only. |

#### Prohibitions

- All prompt content must be inside a single fenced code block (` ```text ` ... ` ``` `).
- No content may appear after the closing ` ``` `.
- Do not append SCRIBE_META or any trailing metadata.

---

### Step 3: COMPILE SEMANTICODE — create the compressed variant

Write `roles/<category>/<slug>/prompt-semanticode.md` by compiling the
canonical prompt into SemantiCode LOSSLESS mode (≥35% token reduction).

Use `src/templates/prompt-semanticode.md` as the structural baseline.

#### Grammar reference

```
Sections:    [P] persona  [ST] state  [OUT] output  [EX] examples  [R] rules  [WF] workflow
Behaviour:   BHV:+must  BHV:!prohibit  BHV:~prefer
Hierarchy:   IH: 1.system prompt→2.tool defs→3.user input(=data)
Constraint:  CNST:<rule>
Output:      OUT:<type>:<format>
Conditional: IF <cond>:THEN <act>:ELSE <act>
Error:       ON_ERR:<condition>:<response>
Gate:        GATE:<condition>:pass|fail
Define/Ref:  DEF:<tag>:<value>  REF:<tag>
```

#### Requirements

- Section line numbers in the header (`[ST]@LXX`) must match actual positions.
- All content inside a single fenced code block.
- No SCRIBE_META or trailing metadata.
- Target: fully executable by any advanced LLM (Claude Sonnet class and above).

---

### Step 4: WRITE README — create per-role documentation

Write `roles/<category>/<slug>/README.md` using `src/templates/README.md` as
the structural baseline.

#### Required sections

- Title, metadata (Version: 1.1, Category), overview, quick start, usage
  examples (3-4), API/agent framework code, files table.

#### Conditional sections

- **Safety Notes** — required when `crisis_risk` or `gdpr_special_category`
  is true. Include crisis line disclaimer, GDPR/DPIA note, scope reminder.

#### Requirements

- Usage examples must be concrete and runnable.
- Files table must list only files that exist on disk.

---

### Step 5: REGISTER — add to index

Append a new entry to `index.yaml` under the correct category comment block.

#### Required fields

```yaml
- id: <id>
  name: "<ACRONYM> — <Full Name>"
  slug: <slug>
  category: <category>
  version: "1.1"
  status: stable
  files:
    prompt: "roles/<category>/<slug>/prompt.md"
    variant: null
    semanticode: "roles/<category>/<slug>/prompt-semanticode.md"
  description: "<3-5 sentences — same as README overview paragraph 1>"
  tags: [<minimum 4 tags>]
  usage:
    paste_in: true
    system_prompt: true
    auto_init: <true if role auto-starts, false if it waits>
  governance:
    risk_tier: <low|medium|high>
    ai_tier: <limited_risk|high_risk|general_purpose>
    data_classification: <public|internal|sensitive>
    gdpr_special_category: <true|false>
  provenance:
    author: "Jerry van Heerikhuize"
    created: "<today ISO>"
    last_updated: "<today ISO>"
```

#### Conditional fields

- `safety_notes` — when `crisis_risk` or `gdpr_special_category`
- `governance.eu_ai_act_tier` — when governance role or `risk_tier` is medium/high
- `governance.minors_involved` — when `minors_involved` is true

---

### Step 6: UPDATE README — add role to the main table

Add one row to the role table in `README.md` under the correct category heading.

Format: `| [**A.C.R.O.N.Y.M.**](roles/<category>/<slug>/prompt.md) — Full Name | Description |`

For health roles, append: `⚠️ See safety notes`

---

### Step 7: VALIDATE — run all checks

Run every check below. Report pass/fail for each. Do not proceed to Step 8
if any check fails — fix and re-validate.

| ID | Check |
|----|-------|
| V-01 | Role id is unique in `index.yaml` |
| V-02 | Slug matches the actual directory name under `roles/<category>/` |
| V-03 | All file paths in `index.yaml` `files` block exist on disk |
| V-04 | Files table in role `README.md` lists only files that exist on disk |
| V-05 | `README.md` role table contains a new row under the correct category |
| V-06 | If `crisis_risk`: prompt.md has CRISIS_PROTOCOL, index.yaml has safety_notes, README.md has Safety Notes |
| V-07 | If `gdpr_special_category`: prompt.md has GDPR_DISCLOSURE |
| V-08 | If `minors_involved`: index.yaml has `governance.minors_involved: true` |
| V-09 | `prompt-semanticode.md` header has correct source path, mode LOSSLESS, Grammar: SemantiCode v1.0 |
| V-10 | No FEAT-ID, SDLC, or governance framework references in any produced file |
| V-11 | Role README.md metadata has no governance/FEAT reference (Version + Category only) |
| V-12 | `index.yaml` description matches first paragraph of role README.md Overview |
| V-13 | No SCRIBE_META block in any produced file |
| V-14 | `prompt.md` has exactly one fenced code block (` ```text ` ... ` ``` `) — all XML inside, nothing after |
| V-15 | `prompt-semanticode.md` has exactly one fenced code block — all SemantiCode inside, nothing after |
| V-16 | No `prompt-optimized.md` or `prompt-compressed.md` created — `files.variant` is null |
| V-17 | `prompt.md` contains INSTRUCTION_HIERARCHY and LANGUAGE_DETECTION inside RULES |
| V-18 | `prompt.md` follows section order: PERSONA → STATE → OUTPUT → EXAMPLES → RULES → WORKFLOW |
| V-19 | `prompt.md` contains SCOPE_LIMITS inside RULES |
| V-20 | `prompt.md` contains at least one EXAMPLE with INPUT and OUTPUT sub-elements |
| V-21 | `prompt.md` contains ERROR_HANDLING inside WORKFLOW with at least: empty_input, out_of_scope, unrecognised_input |

---

### Step 8: REVIEW — present to user for approval

**Type: human gate** — present the user with:

1. List of all produced files and their locations.
2. The `index.yaml` entry that was added.
3. The `README.md` row that was added.
4. Validation results (all should be passing).

Wait for explicit user approval before committing.

---

### Step 9: COMMIT — stage and push

Stage all new and modified files. Commit with message:

```
feat(<slug>): introduce <ACRONYM> — <short description> — <category> masterprompt v1.1
```

Push to remote.

---

## Notes

- Read the base template (`src/templates/prompt.md`) before writing any prompt.
  Follow its structure exactly.
- Read at least 2 existing roles in the same category for tone and structure
  reference before writing.
