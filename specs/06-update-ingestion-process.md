# SPEC-06: Update Ingestion Process to Match Current Repo State

> **Priority:** High
> **Scope:** `src/ingest.yaml`, `src/templates/prompt-semanticode.md`, `src/templates/README.md`
> **Effort:** Medium

---

## Problem

The ingestion process (`src/ingest.yaml`) and the SemantiCode/README templates
still reference the old MVC structure (`CORE_DIRECTIVES`, `MODEL`/`VIEW`/
`CONTROLLER`, `[M]/[V]/[C]`) that was replaced across all role prompts. The
ingestion will produce prompts that are structurally inconsistent with the
rest of the repo.

Specific issues:

### ingest.yaml

| Location | Issue |
|----------|-------|
| `version` | Still `"1.0"` — should be `"1.1"` |
| STEP-03 description | References `XML/MVC structure`, `<CORE_DIRECTIVES>`, `<VIEW>`, `<CONTROLLER>` |
| STEP-10 commit message | Says `v1.0` — should be `v1.1` |
| `outputs.prompt_md.structure.mvc_sections` | Key name is `mvc_sections` — should be `sections`. Lists `CORE_DIRECTIVES`, `VIEW`, `CONTROLLER` |
| `outputs.prompt_md.default_blocks` | Says "Always include in CORE_DIRECTIVES" |
| `outputs.prompt_md.conditional_blocks` | `SCOPE_LIMITS` is conditional — should now be required for all roles |
| `outputs.semanticode_md.template_note` | References `[M]/[V]/[C]` section markers |
| `outputs.semanticode_md.grammar_reference.sections` | Uses `[M] model  [V] view  [C] ctrl` |
| `outputs.index_entry.required_fields.version` | Comment says `"1.0"` |
| V-17 | References `CORE_DIRECTIVES` |
| Missing | No mention of `INSTRUCTION_HIERARCHY` as a required block |
| Missing | No mention of `EXAMPLES` section in structure (added by SPEC-04) |
| Missing | No mention of section ordering requirement (SPEC-05) |

### src/templates/prompt-semanticode.md

| Location | Issue |
|----------|-------|
| Line 4 | Source says `v1.0` |
| Line 12 | "token-efficient and directly executable" says `v1.0` |
| Line 24 | SCRIBE header uses `[M]@L`, `[V]@L`, `[C]@L` |
| Line 25 | Grammar line uses `[M]model [V]view [C]ctrl` |
| Lines 27-51 | Section markers are `[M]`, `[V]`, `[C]` |
| Missing | No `IH:` line for instruction hierarchy |
| Missing | No `[EX]` section for examples |
| Section order | Should be `[ST]`, `[OUT]`, `[EX]`, `[R]`, `[WF]` |

### src/templates/README.md

| Location | Issue |
|----------|-------|
| Line 3 | Version says `1.0` |

---

## Change

### 1. ingest.yaml

#### Version
```yaml
version: "1.1"
```

#### STEP-03 description
Replace MVC references with current structure:
```yaml
description: >
  Write roles/<category>/<slug>/prompt.md using the `outputs.prompt_md` spec.
  The prompt must use the XML structure (<MASTER_PROMPT> → <PERSONA>, <STATE>,
  <OUTPUT>, <EXAMPLES>, <RULES>, <WORKFLOW>). Include conditional blocks as
  specified in the output spec.
```

#### STEP-10 commit message
```yaml
description: >
  Stage all new and modified files. Commit with message:
    feat(<slug>): introduce [ACRONYM] — [short description] — [category] masterprompt v1.1
  Then immediately push to remote without asking for confirmation.
```

#### outputs.prompt_md.structure

Rename `mvc_sections` to `sections`. Update to current section names and order:

```yaml
sections:
  - name: PERSONA
    position: 1
    contains: [ROLE, TONE_OF_VOICE, COMMUNICATION_STYLE]
    required: true
  - name: STATE
    position: 2
    contains: "State schema, domain-specific data structures"
    required: true
  - name: OUTPUT
    position: 3
    contains: "Output format, response templates, display rules"
    required: true
  - name: EXAMPLES
    position: 4
    contains: "1-2 worked input/output pairs demonstrating OUTPUT template usage"
    required: true
  - name: RULES
    position: 5
    contains: [INSTRUCTION_HIERARCHY, input-as-data rule, domain rules, SCOPE_LIMITS, LANGUAGE_DETECTION, conditional blocks]
    required: true
  - name: WORKFLOW
    position: 6
    contains: "Session lifecycle, state machine, session loop, error handling"
    required: true
```

