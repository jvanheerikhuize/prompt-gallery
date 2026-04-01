# RSI Audit Prompt

> **Usage:** Copy this file's content and paste it into an AI coding agent
> (Claude Code, Cursor, Copilot) at the repo root. The agent will run the
> full audit loop and produce all required outputs.
>
> **Part of the audit quartet:**
> - `src/non-functional-audit.md` — **Standards audit** (non-functional: structure, security, compliance)
> - `src/audit-functional.md` — Functional audit (does it work as designed)
> - `src/audit-content.md` — Content audit (is the content good)
> - `src/audit-docs.md` — Documentation audit (is the documentation complete, consistent, and correct)

---

## Instructions

You are running a Recursive Self-Improvement (RSI) audit on a prompt
engineering library. The repo contains structured LLM system prompts
("roles") evaluated against industry best practices.

Execute the following steps in order. Do not skip any step.

---

### Step 0: DISCOVER — update the source registry

Read `audits/sources.yaml`. This is the living registry of authoritative
sources used to evaluate the repo.

#### 0a. Verify existing sources

For each source in the registry:

1. Fetch the URL and confirm it returns HTTP 200.
2. Check if the content has been updated since `last_verified` (look for
   version numbers, dates, changelogs).
3. Confirm the source still covers the topics it's tagged with.

If a URL is dead or redirected:
- Update the URL if the content moved to a new location.
- Set `tier: archived` if the content is gone. Add `retired` (today's date)
  and `reason` fields.

Update `last_verified` to today for every source that passes verification.

#### 0b. Search for new authorities

Run these web searches and evaluate results for new sources:

```
"prompt engineering" best practices {current year}
"system prompt" guidelines {current year}
LLM prompt injection defense {current year}
"context engineering" {current year}
AI agent safety guidelines {current year}
```

A candidate qualifies as a new source if it meets ALL of:
- **Authoritative** — published by a major AI lab (Anthropic, OpenAI,
  Google, Meta, Mistral), a security organisation (OWASP, NIST, ENISA),
  or a recognised practitioner with a track record.
- **Specific** — contains concrete, actionable guidance for system prompt
  design (not high-level philosophy or marketing).
- **Recent** — published or substantively updated within the last 12 months.
- **Novel** — covers a topic or angle not already represented in the registry.

Add qualifying sources to `audits/sources.yaml` with a unique `id`, relevant
`topics` tags, appropriate `tier`, and `added` set to today.

#### 0c. Check for new audit topics

If a new or existing source introduces guidance on a topic not in the audit
checklist below, add the topic. The checklist is not fixed — it grows with
the field.

#### 0d. Update README references

After updating `audits/sources.yaml`, regenerate the References table at the
bottom of the Industry Standards Audit section in `README.md` to match the
current registry. Number references sequentially. Remove retired sources
from the table.

---

### Step 1: AUDIT — evaluate all prompts

Read:
- `src/templates/prompt.md` (base template)
- All `roles/**/prompt.md` files (canonical prompts)
- A sample of `roles/**/prompt-semanticode.md` files (at least 3)

Evaluate every prompt against the audit checklist below. For each topic,
classify the repo as **ahead**, **spot-on**, or **behind** relative to the
guidance in the source registry.

#### Audit checklist

| # | Topic | What to evaluate |
|---|-------|------------------|
| 1 | XML/structured tagging | Tag consistency, schema enforcement, section naming |
| 2 | Section ordering | Instructions near user input boundary |
| 3 | Instruction hierarchy | Explicit priority declaration in every prompt |
| 4 | Injection defense | Input-as-data, authority claim handling, scope limits |
| 5 | Few-shot examples | Quantity (1-5), quality (happy path + edge case), format |
| 6 | Token efficiency | Canonical size, SemantiCode reduction ratio, redundancy |
| 7 | Context engineering | State schemas, output templates, compaction strategy |
| 8 | Output templates | Named formats, consistency across roles |
| 9 | Safety / crisis protocols | Non-skippable checks, tiered response, localised resources |
| 10 | Scope enforcement | Explicit in/out-of-scope, redirect behaviour |
| 11 | Language handling | Detection consistency, resource localisation |
| 12 | Error handling | Standard taxonomy, coverage across roles |
| 13 | Architectural defense | N/A for static prompts — flag if repo gains agentic features |

Cross-reference each topic with the sources tagged for it in
`audits/sources.yaml`. Use the latest published guidance, not cached
assumptions.

---

### Step 2: REPORT — produce the scorecard

Update the Industry Standards Audit section in `README.md`:

1. Update the **date** to today.
2. Update the **Scorecard** table with scores per standard (Anthropic,
   OpenAI, Google, OWASP) and an overall score.
3. Update the **Topic-by-topic assessment** table with the behind/spot-on/
   ahead classification for each topic, including citation numbers matching
   the References table.
4. Update the **Open findings** table — remove findings that have been
   resolved, add new ones.

---

### Step 3: SPEC — generate improvement specs

For each topic classified as **behind**, or any topic that has degraded
since the last audit:

1. Create a spec file in `specs/` following the existing naming convention
   (`NN-short-description.md`).
2. Each spec must include: Priority, Scope, Effort, Problem, Change,
   and Verification sections.

If no topics are behind, skip this step.

---

### Step 4: REPORT — update the audit log

Append a new entry to `audits/log.md` with:

```markdown
## {today's date}

- **Overall:** {score}/10
- **Ahead:** {list of ahead topics}
- **Spot-on:** {list of spot-on topics}
- **Behind:** {list of behind topics, or "none"}
- **Sources:** {count} ({primary} primary, {secondary} secondary) — {added} added, {retired} retired, {broken} broken URLs
- **Topics:** {count} — {new} new topics discovered
- **Specs created:** {list, or "none"}
- **Previous audit:** {date of previous entry}
- **Delta:** {what changed since last audit — score movement, topics that improved or degraded, sources added/retired}
```

---

### Step 5: Summary

Print a concise summary of:
- Source registry changes (added/retired/updated sources)
- Score changes from the previous audit
- Topics that improved, degraded, or are new
- Specs created
- Recommended next actions

---

## Notes

- Do not change prompt content during an audit. The audit is read-only
  for role prompts — it only writes to `README.md`, `audits/`, and `specs/`.
- If the README audit section structure has changed, adapt rather than
  overwrite — preserve any additional sections the maintainer has added.
- Be honest in scoring. "Spot-on" means the repo matches current guidance.
  "Ahead" means it exceeds it. Do not inflate scores.
