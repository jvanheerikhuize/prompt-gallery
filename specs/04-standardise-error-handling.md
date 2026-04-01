# SPEC-04: Standardise Error Handling

> **Priority:** Medium
> **Scope:** Template + roles missing `<ERROR_HANDLING>`
> **Effort:** Medium

---

## Problem

Error handling varies widely across roles. Some (T.A.G., A.T.L.A.S., A.G.L.)
have detailed error blocks. Others (C.R.A., P.S.Y.) have none or scatter error
responses across RULES. There is no standard error taxonomy.

## Change

### 1. Define a standard error taxonomy

Three tiers, applicable to all roles:

```
ON_ERR:EMPTY_INPUT     — User sends empty or whitespace-only message
ON_ERR:OUT_OF_SCOPE    — User requests something outside role's domain
ON_ERR:MALFORMED_INPUT — User input doesn't match expected format for current phase
```

### 2. Update the base template

Add a standardised `<ERROR_HANDLING>` block inside `<WORKFLOW>`:

```xml
<ERROR_HANDLING>
    ON_ERR:EMPTY_INPUT:
    → Ask the user to provide input relevant to the current phase.

    ON_ERR:OUT_OF_SCOPE:
    → Acknowledge the request, note it falls outside this role's scope,
      and redirect to the role's primary function.

    ON_ERR:MALFORMED_INPUT:
    → Describe what was expected and ask the user to try again.
</ERROR_HANDLING>
```

### 3. Ensure all roles have the block

Roles may extend the standard errors with domain-specific ones (e.g., T.A.G.
has `ON_ERR:CONTRADICTION`, A.T.L.A.S. has `ON_ERR:INVALID_COORDINATES`).

Roles that need error handling added or extended:

| Role | Current state | Action |
|------|--------------|--------|
| C.R.A. | No `<ERROR_HANDLING>` | Add standard block + `ON_ERR:UNSUPPORTED_LANGUAGE` |
| P.S.Y. | Error handling scattered in RULES | Consolidate into `<ERROR_HANDLING>` block |
| F.R.A.N.K. | Minimal | Add standard block |
| V.I.T.A. | Minimal | Add standard block |
| P.A.P.A. | Minimal | Add standard block |
| M.E.N.T.O.R. | Minimal | Add standard block |
| S.C.O.U.T. | Minimal | Add standard block |

Roles with existing error handling (T.A.G., A.T.L.A.S., A.G.L., A.G.O.R.A.)
should be verified to include the three standard errors but not rewritten.

## Verification

```bash
grep -rn 'ERROR_HANDLING' roles/ --include='prompt.md'
```

Should match all 18 role prompts.
