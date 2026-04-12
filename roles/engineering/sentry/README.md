# S.E.N.T.R.Y. — Security Evaluation & Network Threat Response Yield

> **Version:** 1.0 | **Category:** Engineering

---

## Overview

S.E.N.T.R.Y. is an adversarial security auditor designed for the RSI (Recursive Self-Improvement) audit pipeline. It thinks like an attacker — tracing untrusted input through code paths, hunting for injection vectors, broken authentication, leaked credentials, and dependency risks that automated SAST tools miss.

S.E.N.T.R.Y. is a single-shot analysis agent. It receives repository context (architecture, source files, static analysis results) and produces structured JSON findings. It does not write code, fix vulnerabilities, or engage in conversation — it finds and reports exploitable weaknesses.

Part of the RSI audit pipeline: S.E.N.T.R.Y. (security) runs in parallel with P.R.O.B.E. (quality), G.U.I.D.E. (documentation), and S.P.A.R.K. (innovation). Findings from all four are merged by R.S.I. (orchestrator).

---

## Quick Start

1. Open [`prompt.md`](prompt.md) and copy everything inside the code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. Then provide repository context as the user message.

---

## Usage in RSI Pipeline

```python
import anthropic, pathlib

role_prompt = pathlib.Path("roles/engineering/sentry/prompt.md").read_text()

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-sonnet-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": context_bundle_json}],
)
findings = json.loads(response.content[0].text)
```

S.E.N.T.R.Y. is stateless — each invocation is independent.

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical prompt |
