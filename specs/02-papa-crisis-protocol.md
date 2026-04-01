# 02 — Add crisis protocol to P.A.P.A.

**Priority:** Critical
**Scope:** `roles/health/papa/prompt.md`
**Effort:** Medium (1 prompt edit, requires crisis resource research)

## Problem

P.A.P.A. is a health-category role advising a divorced father on co-parenting a teenage son. The index.yaml `safety_notes` explicitly flags: "No crisis protocol — add before production use." Despite this, no CRISIS_PROTOCOL section exists in the prompt.

A parent discussing co-parenting could disclose:
- Domestic violence (current or historical)
- Child welfare concerns (abuse, neglect, self-harm by the child)
- Personal mental health crisis (suicidal ideation, severe depression)

Without crisis detection, sentinel patterns, tiered response, or crisis resources, P.A.P.A. would continue normal co-parenting advice when a user discloses active danger. This is a safety-critical gap.

Audit failure: **F-11 (Crisis protocol completeness)** — no crisis detection, no sentinels, no resources, no CONSERVATIVE_CRISIS_POLICY.

## Change

1. Add a `<CRISIS_PROTOCOL>` section to RULES with:
   - First-person sentinels (e.g., "I want to hurt myself", "I can't go on")
   - Third-person sentinels (e.g., "he's hurting himself", "she hits him", "he told me he wants to die")
   - Child welfare sentinels (e.g., "my son said he was hit", "bruises", "he's afraid to go back")
   - Tiered response: Tier 1 (elevated distress — check in, pause advice), Tier 2 (active crisis — stop session, provide resources)
   - Crisis resources for supported languages (at minimum: en, nl)
   - CONSERVATIVE_CRISIS_POLICY: ambiguous signals → check in before continuing
2. Add an `ON_ERR:crisis_detected` handler that invokes the crisis protocol.
3. Add crisis detection to the SESSION_LOOP input gate (before main processing).
4. Suspend HUMOR_PROTOCOL when crisis is detected.

## Verification

- CRISIS_PROTOCOL section exists with first-person and third-person sentinels.
- Crisis resources are localised for en and nl.
- CONSERVATIVE_CRISIS_POLICY is stated explicitly.
- Manually trace: user says "My son told me he wants to die" → Tier 2 fires, session pauses, resources rendered.
- Manually trace: user says "I'm really struggling" (ambiguous) → conservative check-in fires.
- HUMOR_PROTOCOL suspension on crisis is documented.
