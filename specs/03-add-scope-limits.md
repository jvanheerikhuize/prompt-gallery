# SPEC-03: Add Scope Limits to All Roles

> **Priority:** Medium
> **Scope:** All role prompts missing `<SCOPE_LIMITS>`
> **Effort:** Medium

---

## Problem

OWASP recommends explicit scope boundary enforcement to prevent role drift
and out-of-scope usage. Currently only P.S.Y. and A.G.O.R.A. define what they
will and will not do. Other roles leave scope implicit, meaning a user could
attempt to repurpose the role (e.g., asking C.R.A. for Kubernetes compliance
auditing, or asking T.A.G. to generate explicit content).

## Change

Add a `<SCOPE_LIMITS>` block inside `<RULES>` for every role that doesn't
already have one. Each block must define:

1. **In-scope** — what the role does (1-3 bullet points)
2. **Out-of-scope** — what the role refuses (2-4 bullet points)
3. **Redirect** — how the role responds when asked for out-of-scope work

### Template

```xml
<SCOPE_LIMITS>
    This role WILL:
    - [primary function]
    - [secondary function]

    This role will NOT:
    - [out-of-scope item 1]
    - [out-of-scope item 2]

    When a user requests out-of-scope content:
    → Acknowledge the request, explain it falls outside this role's scope,
      and redirect to the role's primary function.
</SCOPE_LIMITS>
```

### Per-role scope definitions

| Role | In-scope | Out-of-scope |
|------|----------|-------------|
| C.R.A. | Code review (security, correctness, performance, maintainability) | Architecture consulting, compliance auditing, writing new code |
| F.O.R.G.E. | Full-stack implementation guidance, branch/PR workflow | Production operations, incident response, hiring |
| Q.A.V.E. | Test plans, defect reports, coverage analysis | Manual testing execution, test automation code, deployment |
| T.A.G. | Text adventure game mastering | Real-world advice, explicit/graphic content, out-of-game conversation |
| H.E.I.S.T. | Heist scenario game play | Real crime planning, explicit content |
| D.I.C.E. | Detective mystery game play | Real investigation advice, explicit content |
| E.C.H.O. | Multi-player game orchestration | Single-player games, real-world coordination |
| A.G.L. | EU AI Act classification | Legal advice, compliance certification |
| P.R.I.M.E. | Feature spec review | Technical implementation, sprint planning |
| A.T.L.A.S. | ASCII map rendering | GIS analysis, navigation directions |
| S.C.R.I.B.E. | Prompt compression to SemantiCode | General text summarisation, code generation |
| S.C.O.U.T. | Curriculum briefings | Tutoring, lesson planning, grading |
| M.E.N.T.O.R. | Study coaching for secondary school | Professional tutoring, university-level content |

Roles that already have scope limits (P.S.Y., A.G.O.R.A., F.R.A.N.K.,
V.I.T.A., P.A.P.A.) should be reviewed for completeness but not rewritten.

## Verification

```bash
grep -rn 'SCOPE_LIMITS' roles/ --include='prompt.md'
```

Should match all 18 role prompts.
