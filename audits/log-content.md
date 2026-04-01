# Content Quality Audit Log

## 2026-04-01

### Summary

- **Roles audited:** 18
- **Overall pass rate:** 82.8% (159 / 192 applicable checks)
- **Fails:** 5 across 5 roles
- **Improves:** 28 across 16 roles

### Per-role results

| Role | C-01 | C-02 | C-03 | C-04 | C-05 | C-06 | C-07 | C-08 | C-09 | C-10 | C-11 | C-12 | Score |
|------|------|------|------|------|------|------|------|------|------|------|------|------|-------|
| T.A.G. | pass | pass | pass | pass | N/A | N/A | pass | pass | pass | pass | pass | — | 9/9 |
| H.E.I.S.T. | pass | pass | pass | pass | N/A | N/A | pass | pass | pass | pass | pass | — | 9/9 |
| D.I.C.E. | pass | pass | pass | pass | N/A | N/A | pass | pass | pass | pass | pass | — | 9/9 |
| E.C.H.O. | pass | pass | improve | pass | N/A | N/A | improve | pass | pass | pass | pass | — | 7/9 |
| C.R.A. | pass | pass | pass | pass | N/A | N/A | pass | pass | pass | pass | pass | — | 9/9 |
| F.O.R.G.E. | pass | pass | pass | pass | N/A | N/A | pass | pass | pass | pass | pass | — | 9/9 |
| Q.A.V.E. | pass | pass | pass | pass | N/A | N/A | pass | pass | pass | pass | pass | — | 9/9 |
| P.S.Y. | pass | pass | pass | pass | fail | pass | pass | pass | pass | pass | improve | — | 8/11 |
| F.R.A.N.K. | pass | pass | pass | pass | fail | pass | pass | pass | pass | pass | improve | — | 8/11 |
| P.A.P.A. | pass | pass | pass | pass | N/A | pass | improve | pass | improve | pass | pass | — | 7/9 |
| V.I.T.A. | pass | pass | pass | pass | fail | pass | pass | pass | pass | pass | improve | — | 8/11 |
| A.G.O.R.A. | pass | pass | improve | pass | fail | pass | pass | pass | pass | pass | improve | — | 7/11 |
| S.C.O.U.T. | pass | pass | pass | pass | N/A | pass | pass | pass | pass | pass | improve | — | 8/9 |
| M.E.N.T.O.R. | fail | pass | pass | pass | N/A | pass | improve | improve | improve | pass | pass | — | 5/9 |
| A.T.L.A.S. | pass | pass | pass | pass | N/A | N/A | pass | pass | pass | pass | pass | — | 9/9 |
| S.C.R.I.B.E. | pass | pass | pass | pass | N/A | N/A | pass | pass | pass | pass | pass | — | 9/9 |
| A.G.L. | pass | pass | pass | pass | N/A | pass | pass | pass | pass | pass | improve | — | 8/9 |
| P.R.I.M.E. | pass | pass | pass | pass | N/A | pass | pass | pass | pass | pass | pass | — | 9/9 |

### Findings

