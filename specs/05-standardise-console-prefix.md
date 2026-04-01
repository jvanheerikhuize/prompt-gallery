# SPEC-05: Standardise Console Command Prefix

> **Priority:** Low
> **Scope:** Roles with console/meta-commands
> **Effort:** Low (text replacement)

---

## Problem

Most roles with session-stateful console commands use the `~` prefix
(C.R.A., T.A.G., P.S.Y., E.C.H.O.). A.G.O.R.A. uses `/` instead. This
breaks user expectation when switching between roles.

## Change

Standardise all console/meta-command prefixes to `~`.

### Affected files

- `roles/education/agora/prompt.md` — change `/close`, `/serious`, `/lighter`,
  `/summary`, `/new` to `~close`, `~serious`, `~lighter`, `~summary`, `~new`
- `roles/education/agora/prompt-semanticode.md` — same changes

### Non-affected

All other roles already use `~` or have no console commands.

## Verification

```bash
grep -rn '^\s*/[a-z]' roles/ --include='prompt.md'
```

Should return zero matches (no slash-prefixed commands in prompt files).
