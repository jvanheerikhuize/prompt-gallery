# R.S.I. — Recursive Self-Improvement Orchestrator

> **Version:** 1.0 | **Category:** Productivity

---

## Overview

R.S.I. is the meta-governance layer of the RSI audit pipeline. It does not audit code directly. Instead, it receives findings from the four specialist auditors — S.E.N.T.R.Y. (security), P.R.O.B.E. (quality), G.U.I.D.E. (documentation), and S.P.A.R.K. (innovation) — and produces a single, coherent, deduplicated, and prioritised audit output.

R.S.I. is the final quality gate. It merges duplicate findings, resolves conflicts between auditors, adjusts severity levels, drops weak findings, and produces the authoritative context update for the repository's `.agents/CONTEXT.md`.

R.S.I. is a single-shot synthesis agent. It receives the combined output of all four dimension passes and produces the final audit report. It does not audit code, write fixes, or engage in conversation — it synthesises, adjudicates, and prioritises.

---

## Quick Start

1. Open [`prompt.md`](prompt.md) and copy everything inside the code block.
2. Start a **fresh conversation** in any advanced LLM (Claude, ChatGPT, Gemini, etc.).
3. Paste and send. Then provide the merged findings from all four auditors as the user message.

---

## Usage in RSI Pipeline

```python
import anthropic, pathlib, json

role_prompt = pathlib.Path("roles/productivity/rsi/prompt.md").read_text()

merged_input = json.dumps({
    "persistent_context": context_md,
    "sentry_findings": sentry_result,
    "probe_findings": probe_result,
    "guide_findings": guide_result,
    "spark_findings": spark_result,
    "static_analysis": static_findings,
    "repo_metadata": repo_meta,
})

client = anthropic.Anthropic()
response = client.messages.create(
    model="claude-sonnet-4-6",
    system=role_prompt,
    messages=[{"role": "user", "content": merged_input}],
)
final_report = json.loads(response.content[0].text)
```

R.S.I. is stateless — each invocation is independent.

---

## Pipeline Architecture

```
S.E.N.T.R.Y. (security)  ──┐
P.R.O.B.E.  (quality)    ──┤
G.U.I.D.E.  (documentation)┤──→ R.S.I. (orchestrator) ──→ Final Report
S.P.A.R.K.  (innovation) ──┘
```

---

## Files

| File | Description |
|------|-------------|
| [`prompt.md`](prompt.md) | Canonical prompt |
