# Functional Readiness Audit Prompt

> **Usage:** Copy this file's content and paste it into an AI coding agent
> (Claude Code, Cursor, Copilot) at the repo root. The agent will run the
> full functional audit loop and produce all required outputs.
>
> **Companion to:** `src/audit.md` (non-functional / standards audit)

---

## Instructions

You are running a Functional Readiness audit on a prompt engineering library.
The repo contains structured LLM system prompts ("roles") — each is a
complete system prompt designed to be pasted into a chat or injected via API.

This audit evaluates whether each role **works correctly as designed** — not
whether it follows industry standards (that's `audit.md`). The focus is:
do the prompts produce the behaviour they promise?

Execute the following steps in order. Do not skip any step.

---

### Step 0: READ — load the repo state

Read:
- `src/templates/prompt.md` (base template — defines the structural contract)
- `index.yaml` (role catalog — lists all roles and their metadata)
- All `roles/**/prompt.md` files (canonical prompts)
- A sample of `roles/**/prompt-semanticode.md` files (at least 3)
- `audits/log-functional.md` (previous audit results, if exists)

---

### Step 1: AUDIT — evaluate every role against the functional checklist

For **each of the 18 roles**, evaluate every applicable topic in the
checklist below. Not every topic applies to every role — stateless roles
(A.T.L.A.S., P.R.I.M.E., A.G.L.) skip session-specific checks. Mark
those as N/A.

Classify each topic per role as: **pass**, **warn** (minor gap, still
functional), **fail** (broken or missing, would cause incorrect behaviour),
or **N/A**.

#### Functional Checklist

| # | Topic | What to evaluate | Applies to |
|---|-------|------------------|------------|
| F-01 | **Session flow completeness** | Every phase defined in the workflow is reachable. There is always a path from INIT to the final phase. No dead-end phases with no exit condition. Mandatory phases (close, stabilise, review) cannot be skipped. | Session-based roles |
| F-02 | **Phase transition explicitness** | Every transition between phases has an explicit condition ("advance when X"). No transition relies solely on narrative judgement without a stated trigger. | Session-based roles |
| F-03 | **State schema coverage** | Every field in STATE_SCHEMA is read or written by at least one workflow step. No orphaned fields (defined but never touched). No phantom fields (referenced in workflow but absent from schema). | Roles with STATE_SCHEMA |
| F-04 | **Output template coverage** | Every phase or decision path in the workflow emits a defined OUTPUT template. No phase that produces output without a named template. No templates defined but never referenced. | All roles |
| F-05 | **Example completeness** | At least 1 example demonstrates the primary happy path from entry to output. At least 1 example shows an edge case or error path. Examples use the actual OUTPUT template format defined in the prompt, not ad-hoc formatting. | All roles |
| F-06 | **Example accuracy** | Examples reference correct template names, field names, and output formats. No stale references to renamed or removed constructs. | All roles |
| F-07 | **Command completeness** | Every `/command` listed in the COMMANDS section has handling logic in the workflow. No commands listed without a defined response. | Roles with /commands |
| F-08 | **Error path coverage** | Every ON_ERR handler produces a meaningful response. Error handlers cover the three standard types (empty_input, out_of_scope, unrecognised_input) plus all domain-specific error conditions that the workflow can actually produce. | All roles |
| F-09 | **SemantiCode fidelity** | The SemantiCode variant preserves all rules (BHV), constraints (CNST), output templates (OUT), error handlers (ON_ERR), and workflow logic from the canonical prompt. No semantic loss in LOSSLESS mode. | All roles with semanticode |
| F-10 | **Cross-variant consistency** | If a role has multiple prompt files (e.g., E.C.H.O. has prompt.md and prompt-player.md), they are internally consistent — shared references match, state schemas align, and commands/phases don't conflict. | Multi-file roles |
| F-11 | **Crisis protocol completeness** | Crisis sentinel patterns are defined and comprehensive. First-person and third-person sentinels are both covered. Crisis resources are localised for all languages the role supports. The CONSERVATIVE_CRISIS_POLICY (ambiguous → check in) is stated. | Health roles, roles with crisis_risk |
| F-12 | **Disclaimer trigger coverage** | DISCLAIMER_TRIGGER_PATTERNS are defined. Every pattern listed would actually be caught by the workflow's RULES_CHECK step. The FULL_DISCLAIMER template exists and is renderable. | Roles with disclaimers |

---

### Step 2: REPORT — produce the functional scorecard

Create or update the file `audits/log-functional.md` with:

```markdown
## {today's date}

### Summary

- **Roles audited:** {count}
- **Overall pass rate:** {X}% ({pass count} / {total applicable checks})
- **Fails:** {count} across {N} roles
- **Warns:** {count} across {N} roles

### Per-role results

| Role | F-01 | F-02 | F-03 | F-04 | F-05 | F-06 | F-07 | F-08 | F-09 | F-10 | F-11 | F-12 | Score |
|------|------|------|------|------|------|------|------|------|------|------|------|------|-------|
| ... per role row, using pass/warn/fail/N/A ... |

### Findings

| ID | Role(s) | Topic | Severity | Detail |
|----|---------|-------|----------|--------|
| ... one row per finding ... |

### Previous audit
- **Date:** {date of previous entry, or "none"}
- **Delta:** {what changed — findings resolved, new issues, score movement}
```

---

### Step 3: SPEC — generate improvement specs for failures

For each **fail** finding (not warns — those are tracked but not blocking):

1. Create a spec file in `specs/` following the naming convention
   (`NN-short-description.md`).
2. Each spec must include: Priority, Scope, Effort, Problem, Change,
   and Verification sections.
3. Group related failures into a single spec where it makes sense
   (e.g., "orphaned state fields" across 3 roles = one spec).

If there are no fails, skip this step.

---

### Step 4: Summary

Print a concise summary of:
- Overall functional readiness (pass rate, critical gaps)
- Roles with the most issues
- Specs created (if any)
- Comparison to previous functional audit (if exists)
- Recommended next actions

---

## Guidance for evaluators

### What counts as a fail vs. a warn?

- **Fail:** The prompt will produce incorrect, inconsistent, or missing output
  in a scenario it should handle. A user following the documented flow would
  hit a dead end, see wrong formatting, or trigger undefined behaviour.
  Examples: dead-end phase, orphaned template never rendered, command with
  no handler, example referencing a template that doesn't exist.

- **Warn:** The prompt works but has a gap that reduces quality or could
  confuse an evaluator. The user wouldn't notice in normal use but an edge
  case might surface it. Examples: orphaned state field that's harmless,
  only 1 example when 2 would be better, implicit transition that works
  in practice but isn't formally stated.

### Stateless vs. session-based roles

Some roles are stateless (one request → one response): A.T.L.A.S., S.C.R.I.B.E.,
P.R.I.M.E., A.G.L. These skip F-01, F-02, and parts of F-03. Evaluate them
on output template coverage, error handling, examples, and SemantiCode fidelity.

### Reading SemantiCode

SemantiCode uses a compressed grammar. Key mappings:
- `BHV:+` = required behaviour, `BHV:!` = prohibited, `BHV:~` = preferred
- `CNST:` = constraint, `OUT:` = output template, `ON_ERR:` = error handler
- `IH:` = instruction hierarchy
- `IF cond:THEN act` = conditional logic
- `DEF:` / `REF:` = define / reference a reusable value

Compare these against the canonical prompt's XML blocks to verify nothing
was lost in compression.

### Notes

- This audit is **read-only for role prompts** — it does not modify prompt
  content. It only writes to `audits/log-functional.md` and `specs/`.
- Be honest in scoring. A warn is not a fail, and a pass is not "perfect" —
  it means the prompt works as documented.
- If the previous functional audit log exists, compare findings to track
  improvement or regression.
