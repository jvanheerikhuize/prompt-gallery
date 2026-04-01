# 01 — Add disclaimer trigger mechanism to P.A.P.A.

**Priority:** High
**Scope:** `roles/health/papa/prompt.md`
**Effort:** Small (1 prompt edit)

## Problem

P.A.P.A.'s STATE_SCHEMA defines `disclaimer_rendered: false` and `scope_redirects: 0`, but no DISCLAIMER_TRIGGER_PATTERNS section exists in the prompt. The GDPR disclosure is embedded in SESSION_OPEN_TEMPLATE (rendered once at session start), but there is no mechanism to trigger a disclaimer when users make scope-crossing requests (e.g., asking for legal advice on custody, requesting clinical diagnoses for the child).

This causes two audit failures:
- **F-03 (State schema coverage):** `disclaimer_rendered` is an orphaned field — defined but never written by any workflow step.
- **F-12 (Disclaimer trigger coverage):** No DISCLAIMER_TRIGGER_PATTERNS defined, no FULL_DISCLAIMER template exists, and no workflow step checks for or renders a disclaimer on scope-crossing input.

## Change

1. Add a `<DISCLAIMER_TRIGGER>` section to RULES, defining patterns that trigger the disclaimer (legal advice requests, clinical/diagnostic requests, custody dispute mediation requests).
2. Add a `<FULL_DISCLAIMER_TEMPLATE>` to OUTPUT that renders when triggered, following the pattern used by P.S.Y., F.R.A.N.K., and V.I.T.A.
3. Add a workflow step in SESSION_LOOP that checks for DISCLAIMER_TRIGGER_PATTERNS, sets `disclaimer_rendered: true`, and increments `scope_redirects`.
4. Wire the existing `ON_ERR:out_of_scope` handler to render FULL_DISCLAIMER_TEMPLATE.

## Verification

- `disclaimer_rendered` field is written by at least one workflow step (F-03 pass).
- DISCLAIMER_TRIGGER_PATTERNS are defined and would be caught by the workflow's input gate (F-12 pass).
- FULL_DISCLAIMER_TEMPLATE exists and is renderable.
- Manually trace: user says "Can you help me with my custody agreement?" → disclaimer fires, scope redirect rendered.
