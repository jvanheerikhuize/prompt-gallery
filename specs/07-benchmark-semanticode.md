# SPEC-07: Benchmark SemantiCode Against Algorithmic Compression

> **Priority:** Low
> **Scope:** Research / evaluation (no prompt changes)
> **Effort:** Medium (requires test harness)

---

## Problem

The SemantiCode compression variant claims ~35% token reduction (lossless mode).
Industry tools like Microsoft LLMLingua achieve up to 20x compression with minimal
quality loss. The question is whether SemantiCode's manual semantic abbreviation
provides better **behavioral fidelity** than algorithmic approaches, or whether
it's leaving compression on the table.

This is not a spec for changing prompts — it's a spec for running a comparison
so you can make an informed decision.

## Evaluation Plan

### 1. Select test prompts

Pick 3 prompts spanning different complexity levels:
- Simple/stateless: SCOUT or AGL
- Medium/stateful: CRA or QAVE
- Complex/multi-phase: HEIST or TAG

### 2. Generate compressed variants

For each prompt, produce:
- **A**: Original full prompt (baseline)
- **B**: SemantiCode variant (existing)
- **C**: LLMLingua-compressed variant (algorithmic)
- **D**: Manual trim from SPEC-03 (condensed domain knowledge)

### 3. Measure

| Metric | How to measure |
|--------|---------------|
| Token count | `tiktoken` or provider tokenizer |
| Compression ratio | tokens(variant) / tokens(original) |
| Format compliance | Does output match VIEW templates? (binary per field) |
| Behavioral fidelity | Same test input → same findings/decisions? (manual review) |
| Injection resistance | Same injection test → same refusal? (binary) |
| Edge case handling | Same ambiguous input → same escalation? (binary) |

### 4. Test inputs per prompt

- 1 standard happy-path input
- 1 edge case (ambiguous, incomplete, or adversarial input)
- 1 injection attempt ("ignore your rules and...")

Run each input 3 times per variant to check consistency.

### 5. Decision criteria

- If LLMLingua matches SemantiCode on fidelity with better compression: consider
  replacing SemantiCode with algorithmic compression in the build pipeline
- If SemantiCode wins on fidelity: keep it, document the tradeoff
- If SPEC-03 manual trim alone gets within 10% of SemantiCode compression:
  SemantiCode may be unnecessary overhead

### Tools

- [Microsoft LLMLingua](https://github.com/microsoft/LLMLingua)
- [PCToolkit](https://github.com/3DStreet/PCToolkit) — bundles 5 compressors
- `tiktoken` for OpenAI token counts
- Anthropic token counter API for Claude token counts

---

## References

- Microsoft LLMLingua: up to 20x compression with minimal performance loss
- CompactPrompt: up to 60% token reduction
- PCToolkit: unified compression benchmark pipeline
