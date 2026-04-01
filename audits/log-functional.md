# Functional Readiness Audit Log

## 2026-04-01

### Summary

- **Roles audited:** 18
- **Overall pass rate:** 78% (130 / 167 applicable checks)
- **Fails:** 12 across 8 roles
- **Warns:** 25 across 16 roles

### Per-role results

| Role | F-01 | F-02 | F-03 | F-04 | F-05 | F-06 | F-07 | F-08 | F-09 | F-10 | F-11 | F-12 | Score |
|------|------|------|------|------|------|------|------|------|------|------|------|------|-------|
| T.A.G. | pass | pass | pass | pass | warn | pass | pass | pass | pass | N/A | N/A | N/A | 8/9 |
| H.E.I.S.T. | pass | pass | pass | pass | warn | pass | pass | pass | pass | N/A | N/A | N/A | 8/9 |
| D.I.C.E. | pass | pass | pass | pass | pass | pass | pass | pass | pass | N/A | N/A | N/A | 9/9 |
| E.C.H.O. | pass | pass | warn | pass | warn | pass | pass | pass | pass | warn | N/A | N/A | 8/11 |
| C.R.A. | pass | pass | pass | pass | pass | pass | pass | pass | pass | N/A | N/A | N/A | 9/9 |
| F.O.R.G.E. | pass | pass | pass | pass | warn | pass | N/A | pass | pass | N/A | N/A | N/A | 7/8 |
| Q.A.V.E. | pass | pass | pass | pass | warn | pass | N/A | pass | pass | N/A | N/A | N/A | 7/8 |
| P.S.Y. | pass | pass | pass | pass | warn | pass | pass | pass | pass | N/A | pass | pass | 10/11 |
| F.R.A.N.K. | pass | pass | pass | pass | warn | pass | pass | pass | pass | N/A | pass | pass | 10/11 |
| P.A.P.A. | pass | pass | fail | pass | warn | pass | pass | pass | pass | N/A | fail | fail | 7/11 |
| V.I.T.A. | pass | pass | pass | pass | warn | pass | pass | pass | pass | N/A | pass | pass | 10/11 |
| A.G.O.R.A. | pass | pass | pass | pass | warn | pass | pass | warn | pass | N/A | warn | N/A | 7/10 |
| S.C.O.U.T. | N/A | N/A | N/A | pass | warn | pass | N/A | pass | pass | N/A | N/A | N/A | 4/5 |
| M.E.N.T.O.R. | pass | pass | pass | pass | warn | pass | pass | pass | pass | N/A | fail | N/A | 8/10 |
| A.T.L.A.S. | N/A | N/A | N/A | pass | warn | pass | N/A | warn | pass | N/A | N/A | N/A | 3/5 |
| S.C.R.I.B.E. | N/A | N/A | N/A | pass | warn | pass | N/A | warn | pass | N/A | N/A | N/A | 3/5 |
| A.G.L. | N/A | N/A | N/A | pass | warn | pass | N/A | pass | pass | N/A | N/A | N/A | 4/5 |
| P.R.I.M.E. | N/A | N/A | N/A | pass | warn | pass | N/A | pass | pass | N/A | N/A | N/A | 4/5 |

### Findings

