# SPEC-02: Soften Imperative Language for Modern Models

> **Priority:** High
> **Scope:** Template + all role prompts
> **Effort:** Medium (manual review per prompt)

---

## Problem

Claude 4.6, GPT-5, and Gemini 3 follow well-stated instructions without emphasis
markers. Aggressive language like "ABSOLUTE_RULES", "Strictly adhere", "NEVER",
all-caps directives, and exclamation-style phrasing were necessary for older models
but now cause **overtriggering** — the model becomes overly cautious or rigid.

Anthropic's Claude 4.6 guide explicitly states: "Where you previously wrote
'CRITICAL: You MUST use this tool when...' you should now just write 'Use this
tool when...'"

## Change

### 1. Rename `<ABSOLUTE_RULES>` → `<RULES>` or `<CONSTRAINTS>`

In template and all role prompts.

### 2. Remove or soften emphasis qualifiers

| Before | After |
|--------|-------|
| `Strictly adhere to...` | `Follow...` |
| `You must NEVER...` | `Do not...` |
| `ALWAYS do X` | `Do X` |
| `It is CRITICAL that...` | `X is required.` |
| `Under NO circumstances...` | `Do not...` |

### 3. Keep direct, clear phrasing

The goal is **not** to make rules vague. A rule like:

```text
# BEFORE
- ABSOLUTE RULE: You must NEVER under any circumstances generate code fixes
  that use APIs you cannot verify exist.

# AFTER
- Do not propose fixes using APIs or functions you cannot verify exist in the
  submitted code's language and ecosystem.
```

The rule is identical in meaning but reads as a calm professional instruction
rather than a shouted command.

### 4. Files to update

- `src/templates/prompt.md` — rename tag, soften template language
- Every `roles/**/prompt.md` — search for: `ABSOLUTE`, `NEVER`, `MUST`, `CRITICAL`,
  `Strictly`, `ALWAYS` (case-sensitive caps) and evaluate each instance

### Verification

- `grep -rE "(ABSOLUTE|STRICTLY|CRITICAL)" roles/` returns zero results
  (excluding XML comments that document the change)
- `grep -c "MUST\|NEVER\|ALWAYS" roles/**/prompt.md` — only lowercase uses remain,
  and only where semantically warranted (e.g., "must" in natural prose)
- Behavioral spot-check: paste a modified prompt into Claude/GPT and verify it
  still follows the rules without becoming overly rigid

---

## References

- Anthropic Claude 4.6 best practices: dial back aggressive instruction language
- Google Gemini 3 guide: "clearer specs, not longer prompts"
- Anti-pattern taxonomy: overtriggering from overconstrained instructions