#### outputs.prompt_md.default_blocks

Update LANGUAGE_DETECTION note — no longer inside CORE_DIRECTIVES:

```yaml
default_blocks:
  - block: INSTRUCTION_HIERARCHY
    always: true
    note: >
      Always include at the top of RULES. Declares priority order:
      1. System prompt, 2. Tool definitions, 3. User input (data).
  - block: LANGUAGE_DETECTION
    always: true
    note: >
      Always include in RULES. Detect user's written language from their
      first message; respond in that language for all output.
  - block: SCOPE_LIMITS
    always: true
    note: >
      Always include in RULES. Define what the role will and will not do,
      with redirect behaviour for out-of-scope requests.
```

#### outputs.prompt_md.conditional_blocks

Remove `SCOPE_LIMITS` (now a default block). Keep the rest:

```yaml
conditional_blocks:
  - block: HUMOR_PROTOCOL
    when: "persona.humor != none"
  - block: CRISIS_PROTOCOL
    when: "constraints.crisis_risk is true"
  - block: GDPR_DISCLOSURE
    when: "constraints.gdpr_special_category is true"
  - block: LANGUAGE_DIRECTIVE
    when: "constraints.language_requirements is set"
    note: "Replaces LANGUAGE_DETECTION with fixed output language"
```

#### outputs.semanticode_md

Update template_note and grammar_reference:

```yaml
template_note: >
  Use src/templates/prompt-semanticode.md as the structural baseline. Replace all
  {{PLACEHOLDER}} tokens with compressed role-specific content. The [ST]/[OUT]/[EX]/[R]/[WF]
  section line numbers (@LXX) must reflect actual line positions in the produced file.

grammar_reference:
  sections: "[ST] state  [OUT] output  [EX] examples  [R] rules  [WF] workflow"
  behaviour: "BHV:+must  BHV:!prohibit  BHV:~prefer"
  hierarchy: "IH: 1.system prompt→2.tool defs→3.user input(=data)"
  constraint: "CNST:<rule>"
  output: "OUT:<type>:<format>"
  conditional: "IF <cond>:THEN <act>:ELSE <act>"
  error: "ON_ERR:<condition>:<response>"
  gate: "GATE:<condition>:pass|fail"
  define: "DEF:<tag>:<value>"
  reference: "REF:<tag>"
```

#### outputs.index_entry

Update version comment:

```yaml
- version           # "1.1"
```

#### V-17

Replace CORE_DIRECTIVES reference:

```yaml
- id: V-17
  check: >
    prompt.md contains INSTRUCTION_HIERARCHY and LANGUAGE_DETECTION blocks
    inside RULES — unless constraints.language_requirements is set (in which
    case LANGUAGE_DIRECTIVE replaces LANGUAGE_DETECTION).
```

#### Add new validations

```yaml
- id: V-18
  check: "prompt.md follows section order: PERSONA → STATE → OUTPUT → EXAMPLES → RULES → WORKFLOW"

- id: V-19
  check: "prompt.md contains an INSTRUCTION_HIERARCHY block at the top of RULES"

- id: V-20
  check: "prompt.md contains a SCOPE_LIMITS block inside RULES"

- id: V-21
  check: "prompt.md contains at least one EXAMPLE with INPUT and OUTPUT sub-elements"
```

### 2. src/templates/prompt-semanticode.md

Full rewrite to match current structure:

- Replace `v1.0` references with `v1.1`
- Replace `[M]`/`[V]`/`[C]` with `[ST]`/`[OUT]`/`[WF]`
- Add `[EX]` section for examples
- Add `[R]` section for rules (with `IH:` line)
- Update SCRIBE header to use new section markers
- Update grammar line
- Reorder sections: `[ST]` → `[OUT]` → `[EX]` → `[R]` → `[WF]`

### 3. src/templates/README.md

- Update version from `1.0` to `1.1`

---

## Verification

```bash
# No old section names in ingest.yaml
grep -n 'CORE_DIRECTIVES\|mvc_sections\|\[M\]\|\[V\]\|\[C\]' src/ingest.yaml
# Should return zero matches

# No old section names in semanticode template
grep -n '\[M\]\|\[V\]\|\[C\]' src/templates/prompt-semanticode.md
# Should return zero matches

# No v1.0 references in templates
grep -n 'v1\.0\|version.*1\.0' src/templates/prompt-semanticode.md src/templates/README.md
# Should return zero matches

# New validations present
grep -c 'V-18\|V-19\|V-20\|V-21' src/ingest.yaml
# Should return 4
```