| ID | Role(s) | Topic | Severity | Detail |
|----|---------|-------|----------|--------|
| FN-01 | T.A.G., H.E.I.S.T., E.C.H.O., F.O.R.G.E., Q.A.V.E., P.S.Y., F.R.A.N.K., P.A.P.A., V.I.T.A., A.G.O.R.A., S.C.O.U.T., M.E.N.T.O.R., A.T.L.A.S., S.C.R.I.B.E., A.G.L., P.R.I.M.E. | F-05 | warn | Only one example provided. The base template expects two examples (one happy path, one edge case). Only D.I.C.E. and C.R.A. have two examples. Missing edge-case examples reduce evaluator confidence but do not break functionality. |
| FN-02 | P.A.P.A. | F-03 | fail | STATE_SCHEMA field `disclaimer_rendered` is defined but never written by any workflow step. No DISCLAIMER_TRIGGER section exists to set this field. The field is orphaned — defined but never touched by the workflow. |
| FN-03 | P.A.P.A. | F-11 | fail | P.A.P.A. is a health role (category: health) with no crisis protocol. The index.yaml `safety_notes` explicitly flags this: "No crisis protocol — add before production use." A parent discussing co-parenting could disclose domestic violence, child welfare concerns, or personal mental health crisis. No crisis detection, no sentinel patterns, no crisis resources, and no tiered response. |
| FN-04 | P.A.P.A. | F-12 | fail | STATE_SCHEMA contains `disclaimer_rendered: false` but no DISCLAIMER_TRIGGER_PATTERNS section exists. The GDPR disclosure is embedded in SESSION_OPEN_TEMPLATE but there is no mechanism to trigger a disclaimer on scope-crossing requests (e.g., legal advice, clinical requests). The `scope_redirects` counter increments but no FULL_DISCLAIMER template exists. |
| FN-05 | M.E.N.T.O.R. | F-11 | fail | M.E.N.T.O.R. is an education role targeting students (potentially minors). It has a DISTRESS_ACKNOWLEDGE handler but lacks a full crisis protocol: no sentinel patterns (first-person/third-person), no tiered crisis response, no crisis resources, and no CONSERVATIVE_CRISIS_POLICY. The SCOPE_LIMITS note "no crisis intervention" but a student disclosing self-harm or abuse needs more than a distress acknowledgement and scope redirect. |
| FN-06 | E.C.H.O. | F-03 | warn | The STATE_SCHEMA contains a complex `echo` sub-object with fields like `convergence_status`, `chapters_delivered`, and `chapters_total`. These fields are referenced in the workflow logic, but some echo-specific state fields (e.g., `emotion_tags` within chapter definitions) are managed implicitly rather than explicitly mapped in the schema. Functional but could cause confusion. |
| FN-07 | E.C.H.O. | F-10 | warn | E.C.H.O. hub (prompt.md) and spoke (prompt-player.md) are broadly consistent — shared output template names (ECHO_CHAPTER, ECHO_WACHT, ECHO_FINALE) align. However, the spoke template defines OUT:ACTIE_BEVESTIGING and OUT:UITKOMST_ONTVANGEN which are spoke-specific and not referenced in the hub. The hub's GENEREER SPOKE command produces the spoke, but the hub does not document the full set of spoke output templates. Minor consistency gap. |
| FN-08 | A.G.O.R.A. | F-08 | warn | A.G.O.R.A. defines 3 ON_ERR handlers (empty_input, out_of_scope, unrecognised_input) — the three standard types. However, the workflow includes depth-level transitions and philosophical inquiry phases that could produce domain-specific errors (e.g., student requests a depth level beyond their demonstrated capacity). No domain-specific error handler covers this. |
| FN-09 | A.G.O.R.A. | F-11 | warn | A.G.O.R.A. has a CRISIS_PROTOCOL with 2 tiers but does not explicitly state the CONSERVATIVE_CRISIS_POLICY ("ambiguous signals → check in"). The crisis detection relies on keyword matching but does not enumerate first-person vs. third-person sentinel patterns separately. Functional but less thorough than health roles. |
| FN-10 | A.T.L.A.S. | F-08 | warn | A.T.L.A.S. defines 3 ON_ERR handlers (standard types). The 12-step REQUEST_LOOP includes a complex rendering pipeline (grid size calculation, symbol mapping, label placement) that could produce domain-specific errors (e.g., requested area too large for ASCII grid, conflicting map elements). No domain-specific error handlers exist. |
| FN-11 | S.C.R.I.B.E. | F-08 | warn | S.C.R.I.B.E. defines 3 ON_ERR handlers (standard types). The compression pipeline includes 3 modes (LOSSLESS, BALANCED, COMPACT) and grammar rule application. Mode-specific errors (e.g., input prompt too short to compress meaningfully, grammar rule conflicts) have no dedicated handlers. |
| FN-12 | E.C.H.O. | F-05 | warn | E.C.H.O. has 1 example showing GM action-relay adjudication. For the most complex role in the library (15 game types, hub-and-spoke architecture, convergence sync), a single example is insufficient. No echo-type game example is shown, and no spoke-side example exists in prompt-player.md (EXAMPLES section is empty). |

### Previous audit
- **Date:** none
- **Delta:** First functional audit — no comparison baseline.
