# SPEC-06: Recursive Self-Improvement Audit

> **Priority:** High
> **Scope:** Repo-wide process + tooling
> **Effort:** Medium (one-time setup, then recurring)

---

## Philosophy

Recursive Self-Improvement (RSI) applied to prompt engineering: the repo
should periodically evaluate itself against the evolving state of the art,
identify gaps, generate improvement specs, implement them, and then
re-evaluate — creating a closed feedback loop that compounds quality over
time.

The audit is not a one-off event. It is a recurring process that treats the
repo as a living system.

## Process

### The RSI loop

```
┌─────────────────────────────────────────────────┐
│                                                 │
│   0. DISCOVER                                   │
│      Search for new authoritative sources        │
│      Verify existing source URLs still resolve   │
│      Update source registry if changed           │
│              │                                   │
│              ▼                                   │
│   1. AUDIT                                      │
│      Evaluate all prompts against current        │
│      industry standards from the registry        │
│              │                                   │
│              ▼                                   │
│   2. REPORT                                     │
│      Score per standard, topic-by-topic           │
│      behind / spot-on / ahead assessment          │
│              │                                   │
│              ▼                                   │
│   3. SPEC                                        │
│      Generate improvement specs for               │
│      any "behind" or degraded topics              │
│              │                                   │
│              ▼                                   │
│   4. IMPLEMENT                                   │
│      Apply specs one by one                       │
│              │                                   │
│              ▼                                   │
│   5. VERIFY                                      │
│      Re-run audit to confirm improvements         │
│      Update README scorecard and references       │
│              │                                   │
│              └──────────── back to 0 ────────────┘
│                                                 │
└─────────────────────────────────────────────────┘
```

### Cadence

Run the full RSI loop **quarterly** (every 3 months). The prompt engineering
landscape moves fast — Anthropic, OpenAI, and Google each publish meaningful
updates roughly every 2-4 months. Quarterly keeps the repo current without
creating churn.

Suggested schedule:
- **Q1** (January) — post-holiday catch-up on any December releases
- **Q2** (April) — mid-year alignment
- **Q3** (July) — pre-autumn refresh
- **Q4** (October) — year-end hardening before any freeze periods

### Trigger conditions for out-of-cycle audits

Run an unscheduled audit if any of the following occur:
- A major model release (e.g., Claude 5, GPT-6, Gemini 4)
- A new OWASP LLM Top 10 version is published
- A significant prompt injection technique is publicly disclosed
- More than 5 new roles have been added since the last audit

## Audit checklist

The audit evaluates every prompt against these topics. Each topic is scored
as **ahead**, **spot-on**, or **behind** relative to current published guidance.

| # | Topic | Sources to check | What to evaluate |
|---|-------|-----------------|------------------|
| 1 | XML/structured tagging | Anthropic docs, OpenAI guide | Tag consistency, schema enforcement, section naming |
| 2 | Section ordering | Anthropic docs | Instructions near user input boundary |
| 3 | Instruction hierarchy | OWASP, Anthropic | Explicit priority declaration in every prompt |
| 4 | Injection defense | OWASP Top 10, OWASP cheat sheet, Willison | Input-as-data, authority claim handling, scope limits |
| 5 | Few-shot examples | Anthropic, OpenAI, Google | Quantity (1-5), quality (happy path + edge case), format |
| 6 | Token efficiency | Anthropic (right altitude, context engineering) | Canonical size, SemantiCode reduction ratio, redundancy |
| 7 | Context engineering | Anthropic blog | State schemas, output templates, compaction strategy |
| 8 | Output templates | OpenAI (structured outputs), Google | Named formats, consistency across roles |
| 9 | Safety / crisis protocols | Google safety, OWASP | Non-skippable checks, tiered response, localised resources |
| 10 | Scope enforcement | OWASP, Google | Explicit in/out-of-scope, redirect behaviour |
| 11 | Language handling | Google, Anthropic | Detection consistency, resource localisation |
| 12 | Error handling | OpenAI, Anthropic | Standard taxonomy, coverage across roles |
| 13 | Architectural defense | Willison (lethal trifecta, CaMeL), Google (Model Armor) | N/A for static prompts — flag if repo gains agentic features |

## Source registry

