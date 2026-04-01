# Content Quality Audit Prompt

> **Usage:** Copy this file's content and paste it into an AI coding agent
> (Claude Code, Cursor, Copilot) at the repo root. The agent will run the
> full content audit loop and produce all required outputs.
>
> **Part of the audit triad:**
> - `src/non-functional-audit.md` — Standards audit (non-functional: structure, security, compliance)
> - `src/audit-functional.md` — Functional audit (does it work as designed)
> - `src/audit-content.md` — **Content audit** (is the content good)

---

## Instructions

You are running a Content Quality audit on a prompt engineering library.
The repo contains structured LLM system prompts ("roles") — each is a
complete system prompt designed to be pasted into a chat or injected via API.

This audit evaluates whether the **content** within each prompt is accurate,
effective, and well-crafted — not whether the structure follows standards
(that's `non-functional-audit.md`) or whether the workflow mechanics function correctly
(that's `audit-functional.md`). The focus is: is the content right?

Execute the following steps in order. Do not skip any step.

---

### Step 0: DISCOVER — update the source registry

Read `audits/sources-content.yaml`. This is the living registry of
authoritative sources used to evaluate content quality.

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
SAMHSA trauma-informed care update {current year}
Gottman method research evidence {current year}
EFT emotionally focused therapy effectiveness {current year}
motivational interviewing AI chatbot {current year}
EU AI Act enforcement classification {current year}
international crisis hotline directory verification {current year}
AI persona design voice consistency {current year}
cultural sensitivity AI inclusive design {current year}
interactive fiction game design best practices {current year}
Socratic method AI tutoring effectiveness {current year}
```

A candidate qualifies as a new source if it meets ALL of:
- **Authoritative** — published by a clinical authority, health org,
  regulatory body, educational institution, or recognised domain expert.
- **Specific** — contains concrete, verifiable guidance for the domain
  content used in role prompts.
- **Recent** — published or substantively updated within the last 12 months.
- **Novel** — covers a topic or angle not already represented in the registry.

Add qualifying sources to `audits/sources-content.yaml`.

#### 0c. Check for new audit topics

If a new or existing source introduces guidance on a topic not in the audit
checklist below, add the topic. The checklist is not fixed — it grows with
the field.

#### 0d. Update README references

After updating `audits/sources-content.yaml`, regenerate the Content Audit
References table in `README.md` to match the current registry.

---

### Step 0b: READ — load the repo state

Read:
- `index.yaml` (role catalog — lists all roles and their metadata)
- All `roles/**/prompt.md` files (canonical prompts)
- All `roles/**/README.md` files (usage docs and safety notes)
- `audits/log-content.md` (previous content audit results, if exists)

---

### Step 1: RESEARCH — gather domain context

For each role, identify the domain it operates in and research current
best practices. This step ensures the audit is grounded in domain
expertise, not just prompt engineering knowledge.

Research areas by category:
- **Health roles:** Current clinical guidelines, therapeutic frameworks
  referenced (e.g., SAMHSA, EFT, Gottman, MI, CBT), crisis resource
  accuracy, safety best practices for AI in mental health.
- **Education roles:** Pedagogical frameworks referenced (e.g., Socratic
  method, Bloom's taxonomy), age-appropriateness, curriculum accuracy.
- **Entertainment roles:** Game design coherence, narrative quality,
  replayability, player experience.
- **Engineering roles:** Industry standards referenced (e.g., OWASP, CWE),
  methodology accuracy, tool/framework currency.
- **Productivity roles:** Regulatory accuracy (e.g., EU AI Act), framework
  currency, professional standards.
- **Utility roles:** Output accuracy, domain correctness.

---

### Step 2: AUDIT — evaluate every role against the content checklist

For **each role**, evaluate every applicable topic in the checklist below.
Not every topic applies to every role — mark inapplicable checks as N/A.

Classify each topic per role as: **pass**, **improve** (content works but
could be meaningfully better), **fail** (content is incorrect, misleading,
or significantly lacking), or **N/A**.

#### Content Checklist

| # | Topic | What to evaluate | Applies to |
|---|-------|------------------|------------|
| C-01 | **Persona coherence** | The persona is well-defined and internally consistent. Voice, tone, humor style, and verbosity match the stated persona description throughout the prompt. There are no contradictions between the persona definition and the behavioural rules. | All roles |
| C-02 | **Domain accuracy** | Techniques, frameworks, methodologies, and factual claims referenced in the prompt are correct and current. Therapeutic models are accurately described. Legal references are correct. Game mechanics are internally consistent. No outdated or discredited approaches are presented as current best practice. | All roles |
| C-03 | **Example realism** | Examples reflect interactions a real user would actually have. User messages sound natural, not stilted or contrived. The role's responses in examples demonstrate the full range of its capabilities, not just the easiest case. | All roles |
| C-04 | **Tone calibration** | The tone is appropriate for the target user and context. Health roles handling sensitive topics use the right level of warmth without being patronising. Educational roles match the cognitive level of their audience. Entertainment roles maintain immersion. Professional roles are appropriately formal. | All roles |
| C-05 | **Crisis resource currency** | Crisis hotline numbers, URLs, and organisation names are correct and current. Resources cover the languages the role supports. Numbers are formatted correctly for international dialling. | Health roles, roles with crisis_risk |
| C-06 | **Technique evidence base** | Therapeutic, pedagogical, or professional techniques referenced are grounded in published research or established practice. The prompt does not invent or misrepresent frameworks. Citations or framework names are specific enough to verify. | Health, education, productivity roles |
| C-07 | **Cultural sensitivity** | Content handles multilingual and multicultural contexts appropriately. No assumptions about family structure, cultural norms, or social conventions that would alienate users from different backgrounds. Roles with fixed cultural context (e.g., Dutch education system) make that context explicit rather than implicit. | All roles |
| C-08 | **Instructional clarity** | Every instruction in the prompt would be unambiguously understood by an LLM. No vague directives like "be helpful" without specifics. No contradictory instructions. Conditional logic is clear (if X then Y). The LLM can determine what to do in any situation the prompt claims to handle. | All roles |
| C-09 | **Target user fit** | The prompt is designed for the specific user it claims to serve, not a generic audience. Vocabulary, assumed knowledge, interaction patterns, and output formats match what that user would expect and need. | All roles |
| C-10 | **Competitive value** | The role provides meaningful value beyond what a bare LLM would provide with a simple instruction. The persona, structure, and constraints produce noticeably different (better) behaviour than asking the base model to "act as X." | All roles |
| C-11 | **Staleness risk** | The prompt does not depend on facts, statistics, regulations, or resource URLs that will expire or change frequently. Time-sensitive content is either avoided, clearly dated, or structured so updates are isolated to one section. | All roles |
| C-12 | **Improvement opportunities** | Beyond pass/fail evaluation: what specific content changes would make this role meaningfully better? New scenarios to handle, better phrasing, additional techniques to incorporate, missing edge cases in the domain. | All roles |

---

### Step 3: REPORT — produce the content scorecard

Create or update the file `audits/log-content.md` with:

```markdown
## {today's date}

### Summary

- **Roles audited:** {count}
- **Overall pass rate:** {X}% ({pass count} / {total applicable checks})
- **Fails:** {count} across {N} roles
- **Improves:** {count} across {N} roles

### Per-role results

| Role | C-01 | C-02 | C-03 | C-04 | C-05 | C-06 | C-07 | C-08 | C-09 | C-10 | C-11 | C-12 | Score |
|------|------|------|------|------|------|------|------|------|------|------|------|------|-------|
| ... per role row, using pass/improve/fail/N/A ... |

### Findings

| ID | Role(s) | Topic | Severity | Detail | Suggestion |
|----|---------|-------|----------|--------|------------|
| ... one row per finding ... |

### Improvement backlog

| Role | Suggestion | Impact | Effort |
|------|-----------|--------|--------|
| ... one row per C-12 suggestion, ranked by impact ... |

### Previous audit
- **Date:** {date of previous entry, or "none"}
- **Delta:** {what changed — findings resolved, new issues, score movement}
```

---

### Step 3b: REPORT — update README

Update the Content Audit section in `README.md`:

1. Update the **date** and pass rate in the blockquote header.
2. Update the **Topic-by-topic assessment** table with the pass/improve/fail
   summary for each content topic, including citation numbers matching
   the References table.
3. Update the **Open findings** table — remove findings that have been
   resolved, add new ones with spec links.
4. Update the **References** table to match `audits/sources-content.yaml`.

---

### Step 4: SPEC — generate improvement specs for failures

For each **fail** finding:

1. Create a spec file in `specs/` following the naming convention
   (`NN-short-description.md`).
2. Each spec must include: Priority, Scope, Effort, Problem, Change,
   and Verification sections.
3. Group related failures into a single spec where it makes sense
   (e.g., "stale crisis resources" across 3 roles = one spec).

For **improve** findings: do not create specs, but include them in
the Improvement backlog table in the report. These are tracked for
future enhancement, not blocking issues.

If there are no fails, skip this step.

---

### Step 5: Summary

Print a concise summary of:
- Source registry changes (added/retired/updated sources)
- Overall content quality (pass rate, critical gaps)
- Roles with the strongest content
- Roles with the most improvement opportunities
- Specs created (if any)
- Top 5 highest-impact suggestions from the improvement backlog
- Comparison to previous content audit (if exists)
- Recommended next actions

---

## Guidance for evaluators

### What counts as a fail vs. an improve?

- **Fail:** The content is factually wrong, dangerously misleading, or so
  significantly lacking that it undermines the role's purpose. A user relying
  on this content would be misinformed or poorly served. Examples: outdated
  crisis hotline number, misrepresented therapeutic framework, instructions
  that contradict each other, persona that shifts mid-prompt.

- **Improve:** The content works but could be meaningfully better. The role
  functions and serves its purpose, but specific changes would noticeably
  improve quality. Examples: examples that don't showcase the role's full
  range, tone slightly too formal for the target user, technique reference
  that could be more specific, missing edge case that real users would hit.

### Distinction from other audits

This audit is **complementary** to the other two audits in the triad:

| Concern | Standards audit | Functional audit | Content audit |
|---------|----------------|------------------|---------------|
| Question | Is it built right? | Does it work? | Is the content right? |
| Focus | Structure, security, compliance | Workflow mechanics, state, templates | Accuracy, quality, effectiveness |
| Example | "Does it have `<INSTRUCTION_HIERARCHY>`?" | "Can every phase be reached?" | "Is the therapeutic model correctly described?" |
| Finds | Missing XML tags, injection gaps | Dead-end phases, orphaned fields | Wrong facts, weak examples, tone mismatch |

If you're unsure whether a finding belongs in this audit or another:
- If it's about **structure or security patterns** → standards audit
- If it's about **mechanical correctness** (reachable phases, valid templates) → functional audit
- If it's about **what the prompt says and whether it says it well** → content audit

### Research depth

The RESEARCH step is critical. Do not evaluate domain accuracy based on
general knowledge alone. For health roles, verify therapeutic frameworks
against published sources. For legal/regulatory roles, check current
legislation. For educational roles, verify pedagogical claims. Web search
is expected and encouraged during this step.

### Notes

- This audit is **read-only for role prompts** — it does not modify prompt
  content. It only writes to `audits/log-content.md` and `specs/`.
- C-12 (Improvement opportunities) is not scored pass/fail — it captures
  suggestions for the improvement backlog regardless of other scores.
- Be constructive in suggestions. Every improvement should be specific
  enough that someone could implement it without further research.
- If the previous content audit log exists, compare findings to track
  improvement or regression.
