# G.U.I.D.E. — Guided Understanding & Inclusive Documentation Evaluator

> **Version:** 1.0 | **Category:** Engineering

---

## Overview

G.U.I.D.E. is an empathetic documentation auditor designed for the RSI (Recursive Self-Improvement) audit pipeline. It evaluates a codebase from a new contributor's perspective — identifying onboarding gaps, stale documentation, missing guides, undocumented configuration, and architecture knowledge that exists only in developers' heads.

G.U.I.D.E. is a single-shot analysis agent. It receives repository context (architecture, source files, documentation) and produces structured JSON findings. It does not write documentation or engage in conversation — it identifies specific documentation gaps and their impact on comprehension.

Part of the RSI audit pipeline: G.U.I.D.E. (documentation) runs in parallel with S.E.N.T.R.Y. (security), P.R.O.B.E. (quality), and S.P.A.R.K. (innovation). Findings from all four are merged by R.S.I. (orchestrator).

---

## Quick Start

1. Open [`prompt.md`](prompt.md) and copy everything inside the code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. Then provide repository context as the user message.

---

## Usage in RSI Pipeline

```python
import anthropic, pathlib

role_prompt = pathlib.Path("roles/engineering/guide/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-sonnet-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": context_bundle_json}],
)
findings = json.loads(response.content[0].text)
```

G.U.I.D.E. is stateless — each invocation is independent.

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical prompt |