The source registry is a living document — not a fixed list. New authorities
emerge, existing ones move or go stale, and entirely new categories of
guidance appear (e.g., context engineering didn't exist as a named concept
before 2025). The registry must evolve with the field.

### Registry file: `audits/sources.yaml`

The authoritative source of truth for all reference sources. Maintained as
a structured YAML file so the audit prompt can programmatically iterate
over it.

```yaml
# audits/sources.yaml — Source Registry for RSI Audit Loop
# This file is updated during Step 0 (DISCOVER) of every audit cycle.

sources:
  # ──── Tier 1: Primary — check every audit ────
  - id: anthropic-prompt-eng
    name: "Anthropic — Prompt Engineering Docs"
    url: "https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview"
    tier: primary
    topics: [xml-tags, section-ordering, few-shot-examples, token-efficiency]
    added: 2026-04-01
    last_verified: 2026-04-01

  - id: anthropic-context-eng
    name: "Anthropic — Effective Context Engineering for AI Agents"
    url: "https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents"
    tier: primary
    topics: [context-engineering, token-efficiency, right-altitude]
    added: 2026-04-01
    last_verified: 2026-04-01

  - id: openai-prompt-eng
    name: "OpenAI — Prompt Engineering Guide"
    url: "https://platform.openai.com/docs/guides/prompt-engineering"
    tier: primary
    topics: [few-shot-examples, output-templates, error-handling]
    added: 2026-04-01
    last_verified: 2026-04-01

  - id: google-prompt-design
    name: "Google — Prompt Design Strategies (Gemini)"
    url: "https://ai.google.dev/gemini-api/docs/prompting-strategies"
    tier: primary
    topics: [few-shot-examples, output-templates, section-ordering]
    added: 2026-04-01
    last_verified: 2026-04-01

  - id: google-safety
    name: "Google — Safety and Factuality Guidance"
    url: "https://ai.google.dev/gemini-api/docs/safety-guidance"
    tier: primary
    topics: [injection-defense, safety-protocols, scope-enforcement]
    added: 2026-04-01
    last_verified: 2026-04-01

  - id: owasp-llm-top10
    name: "OWASP — LLM Top 10 (2025)"
    url: "https://genai.owasp.org/llmrisk/llm01-prompt-injection/"
    tier: primary
    topics: [injection-defense, instruction-hierarchy, scope-enforcement]
    added: 2026-04-01
    last_verified: 2026-04-01

  - id: owasp-cheatsheet
    name: "OWASP — Prompt Injection Prevention Cheat Sheet"
    url: "https://cheatsheetseries.owasp.org/cheatsheets/LLM_Prompt_Injection_Prevention_Cheat_Sheet.html"
    tier: primary
    topics: [injection-defense, instruction-hierarchy]
    added: 2026-04-01
    last_verified: 2026-04-01

  # ──── Tier 2: Secondary — check for new publications ────
  - id: willison-blog
    name: "Simon Willison's blog"
    url: "https://simonwillison.net/"
    tier: secondary
    topics: [injection-defense, architectural-defense]
    added: 2026-04-01
    last_verified: 2026-04-01

  - id: anthropic-eng-blog
    name: "Anthropic engineering blog"
    url: "https://www.anthropic.com/engineering"
    tier: secondary
    topics: [context-engineering, token-efficiency]
    added: 2026-04-01
    last_verified: 2026-04-01

  - id: openai-cookbook
    name: "OpenAI cookbook"
    url: "https://cookbook.openai.com/"
    tier: secondary
    topics: [few-shot-examples, output-templates]
    added: 2026-04-01
    last_verified: 2026-04-01

  - id: google-cloud-ai-blog
    name: "Google Cloud AI blog"
    url: "https://cloud.google.com/blog/products/ai-machine-learning"
    tier: secondary
    topics: [safety-protocols, architectural-defense]
    added: 2026-04-01
    last_verified: 2026-04-01
```

### Step 0: DISCOVER — source discovery protocol

This step runs **before** every audit. Its purpose is to ensure the registry
reflects the current landscape, not a snapshot from when the repo was created.

#### 0a. Verify existing sources

For each source in `audits/sources.yaml`:

1. **Check URL resolves** — fetch the page, confirm it returns 200.
2. **Check content is current** — has the page been updated since
   `last_verified`? Look for version numbers, dates, or changelog entries.
