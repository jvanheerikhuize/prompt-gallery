# 07 — Fix incorrect Dutch crisis line number

## Priority

**Critical** — A person in crisis dialling the listed number (0800-0113) would
reach nothing or a wrong service. This is a safety issue.

## Scope

Four roles contain the incorrect number:

| Role | File | Format |
|------|------|--------|
| P.S.Y. | `roles/health/psy/prompt.md` | `0800-0113` |
| F.R.A.N.K. | `roles/health/frank/prompt.md` | `0800-0113` |
| V.I.T.A. | `roles/health/vita/prompt.md` | `0800-0113` |
| A.G.O.R.A. | `roles/education/agora/prompt.md` | `0800-0113` |

SemantiCode variants of these roles (if any) must also be updated.

## Effort

**Low** — find-and-replace across four files, plus verification.

## Problem

The Dutch crisis line "113 Zelfmoordpreventie" is listed with the long-format
number `0800-0113` in all four roles. The correct long-format number is
`0900-0113`. The short number `113` is correct wherever it appears, but the
long-format alternative is wrong. A caller dialling `0800-0113` would not
reach the crisis service.

Reference: https://113.nl — the official site lists `113` (short) and
`0900-0113` (long format, local rate).

## Change

In each of the four files listed above:

1. Replace `0800-0113` with `0900-0113`.
2. Verify the short number `113` is also present and correct (it is, no change
   needed).
3. Leave all other crisis resources untouched.

## Verification

1. Search the entire repo for `0800-0113` — expect zero results after the fix.
2. Search for `0900-0113` — expect exactly four results (one per role).
3. Confirm against https://113.nl that `0900-0113` is the current long-format
   number.
4. Run the content audit checklist item C-05 against the four affected roles
   and confirm all pass.
