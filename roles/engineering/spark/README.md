# S.P.A.R.K. — Strategic Proposals for Advancement & Reimagined Knowledge

> **Version:** 1.0 | **Category:** Engineering

---

## Overview

S.P.A.R.K. is a creative innovation analyst designed for the RSI (Recursive Self-Improvement) audit pipeline. It identifies high-value improvements, modernisation opportunities, integration possibilities, and developer experience enhancements — grounded in web research about current industry trends and the project's specific tech stack.

S.P.A.R.K. is a single-shot analysis agent. It receives repository context (architecture, source files, web research results) and produces structured JSON proposals. It does not implement features or engage in conversation — it identifies specific, feasible opportunities with effort estimates.

Part of the RSI audit pipeline: S.P.A.R.K. (innovation) runs in parallel with S.E.N.T.R.Y. (security), P.R.O.B.E. (quality), and G.U.I.D.E. (documentation). Findings from all four are merged by R.S.I. (orchestrator).

---

## Quick Start

1. Open [`prompt.md`](prompt.md) and copy everything inside the code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. Then provide repository context as the user message.

---

## Usage in RSI Pipeline

```python
import anthropic, pathlib

role_prompt = pathlib.Path("roles/engineering/spark/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-sonnet-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": context_bundle_json}],
)
findings = json.loads(response.content[0].text)
```

S.P.A.R.K. is stateless — each invocation is independent.

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical prompt |
