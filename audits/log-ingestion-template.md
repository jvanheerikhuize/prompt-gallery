# Ingestion Template Audit — 2026-04-01

> **Scope:** `src/templates/ingestion-checklist.md` tested against 4 representative prompts
> **Auditor:** Claude Opus 4.6 (agent-assisted)

---

## Prompts tested

| Prompt | Category | Type | Score | Rating |
|--------|----------|------|-------|--------|
| T.A.G. (`roles/entertainment/tag/prompt.md`) | Entertainment | Stateful game | 93% | Good |
| C.R.A. (`roles/engineering/cra/prompt.md`) | Engineering | Stateful verdict | 97% | Excellent |
| P.S.Y. (`roles/health/psy/prompt.md`) | Health | Safety-critical | 95% | Excellent |
| S.C.R.I.B.E. (`roles/utility/scribe/prompt.md`) | Utility | Stateless | 90% | Good |

**Average: 94% — Good**

---

## Findings

### F-01: BHV taxonomy adoption is inconsistent (R-03)

**Severity:** Medium
**Checklist claim:** "All roles use BHV:+/!/~ taxonomy"
**Reality:** Only C.R.A. uses formal BHV notation. T.A.G., P.S.Y., and S.C.R.I.B.E. use
prose rules or custom naming schemes (RULE 1-4, named rules).
**Recommendation:** Relax R-03 to accept any unambiguous named-rule system (BHV taxonomy,
numbered rules, or named blocks). The check should verify rules are *named and testable*,
not that they use a specific notation.

### F-02: COMMUNICATION_STYLE tag is not universal (I-03)

**Severity:** Low
**Checklist claim:** "16/18 roles include COMMUNICATION_STYLE as sub-element"
**Reality:** P.S.Y. uses `<TONE>` (no nested COMMUNICATION_STYLE). S.C.R.I.B.E. embeds
style in PERSONA prose.
**Recommendation:** Change I-03 to check for the *concept* (explicit description of how
the persona communicates) rather than a specific XML tag name.

### F-03: Edge-case examples are the most common gap (E-03)

**Severity:** Medium
**Checklist claim:** "14/18 roles include a second example showing an edge case"
**Reality:** 3 of 4 tested prompts have only one happy-path example.
**Recommendation:** Make E-03 a hard gate during ingestion — require at least one edge-case
or error-path example before passing validation.

### F-04: Stateless declaration has no standard pattern (ST-04)

**Severity:** Low
**Checklist claim:** "Stateless roles explicitly declare statelessness"
**Reality:** S.C.R.I.B.E. mentions "no session state" in prose buried in REQUEST_LOOP. No
formal marker or convention exists.
**Recommendation:** Define a convention (e.g., `<STATE mode="stateless"/>` or a minimal
STATE section with explicit declaration) and enforce during ingestion.

### F-05: Safety scoring is heavily conditional (Section 8)

**Severity:** Low
**Checklist claim:** Safety section weighted at 15%
**Reality:** For non-safety roles, 6/7 checks are N/A, inflating their weighted score.
**Recommendation:** Split into "universal safety" (SA-05: no licensed-professional claims)
and "conditional safety" (SA-01-04, SA-06-07) with separate weights. Only apply conditional
weight when the role's constraints trigger those checks.

### F-06: Three checks require cross-file or tooling verification

**Severity:** Low
**Affected checks:** T-02 (SemantiCode parity), D-03 (index↔README match), D-05 (files
table ↔ disk)
**Recommendation:** Mark these as "tool-assisted only" in the checklist. They cannot be
verified from the prompt alone and should be delegated to automated validation scripts.

### F-07: Missing checks for slash-command completeness

**Severity:** Medium
**Observation:** All 4 tested prompts define `/commands` with access tiers. The checklist
has no check for command documentation, tier consistency, or alignment with SCOPE_LIMITS.
**Recommendation:** Add a new check in Section 7 (Workflow):
`W-07: Roles with commands define all commands in a COMMANDS section with access tiers
(read/mutate/persist). Command capabilities must not exceed SCOPE_LIMITS.`

### F-08: Missing check for internal cross-reference integrity

**Severity:** Low
**Observation:** T.A.G. and P.S.Y. use internal section cross-references ("see: Combat").
No check verifies these resolve.
**Recommendation:** Add to Section 2 (Structure):
`S-06: Internal cross-references (see: <section>) must resolve to an actual section name
in the prompt.`

---

## Verdict

The ingestion checklist is **fit for use** with the findings above noted. The 53-check
framework correctly identifies strengths and gaps across all four prompt types (stateful,
stateless, safety-critical, game). The most impactful improvements are:

1. **Enforce edge-case examples** (F-03) — highest-frequency failure
2. **Relax BHV notation requirement** (F-01) — prevents false failures on valid rules
3. **Add command completeness check** (F-07) — missing coverage for a universal pattern

All other findings are low-severity refinements.
