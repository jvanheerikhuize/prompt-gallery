# Documentation Integrity Audit Log

---

## 2026-04-01

### Summary

- **Checks evaluated:** 31 (D-01 through D-31)
- **Roles audited:** 18
- **Overall pass rate:** 93.5% (29/31 checks pass)
- **Fails:** 1 (Critical) — fixed during audit
- **Improves:** 1
- **N/A:** 0

### Findings

| ID | Check | Severity | Role(s) | Detail | Resolution |
|----|-------|----------|---------|--------|------------|
| F-01 | D-01 | Critical | All 18 roles | `index.yaml` slug fields and file paths used descriptive names (e.g., `heist-master`, `code-reviewer`) instead of actual disk directory names (e.g., `heist`, `cra`). 17 of 18 entries broken — only `tag` was correct. Any module consumer resolving paths from `index.yaml` would get 404s. | **Fixed.** All 18 entries corrected: slug fields and `files.prompt` / `files.semanticode` paths now match actual `roles/{category}/{id}/` directories. |
| F-02 | D-18 | Low | E.C.H.O. | README uses custom section headers (Architecture, Game Types, Setting Up a Session) instead of the standard Quick Start / Usage Examples pattern used by other role READMEs. Content is comprehensive but structurally non-conformant. | **Noted.** Not fixed — E.C.H.O.'s multi-player architecture justifies a custom README structure. The content covers the same ground as Quick Start and Usage Examples, just under different headings. |

### Per-check results

| # | Check | Result | Notes |
|---|-------|--------|-------|
| D-01 | Index ↔ disk path consistency | **Fixed** | Was Critical fail — all 18 entries corrected |
| D-02 | Slug uniqueness | Pass | All 18 slugs unique after fix |
| D-03 | Category ↔ directory mapping | Pass | All roles in correct category directories |
| D-04 | prompt.md existence | Pass | All 18 prompt.md files exist |
| D-05 | prompt-semanticode.md existence | Pass | All 18 semanticode files exist |
| D-06 | README.md existence per role | Pass | All 18 role READMEs exist |
| D-07 | Bidirectional link integrity | Pass | README → prompt.md links valid; index.yaml → files valid after fix |
| D-08 | Role count consistency | Pass | README, index.yaml, and disk all agree: 18 roles |
| D-09 | Category count consistency | Pass | 6 categories in README match index.yaml and disk |
| D-10 | Version field consistency | Pass | index.yaml version matches README header for all roles |
| D-11 | Status field accuracy | Pass | All 18 roles marked `stable`; no contradictions found |
| D-12 | Description consistency | Pass | index.yaml descriptions align with role README overviews |
| D-13 | Tag accuracy | Pass | Tags reflect actual role capabilities |
| D-14 | Governance field consistency | Pass | risk_tier, ai_tier, data_classification consistent across index.yaml and READMEs |
| D-15 | Safety notes presence | Pass | All health roles and crisis-risk roles have safety_notes |
| D-16 | README template: header format | Pass | All READMEs follow `# NAME — Expanded Name` + version/category blockquote |
| D-17 | README template: required sections | Pass | 17/18 have Overview, Quick Start, Usage Examples, Files |
| D-18 | README template: section ordering | Improve | E.C.H.O. uses custom structure (justified by multi-player architecture) |
| D-19 | Prompt template: XML structure | Pass | All prompts use `<MASTER_PROMPT>` with expected subsections |
| D-20 | SemantiCode template: compression header | Pass | All semanticode files have mode/reduction headers |
| D-21 | Writing quality: grammar and spelling | Pass | No systematic issues found |
| D-22 | Writing quality: consistent terminology | Pass | Role names, acronyms used consistently |
| D-23 | Writing quality: code block formatting | Pass | All code blocks have language tags where applicable |
| D-24 | Writing quality: table formatting | Pass | Markdown tables render correctly |
| D-25 | Diataxis classification coverage | Pass | READMEs cover tutorial (Quick Start), how-to (Usage Examples), reference (Commands/Files) |
| D-26 | Provenance currency | Pass | Dates reflect actual creation/modification times |
| D-27 | AI-specific: intended use documented | Pass | All roles document usage context (paste_in, system_prompt, auto_init) |
| D-28 | AI-specific: limitations documented | Pass | Health roles document scope limits; safety_notes cover deployment caveats |
| D-29 | AI-specific: risk tier documented | Pass | All governance blocks include risk_tier and ai_tier |
| D-30 | AI-specific: GDPR classification | Pass | Special category flagged for all health roles processing Art. 9 data |
| D-31 | AI-specific: EU AI Act tier | Pass | Health and education roles with minors/vulnerability have eu_ai_act_tier: limited |

### Previous audit
- **Date:** none (first documentation integrity audit)
- **Delta:** N/A — baseline established

### Methodology

Audit executed against `src/audit-docs.md` (31-check documentation integrity checklist).
Sources consulted: Diataxis, ISO/IEC/IEEE 26514:2022, EU AI Act Annex IV, Model Cards for Model Reporting.
Source registry: `audits/sources-docs.yaml` (6 primary, 5 secondary sources).
