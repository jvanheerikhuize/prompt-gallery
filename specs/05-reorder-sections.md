# SPEC-05: Reorder Prompt Sections (Instructions Last)

> **Priority:** Medium
> **Scope:** Template + all role prompts
> **Effort:** Low (structural move, no content change)

---

## Problem

Anthropic's research shows placing instructions and behavioral rules closer to
where user input appears (the end of the system prompt) improves response quality
by up to 30%, especially with complex multi-document inputs. The principle:
**long-form context at the top, actionable instructions at the bottom**.

Current ordering:
1. CORE_DIRECTIVES (identity + rules)
2. MODEL (state + domain rules)
3. VIEW (output templates)
4. CONTROLLER (workflow)

The identity and rules are at the top, far from where the model transitions to
processing user input.

## Change

### New section order

```xml
<MASTER_PROMPT version="1.1" api_role="system">

    <!-- 1. Identity — who you are (short, anchoring) -->
    <PERSONA>
        ...role, tone, communication style...
    </PERSONA>

    <!-- 2. Domain knowledge — reference material, state schema -->
    <STATE>
        ...state schema, domain-specific data structures...
    </STATE>

    <!-- 3. Output templates — how to format responses -->
    <OUTPUT>
        ...named templates...
    </OUTPUT>

    <!-- 4. Examples — worked input/output pairs (from SPEC-04) -->
    <EXAMPLES>
        ...
    </EXAMPLES>

    <!-- 5. Rules and constraints — closest to user input -->
    <RULES>
        ...injection defense, scope limits, behavioral constraints...
        ...language detection / directive...
        ...crisis protocol (if applicable)...
        ...GDPR disclosure (if applicable)...
    </RULES>

    <!-- 6. Workflow — processing steps, session loop, error handling -->
    <WORKFLOW>
        ...init, session loop, phases, error handling, console commands...
    </WORKFLOW>

</MASTER_PROMPT>
```

### Key changes from current structure

| Current | New | Rationale |
|---------|-----|-----------|
| `<CORE_DIRECTIVES>` (bundled) | Split into `<PERSONA>` (top) + `<RULES>` (bottom) | Identity anchors early; rules enforce late |
| `<MODEL>` | `<STATE>` | Clearer name, no MVC connotation |
| `<VIEW>` | `<OUTPUT>` | Clearer name |
| `<CONTROLLER>` | `<WORKFLOW>` | Clearer name |
| Rules at position 1 | Rules at position 5 | Closer to user input boundary |

### Migration notes

- This is a structural move — no content changes required (content changes
  are covered by SPEC-01 through SPEC-04)
- Update the template first, then each role prompt
- The `<MASTER_PROMPT>` version attribute should bump to reflect the new structure
- If SPEC-01 (drop MVC) and SPEC-02 (soften language) are applied first, this
  reorder becomes a clean move of already-updated content

### Verification

- Each prompt follows the new section order
- Behavioral spot-check: compare response quality on a standardized test input
  before and after reorder

---

## References

- Anthropic: queries at the end improve quality by up to 30%
- Anthropic: "Place longform data/documents at the TOP, with queries and
  instructions BELOW"
