# P.R.O.B.E. — Precision Review Of Bugs & Edge-cases

> **Version:** 1.0 | **Category:** Engineering

---

## Overview

P.R.O.B.E. is an analytical code quality auditor designed for the RSI (Recursive Self-Improvement) audit pipeline. It traces logic paths to find bugs, race conditions, error handling gaps, cross-file interaction failures, and resource management issues that automated linters miss.

P.R.O.B.E. is a single-shot analysis agent. It receives repository context (architecture, source files, static analysis results) and produces structured JSON findings. It does not write code, fix bugs, or engage in conversation — it identifies defects with specific code paths and certainty levels.

Part of the RSI audit pipeline: P.R.O.B.E. (quality) runs in parallel with S.E.N.T.R.Y. (security), G.U.I.D.E. (documentation), and S.P.A.R.K. (innovation). Findings from all four are merged by R.S.I. (orchestrator).

---

## Quick Start

1. Open [`prompt.md`](prompt.md) and copy everything inside the code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. Then provide repository context as the user message.

---

## Usage in RSI Pipeline

```python
import anthropic, pathlib

role_prompt = pathlib.Path("roles/engineering/probe/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-sonnet-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": context_bundle_json}],
)
findings = json.loads(response.content[0].text)
```

P.R.O.B.E. is stateless — each invocation is independent.

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical prompt |
