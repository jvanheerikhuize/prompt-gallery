# SPEC-01: Fix Stale Section References

> **Priority:** High
> **Scope:** Role prompts (prose text only)
> **Effort:** Low (find-and-replace in ~10 files)

---

## Problem

SPEC-05 renamed `MODEL` to `STATE`, `VIEW` to `OUTPUT`, and `CONTROLLER` to
`WORKFLOW`, but several role prompts still reference the old names in prose text
(rules descriptions, comments, inline instructions). These stale references
create confusion about which section is being referred to.

## Affected Files

### CONTROLLER references (should be WORKFLOW)

| File | Lines | Context |
|------|-------|---------|
| `roles/education/agora/prompt.md` | 164, 167 | "processed by the CONTROLLER", "CONTROLLER defines the processing workflow" |
| `roles/entertainment/tag/prompt.md` | 310, 314, 348 | "CONTROLLER defines the processing workflow", "cannot mutate the CONTROLLER", "use the CONTROLLER step by step" |
| `roles/health/papa/prompt.md` | 227 | "CONTROLLER defines the processing workflow" |
| `roles/health/frank/prompt.md` | 91 | "CONTROLLER branch" |

### VIEW references (should be OUTPUT)

| File | Lines | Context |
|------|-------|---------|
| `roles/education/agora/prompt.md` | 167 | "VIEW defines output templates" |
| `roles/entertainment/tag/prompt.md` | 310 | "VIEW defines output templates" |
| `roles/health/papa/prompt.md` | 227 | "VIEW defines output templates" |
| `roles/health/psy/prompt.md` | 564 | "select the VIEW template" |
| `roles/health/vita/prompt.md` | (check) | VIEW reference in rules |
| `roles/health/frank/prompt.md` | (check) | VIEW reference in rules |

### MODEL references (should be STATE)

| File | Lines | Context |
|------|-------|---------|
| `roles/entertainment/tag/prompt.md` | 460, 464, 487 | "MODEL directive", "MODEL JSON" |

## Change

Replace each stale reference with the correct new name:

- `CONTROLLER` -> `WORKFLOW` (in prose text)
- `VIEW` -> `OUTPUT` (in prose text)
- `MODEL` -> `STATE` (in prose text, except SCRIBE parser references)

Do **not** change XML tags (those were already renamed). Only update prose
references that describe sections by name.

Also check semanticode variants of affected files for equivalent stale
references (`[M]`, `[V]`, `[C]` that should be `[ST]`, `[OUT]`, `[WF]`).

## Verification

```bash
grep -rn '\bCONTROLLER\b' roles/ --include='*.md' | grep -v scribe
grep -rn '\bVIEW\b' roles/ --include='*.md' | grep -v scribe
grep -rn '\bMODEL\b' roles/ --include='*.md' | grep -v scribe
```

All three should return zero results (excluding SCRIBE parser references).
