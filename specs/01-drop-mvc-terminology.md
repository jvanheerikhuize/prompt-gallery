# SPEC-01: Drop MVC Terminology

> **Priority:** High
> **Scope:** Template + all role prompts
> **Effort:** Low (find-and-replace + minor rewording)

---

## Problem

MVC (Model-View-Controller) is not a recognized prompt engineering pattern in any
major provider's documentation (Anthropic, OpenAI, Google) or academic literature.
Instructing the LLM to "strictly follow MVC discipline" implies a software execution
model the LLM does not have. The structural separation itself is good — the label
is the problem.

## Change

### 1. Template (`src/templates/prompt.md`)

Remove the ABSOLUTE_RULES bullet that references MVC:

```text
# REMOVE
- MVC: Strictly adhere to all instructions as a Model, View, Controller (MVC) framework.

# REPLACE WITH (or remove entirely — the tags already enforce separation)
- structure: Follow the tagged sections below. STATE_SCHEMA holds session state,
  VIEW defines output templates, CONTROLLER defines the processing workflow.
```

### 2. Section tags — keep as-is or rename

The `<MODEL>`, `<VIEW>`, `<CONTROLLER>` tag names are fine as organizational labels.
They are descriptive and the LLM treats them as section markers, not as an MVC contract.
**No tag rename is required** unless you prefer neutral names like `<STATE>`, `<OUTPUT>`,
`<WORKFLOW>`.

### 3. All role prompts (`roles/**/prompt.md`)

Search for any line referencing "MVC" and apply the same replacement. Affected files
(based on template usage):

- `roles/engineering/cra/prompt.md` — line containing "MVC discipline"
- All other roles that include the ABSOLUTE_RULES block from the template

### Verification

- `grep -r "MVC" roles/` returns zero results after the change.
- Each prompt still has the three structural sections (`<MODEL>`, `<VIEW>`, `<CONTROLLER>`
  or their renamed equivalents).

---

## References

- Anthropic: use descriptive XML tags, no special architectural framing needed
- No provider documentation references MVC as a prompt pattern