3. **Check relevance** — does the source still cover the topics it's tagged
   with? Guidance evolves; a source that was authoritative for "few-shot
   examples" may now say something different.

If a URL is dead or redirected:
- Update the URL if the content moved.
- Demote to `tier: archived` if the content is gone.
- Add a `retired` date and `reason` field.

Update `last_verified` for every source that passes.

#### 0b. Search for new authorities

Actively search for new sources that may have emerged since the last audit:

1. **Search queries** to run (web search):
   - `"prompt engineering" best practices {current year}`
   - `"system prompt" guidelines {current year}`
   - `LLM prompt injection defense {current year}`
   - `"context engineering" {current year}`
   - `AI agent safety guidelines {current year}`

2. **Evaluate candidates** against these criteria:
   - **Authoritativeness** — published by a major AI lab, security org,
     or recognised practitioner (not a random Medium post).
   - **Specificity** — contains concrete, actionable guidance for system
     prompt design (not just high-level philosophy).
   - **Recency** — published or updated within the last 12 months.
   - **Novelty** — covers a topic or perspective not already in the registry.

3. **Add qualifying sources** to `audits/sources.yaml` with:
   - A unique `id`
   - The `topics` it covers (from the audit checklist)
   - `tier: primary` if it's a canonical reference, `tier: secondary` if
     it's a blog or supplementary resource
   - `added` date set to today

#### 0c. Check for new audit topics

If a new source introduces guidance on a topic not in the audit checklist
(e.g., "multi-modal prompt design", "agent memory patterns"):

1. Add the topic to the audit checklist table.
2. Evaluate all prompts against it.
3. Tag the source with the new topic in the registry.

This is how the audit checklist itself evolves — it's not a fixed list.

#### 0d. Update README references

After updating `audits/sources.yaml`, regenerate the references table in
the README to reflect any added, updated, or retired sources.

## Audit output

Each audit produces:

1. **Updated source registry** — `audits/sources.yaml` with verified URLs,
   new sources added, stale sources retired.
2. **Updated README scorecard** — overall scores per standard, topic-by-topic
   assessment with behind/spot-on/ahead status, and regenerated references.
3. **New specs** — one spec per "behind" topic, filed in `specs/`.
4. **Audit log entry** — append to `audits/log.md` (create on first run):

```markdown
## 2026-04-01

- **Overall:** 8.2/10
- **Ahead:** XML structure, instruction hierarchy, token efficiency, crisis protocols
- **Spot-on:** Section ordering, input-as-data, few-shot examples, context engineering, output templates
- **Behind:** Scope enforcement, language handling, error handling
- **Sources:** 11 (7 primary, 4 secondary) — 0 added, 0 retired, 0 broken URLs
- **Topics:** 13 — 0 new topics discovered
- **Specs created:** SPEC-01 through SPEC-05
- **Previous audit:** (none — first audit)
- **Delta:** N/A
```

The log provides a longitudinal view of how the repo improves over time —
the core value of RSI.

## Implementation

### Step 1: Create the audit log

Create `audits/log.md` with the current audit as the first entry.

### Step 2: Create the audit prompt

Create `src/audit.md` — a system prompt that an AI coding agent can use to
run the audit. The prompt should instruct the agent to:

1. **DISCOVER** — read `audits/sources.yaml`, verify all URLs resolve, search
   for new authoritative sources, add/retire/update entries, check for new
   audit topics not yet in the checklist
2. Read all role prompts and the base template
3. Fetch the latest guidance from all primary sources in the registry
4. Evaluate each topic from the checklist (including any new topics from step 1)
5. Score and classify each topic (behind / spot-on / ahead)
6. Generate specs for any "behind" findings
7. Update `audits/sources.yaml`, the README scorecard + references, and the
   audit log
8. Report what changed since the last audit — including source registry changes

### Step 3: Add to CONTRIBUTING.md

Document the audit cadence and process so contributors know the repo is
actively maintained against evolving standards.

## Verification

- `audits/sources.yaml` exists and all URLs resolve (no broken links)
- `audits/log.md` exists and contains at least one entry
- `src/audit.md` exists and is executable by an AI coding agent
- README scorecard has a date and references matching the source registry
- Each "behind" topic has a corresponding spec in `specs/`
- Audit log entry includes source registry changes (added/retired/broken)
