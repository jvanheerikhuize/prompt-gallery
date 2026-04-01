# SPEC-04: Add Few-Shot Examples to Each Prompt

> **Priority:** High
> **Scope:** Template + all role prompts
> **Effort:** High (1-2 examples per prompt, manually authored)

---

## Problem

All three major providers (Anthropic, OpenAI, Google) recommend 1-5 examples in
system prompts, especially for roles with specific output formats. The current
prompts contain zero examples. This is the single most impactful gap — examples
are consistently shown to improve format compliance and behavioral accuracy more
than additional rules.

## Change

### 1. Add an `<EXAMPLES>` section to the template

Place it between `<VIEW>` and `<CONTROLLER>` (after output templates are defined,
before the workflow that references them):

```xml
<EXAMPLES>
    <!-- 1-2 worked examples showing a complete input → output cycle.
         Each example demonstrates the expected VIEW template usage. -->

    <EXAMPLE id="1">
        <INPUT>
            {{EXAMPLE_USER_INPUT}}
        </INPUT>
        <OUTPUT>
            {{EXAMPLE_AGENT_OUTPUT}}
        </OUTPUT>
    </EXAMPLE>

    <!-- Optional second example showing an edge case or alternate path -->
    <EXAMPLE id="2">
        <INPUT>
            {{EXAMPLE_EDGE_CASE_INPUT}}
        </INPUT>
        <OUTPUT>
            {{EXAMPLE_EDGE_CASE_OUTPUT}}
        </OUTPUT>
    </EXAMPLE>
</EXAMPLES>
```

### 2. Example guidelines per prompt type

| Prompt type | Example 1 should show | Example 2 should show |
|-------------|----------------------|----------------------|
| CRA | A short code snippet with 1 critical + 1 low finding → full report | Clean code → EMPTY_REVIEW output |
| QAVE | A ticket → test plan with gap list | A diff → defect report |
| TAG/HEIST/DICE | A player action → narrated response with state update | An invalid action → error handling |
| PSY/FRANK/VITA | A user message → structured session response | A crisis keyword → crisis protocol activation |
| SCOUT | A subject + topic → THEME_OVERVIEW | — (single-task, one example sufficient) |
| AGL/PRIME | A component description → VERDICT block | A downgrade request → refusal |

### 3. Example authoring rules

- Keep examples **short** — show the structure, not a full session
- Use realistic but generic content (no real code repos, no real patient data)
- The example output must exactly match the VIEW templates defined above it
- For crisis-sensitive roles (PSY, FRANK, VITA), the crisis example should show
  the tiered response without including graphic content
- Wrap examples in `<EXAMPLE>` tags — Anthropic specifically recommends this

### 4. Token budget

Target: each example adds 100-200 tokens. Two examples = 200-400 tokens per prompt.
This is offset by the token savings from SPEC-03 (trimming domain knowledge).

### Verification

- Each prompt contains 1-2 `<EXAMPLE>` blocks
- Example outputs match the VIEW templates exactly (same field names, same structure)
- Behavioral spot-check: compare output format compliance before and after adding
  examples — expect measurable improvement in template adherence

---

## References

- Anthropic: "Use examples" is step 2 of their five-step hierarchy
- OpenAI: few-shot with clear delineation
- Google: "1-3 when format matters"
- Research: examples improve format compliance more than additional rules
