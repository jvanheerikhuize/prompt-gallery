# SPEC-03: Trim Redundant Domain Knowledge Lists

> **Priority:** High
> **Scope:** Role prompts with encyclopedic check lists
> **Effort:** Medium (requires judgement per prompt)

---

## Problem

Prompts like CRA contain detailed enumerations of domain knowledge the model already
has — e.g., listing every OWASP category with CWE IDs, or spelling out what an
off-by-one error is. This consumes tokens without improving behavior. Anthropic's
"right altitude" framework says: every token must earn its place. Domain knowledge
that exists in the model's training data is redundant in the prompt.

Modern models (Claude 4.6, GPT-5) reliably apply OWASP, CWE, and standard code
review heuristics when simply told to do so.

## Principle

**Keep:** structural rules, workflow, output format, scope boundaries, persona.
**Trim:** encyclopedic lists the model already knows.

## Change

### Example: CRA `<RULES_ENGINE>`

```text
# BEFORE (56 lines)
<SECURITY_CHECKS>
    - INJECTION: Check for SQL, command, LDAP, XPath, template injection vectors. (CWE-89, CWE-78)
    - XSS: Unsanitised user data rendered in HTML/JS context. (CWE-79)
    - AUTHENTICATION: Hardcoded credentials, weak token generation... (CWE-798, CWE-330)
    ... (10 categories, each with CWE IDs)
</SECURITY_CHECKS>
<CORRECTNESS_CHECKS>
    ... (7 categories)
</CORRECTNESS_CHECKS>
<PERFORMANCE_CHECKS>
    ... (5 categories)
</PERFORMANCE_CHECKS>
<MAINTAINABILITY_CHECKS>
    ... (6 categories)
</MAINTAINABILITY_CHECKS>

# AFTER (~12 lines)
<RULES_ENGINE>
    Review categories (always applied in this order):
    1. Security — OWASP Top 10, CWE-mapped vulnerabilities, secrets, dependency risks.
    2. Correctness — null safety, bounds, resource leaks, race conditions, error handling, logic errors.
    3. Performance — algorithmic complexity, N+1 queries, memory, blocking I/O.
    4. Maintainability — naming, coupling, duplication, testability.

    When FOCUS is set to a single category, always still run Security checks.
    Tag each finding with the relevant CWE ID where applicable.
</RULES_ENGINE>
```

### Prompts to evaluate

| Prompt | Likely redundant sections | Action |
|--------|--------------------------|--------|
| CRA | `SECURITY_CHECKS`, `CORRECTNESS_CHECKS`, `PERFORMANCE_CHECKS`, `MAINTAINABILITY_CHECKS` | Condense to category-level list |
| FORGE | Any duplicated check lists from CRA | Same treatment |
| QAVE | Detailed severity/test-type enumerations | Keep severity scale, trim test-type encyclopedia |
| PSY | SAMHSA six pillars list (if enumerated in full) | Reference by name, don't restate definitions |
| VITA | Pillar definitions, MI/OARS technique descriptions | Reference frameworks, don't teach them |

### What to keep

- **Severity scales** (critical/high/medium/low/info) — these are prompt-specific policy, not general knowledge
- **Verdict mappings** (approve/block thresholds) — same, prompt-specific
- **Risk score formulas** — custom logic the model can't infer
- **Scope limits** — what the role will NOT do
- **Output templates** — exact format specifications

### Verification

- Token count per prompt decreases by 15-30%
- Behavioral spot-check: submit the same code snippet to the trimmed prompt and
  verify findings are equivalent in category coverage and CWE tagging
- No loss of structural rules or output format compliance

---

## References

- Anthropic "right altitude" framework: minimal but sufficient
- Google Gemini 3: "clearer specs, not longer prompts"
- Anti-pattern: excessive prompt length / bloated prompts increasing cost
