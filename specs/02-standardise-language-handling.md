# SPEC-02: Standardise Language Handling

> **Priority:** High
> **Scope:** Template + role prompts with language blocks
> **Effort:** Medium

---

## Problem

Language handling is inconsistent across the repo:

1. The base template contains **both** `<LANGUAGE_DETECTION>` and
   `<LANGUAGE_DIRECTIVE>` as conditional alternatives, but roles inconsistently
   choose between them.
2. Three roles still use `<LANGUAGE_DIRECTIVE>` instead of `<LANGUAGE_DETECTION>`:
   `echo/prompt.md`, `papa/prompt.md`, `agora/prompt.md`.
3. Health roles with crisis resources (P.S.Y., F.R.A.N.K., V.I.T.A., P.A.P.A.)
   don't all map `STATE.language` to localised crisis line numbers. A user
   writing in Spanish could receive English-only crisis resources.

## Change

### 1. Standardise on `<LANGUAGE_DETECTION>`

All roles should use `<LANGUAGE_DETECTION>` as the default block. Remove
`<LANGUAGE_DIRECTIVE>` from the base template. Roles that enforce a specific
output language (e.g., SCOUT outputs in Dutch) should still use
`<LANGUAGE_DETECTION>` but add a `fixed_output_language` field.

### 2. Make language check Step 1 in SESSION_LOOP

Language detection should be the **first** step in every session loop, not
buried inside RULES. Update the base template SESSION_LOOP:

```xml
STEP-1 LANGUAGE_CHECK: Confirm output language matches STATE.language.
STEP-2 RECEIVE: Accept user input.
...
```

### 3. Crisis resource localisation

For roles with `<CRISIS_PROTOCOL>`, add a `CRISIS_RESOURCES_BY_LANGUAGE` mapping:

```xml
<CRISIS_RESOURCES>
    en: "988 Suicide & Crisis Lifeline (US) / Samaritans 116 123 (EU)"
    nl: "113 Zelfmoordpreventie (0900-0113)"
    de: "Telefonseelsorge (0800-1110111)"
    ...
</CRISIS_RESOURCES>
```

Require a `<!-- VERIFY: Update crisis line numbers for your deployment region -->`
comment.

## Verification

- `grep -rn 'LANGUAGE_DIRECTIVE' roles/` returns zero matches
- All roles with `<CRISIS_PROTOCOL>` include localised crisis resources
- SESSION_LOOP Step 1 is LANGUAGE_CHECK in all roles