| ID | Role(s) | Topic | Severity | Detail | Suggestion |
|----|---------|-------|----------|--------|------------|
| F-01 | P.S.Y., F.R.A.N.K., V.I.T.A., A.G.O.R.A. | C-05 | fail | Dutch crisis line number listed as 0800-0113 across all four roles. The correct long-format number for 113 Zelfmoordpreventie is **0900-0113**. The short number 113 is correct, but the long-format alternative is wrong. A person dialling 0800-0113 would reach nothing or a wrong service. | Replace `0800-0113` with `0900-0113` in all four prompt files and their semanticode variants. Verify against 113.nl. |
| F-02 | A.G.O.R.A. | C-05 | improve | French crisis resource lists "SOS Amitie: 09 72 39 40 50" instead of the national suicide prevention number 3114, which is the government-promoted standard. Other health roles correctly use 3114. Inconsistency across roles, though SOS Amitie is a legitimate service. | Replace with "3114 (numero national de prevention du suicide, 24h/24)" to match the other roles and align with the French government's promoted number. |
| F-03 | M.E.N.T.O.R. | C-01 | fail | The PERSONA section hardcodes the name "Flynn" in "Flynn's confusion is the curriculum's fault". This breaks persona coherence for a generic study coach -- it implies a specific student, creating confusion when any other student uses the role. | Replace "Flynn's confusion" with "the student's confusion" or a generic formulation like "their confusion". |
| F-04 | E.C.H.O. | C-03 | improve | Only one worked example provided (quest type action relay). With 15 game types (including the complex echo type with convergence mechanics), a single example does not showcase the full range of the role's capabilities. | Add at least one example for the echo game type (chapter delivery + convergence) and one for a competitive type (whodunnit or tournament). |
| F-05 | E.C.H.O. | C-07 | improve | Dutch-only output is appropriate for the target audience but the echo game type descriptions contain a Dutch spelling error: "Kamers worden betreedt" should be "Kamers worden betreden" (past participle, not third-person singular). | Fix "betreedt" to "betreden" in the echo game type description. |
| F-06 | P.A.P.A. | C-07 | improve | The role is designed exclusively for divorced fathers with a son. While the specificity is intentional and stated, the hardcoded gender ("he", "his", "teenage boy") and family structure (divorced heterosexual couple, week-on/week-off) limits cultural transferability. The README acknowledges this scope, but the prompt offers no adaptation path for other configurations. | Consider adding a brief note in the persona or README that the prompt can be adapted for other family structures by modifying the gendered language and co-parenting schedule references. |
| F-07 | P.A.P.A. | C-09 | improve | The birth year 2011 is hardcoded in the STATE_SCHEMA (son_birth_year: 2011). The age calculation (current_year - 2011) means the advice calibration will become incorrect over time as the son ages beyond adolescence. | Replace the hardcoded birth year with a user-supplied value at session open, or make the age range part of the session contract. |
| F-08 | M.E.N.T.O.R. | C-07 | improve | The role is scoped to VWO klas 3 and three specific Dutch subjects (wiskunde, natuurkunde, scheikunde). While the scope is clearly stated, the prompt includes no mechanism for the student to indicate they are in a different klas level, which may cause confusion for klas 2 or 4 students who encounter the prompt. | Add a brief scope clarification at session open: "Ik werk op VWO klas 3 niveau. Zit je in een andere klas? Laat het weten." |
| F-09 | M.E.N.T.O.R. | C-08 | improve | The persona says "You are never cruel to the student — Flynn's confusion is the curriculum's fault, not his." The use of "his" assumes the student is male. This creates an ambiguity for an LLM processing the prompt with a female student. | Use gender-neutral language in the persona: "their confusion" instead of "his". |
| F-10 | M.E.N.T.O.R. | C-09 | improve | The prompt references detailed topic lists for klas 3 only. If a student is slightly ahead or behind (e.g., reviewing klas 2 material or previewing klas 4), the strict scope enforcement will reject valid learning requests. | Consider a soft boundary: allow adjacent-klas topics with a note like "Dit onderwerp zit eigenlijk in klas 2/4, maar we pakken het aan." |
| F-11 | S.C.O.U.T. | C-11 | improve | The SLO eindtermen domains are hardcoded. SLO periodically updates its domain structures. The prompt includes a mitigation ("raadpleeg slo.nl voor de meest actuele versie") but the hardcoded domain list itself could become stale. | Add a version date to the SLO domain list and a maintenance note: "SLO domeinen laatst geverifieerd: [datum]. Raadpleeg slo.nl bij twijfel." |
| F-12 | A.G.L. | C-11 | improve | The EU AI Act classification framework references specific articles (Art. 5, 6, 50, Annex III). As the Act enters full enforcement (2026-2027), delegated acts and implementing regulations may shift criteria. The prompt has no versioning or "last verified" date for the regulatory content. | Add a "Regulatory reference verified as of: [date]" field in the CLASSIFICATION_FRAMEWORK section. |
| F-13 | P.S.Y. | C-11 | improve | Crisis resources (phone numbers, URLs) are embedded directly in the prompt with no versioning or "last verified" date. While numbers are generally stable, the Portuguese and Italian numbers are less well-known and may change. | Add a "Crisis resources last verified: [date]" comment in the CRISIS_RESOURCES_BY_LANGUAGE section. |
| F-14 | F.R.A.N.K. | C-11 | improve | Same as F-13: crisis and DV resources lack a "last verified" date. DV helpline numbers across seven countries are embedded with no update tracking. | Add a "last verified" date comment. |
| F-15 | V.I.T.A. | C-11 | improve | Same as F-13: crisis resources lack versioning. | Add a "last verified" date comment. |
| F-16 | A.G.O.R.A. | C-11 | improve | Crisis resources cover only 5 languages (en, nl, de, fr, es) versus the 7+ in health roles. The prompt claims multilingual support with no language restriction, but crisis resources have gaps for pt and it. | Add Portuguese and Italian crisis resources, or add a default fallback with findahelpline.com for unlisted languages. |
| F-17 | E.C.H.O. | C-03 | improve | The echo game type description in GAME_TYPES has no worked example showing the convergence mechanic, which is the most novel and complex feature. The single quest example does not demonstrate this. | Add a worked example showing an echo chapter delivery and convergence status update. |

### Improvement backlog

| Role | Suggestion | Impact | Effort |
|------|-----------|--------|--------|
| P.S.Y., F.R.A.N.K., V.I.T.A., A.G.O.R.A. | Add "Crisis resources last verified: [date]" comments to all crisis resource blocks | Medium | Low |
| A.G.O.R.A. | Expand crisis resources to cover pt and it languages, matching health role coverage | Medium | Low |
| A.G.O.R.A. | Replace French crisis number with 3114 to match other roles | Medium | Low |
| E.C.H.O. | Add 2-3 additional worked examples covering echo and competitive game types | Medium | Medium |
| E.C.H.O. | Fix Dutch spelling "betreedt" to "betreden" in echo game type description | Low | Low |
| M.E.N.T.O.R. | Use gender-neutral language in persona (replace "his" with "their") | Low | Low |
| M.E.N.T.O.R. | Add klas-level clarification at session open | Low | Low |
| M.E.N.T.O.R. | Allow soft boundary for adjacent-klas topics | Medium | Low |
| P.A.P.A. | Add adaptation note for other family structures in README | Low | Low |
| P.A.P.A. | Make son's birth year user-configurable instead of hardcoded 2011 | Medium | Medium |
| S.C.O.U.T. | Add version date to hardcoded SLO domain list | Low | Low |
| A.G.L. | Add regulatory reference verification date to classification framework | Low | Low |
| T.A.G. | Add a second worked example showing a different interaction type (e.g., combat, NPC dialogue) | Low | Low |
| H.E.I.S.T. | Add worked example for PLAN phase assessment | Low | Low |
| D.I.C.E. | Add worked example showing CRACK mechanic in action | Low | Low |
| C.R.A. | Add worked example for a multi-finding review with mixed severities | Low | Low |
| F.O.R.G.E. | Add worked example for INFRA task type or architecture decision | Low | Low |
| Q.A.V.E. | Add worked example for defect report or risk assessment mode | Low | Low |
| P.R.I.M.E. | Add worked example for APPROVED and REJECTED verdicts (only NEEDS_CLARIFICATION shown) | Low | Low |

### Previous audit
- **Date:** none
- **Delta:** First content audit. No previous results to compare.
