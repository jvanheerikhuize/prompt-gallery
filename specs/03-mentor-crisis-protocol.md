# 03 — Upgrade M.E.N.T.O.R. distress handling to full crisis protocol

**Priority:** High
**Scope:** `roles/education/mentor/prompt.md`
**Effort:** Medium (1 prompt edit, requires crisis resource research for student/minor context)

## Problem

M.E.N.T.O.R. is an education role that serves as a study coach, potentially interacting with minors. It has a DISTRESS_ACKNOWLEDGE handler that pauses the session and appends to `safety_flags`, but lacks a full crisis protocol:

- No sentinel patterns (first-person or third-person) for systematic detection
- No tiered crisis response (all distress gets the same handler)
- No crisis resources (helplines, support services)
- No CONSERVATIVE_CRISIS_POLICY (ambiguous → check in)
- No distinction between academic frustration and genuine safeguarding concern

A student disclosing self-harm, abuse, bullying, or suicidal ideation receives only a generic distress acknowledgement and a pause offer. This is insufficient for a role that may interact with minors.

Audit failure: **F-11 (Crisis protocol completeness)** — no sentinel patterns, no tiered response, no crisis resources, no conservative policy.

## Change

1. Add a `<CRISIS_PROTOCOL>` section to RULES with:
   - First-person sentinels appropriate for student context (e.g., "I want to hurt myself", "I can't take it anymore", "nobody cares about me")
   - Third-person sentinels (e.g., "my friend is cutting", "someone at school threatened me")
   - Safeguarding sentinels (e.g., "my teacher/parent hits me", "I'm afraid to go home")
   - Tier 1 (elevated distress — validate, pause study session, offer to talk or redirect)
   - Tier 2 (active crisis/safeguarding — stop session, provide age-appropriate resources)
   - Crisis resources: student-appropriate helplines (Childline/equivalent, 113 Zelfmoordpreventie for NL, etc.)
   - CONSERVATIVE_CRISIS_POLICY: ambiguous distress signals → check in before resuming study content
2. Upgrade `ON_ERR:distress-disclosure` to invoke the tiered crisis protocol.
3. Add crisis detection to SESSION_LOOP input gate (before DIAGNOSE/TEACH steps).
4. Suspend HUMOR_PROTOCOL when crisis is detected (already partially covered by existing suspension rules, but make explicit).

## Verification

- CRISIS_PROTOCOL section exists with first-person, third-person, and safeguarding sentinels.
- Crisis resources are age-appropriate and localised.
- CONSERVATIVE_CRISIS_POLICY is stated explicitly.
- Manually trace: student says "I don't want to be alive anymore" → Tier 2 fires, session stops, resources rendered.
- Manually trace: student says "I'm really stressed about everything" (ambiguous) → conservative check-in fires before resuming study content.
- HUMOR_PROTOCOL suspension on crisis is explicit.
