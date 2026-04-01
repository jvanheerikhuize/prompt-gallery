# Documentation Integrity Audit Prompt

> **Usage:** Copy this file's content and paste it into an AI coding agent
> (Claude Code, Cursor, Copilot) at the repo root. The agent will run the
> full documentation audit loop and produce all required outputs.
>
> **Part of the audit quartet:**
> - `src/non-functional-audit.md` — Standards audit (non-functional: structure, security, compliance)
> - `src/audit-functional.md` — Functional audit (does it work as designed)
> - `src/audit-content.md` — Content audit (is the content good)
> - `src/audit-docs.md` — **Documentation audit** (is the documentation complete, consistent, and correct)

---

## Instructions

You are running a Documentation Integrity audit on a prompt engineering
library. The repo contains structured LLM system prompts ("roles") with
per-role documentation, a central index, a main README, and supporting
infrastructure files (templates, audits, specs, contributing guide).

This audit evaluates whether the **documentation and cross-references**
are complete, consistent, and correct — not whether the prompts follow
industry standards (that's `non-functional-audit.md`), whether they
function correctly (that's `audit-functional.md`), or whether the content
is accurate (that's `audit-content.md`). The focus is: can a user or
contributor find what they need, and does every reference resolve?

**Grounded in:**
- Diátaxis documentation framework (tutorials, how-to, reference, explanation)
- ISO/IEC/IEEE 26514:2022 (documentation completeness, accuracy, consistency)
- Tom Johnson's Documentation Quality Rubric (findability, accuracy,
  relevance, clarity, completeness, readability)
- EU AI Act Annex IV (technical documentation requirements for AI systems)
- Model Cards (Mitchell et al., 2019) adapted for prompt engineering

Execute the following steps in order. Do not skip any step.

---

### Step 0: DISCOVER — build the documentation inventory

Read the following files to build a complete map of every documentation
artefact and every cross-reference in the repo:

1. `index.yaml` — the role catalog (all `files` paths, descriptions, tags)
2. `README.md` — the main README (role tables, repo structure, audit sections)
3. `CONTRIBUTING.md` — contributor guide
4. `src/ingest.md` — ingestion prompt (category options, persona options, step references)
5. `src/non-functional-audit.md`, `src/audit-functional.md`, `src/audit-content.md`, `src/audit-docs.md` — audit prompts
6. `src/templates/prompt.md`, `src/templates/prompt-semanticode.md`, `src/templates/README.md` — templates
7. `src/templates/ingestion-checklist.md` — quality checklist
8. All `roles/**/README.md` files — per-role documentation
9. All `roles/**/prompt.md` and `roles/**/prompt-semanticode.md` — to verify file existence claims
10. All `specs/*.md` — improvement specs
11. All `audits/*.yaml` and `audits/*.md` — source registries and audit logs

Produce a documentation inventory listing every file path in the repo
that is referenced by any other file.

---

### Step 1: AUDIT — cross-reference integrity

For every cross-reference found in Step 0, run the following checks.

#### 1a. File path references

| # | Check | Description |
|---|-------|-------------|
| D-01 | **index.yaml → disk** | Every `files.prompt`, `files.semanticode`, and `files.variant` path in `index.yaml` resolves to an actual file on disk. |
| D-02 | **disk → index.yaml** | Every `roles/<category>/<slug>/` directory on disk has a corresponding entry in `index.yaml`. No orphaned role directories. |
| D-03 | **README role table → disk** | Every `[link](path)` in the role tables in `README.md` resolves to an actual file. |
| D-04 | **README repo structure → disk** | The directory tree in the "Repository structure" section matches the actual repo layout. |
| D-05 | **Per-role README files table → disk** | Every file listed in a role's README `Files` table exists on disk. |
| D-06 | **Spec scope paths → disk** | Every `Scope:` file path in `specs/*.md` resolves to an actual file (or a planned directory for new-role specs). |
| D-07 | **Audit triad references → disk** | All file paths referenced in audit prompts, source registries, and audit logs exist. |

#### 1b. Content consistency

| # | Check | Description |
|---|-------|-------------|
| D-08 | **index.yaml description ↔ README overview** | The `description` field in `index.yaml` matches the first paragraph of the corresponding role's README Overview section (same meaning, not necessarily verbatim). |
| D-09 | **index.yaml category ↔ directory** | The `category` field in each `index.yaml` entry matches the parent directory under `roles/`. |
| D-10 | **index.yaml id ↔ slug consistency** | The `id` field is unique across all entries. The `slug` matches the directory name. |
| D-11 | **README role count badge** | The `roles-XX` badge count in `README.md` matches the actual number of entries in `index.yaml`. |
| D-12 | **README role table completeness** | Every role in `index.yaml` has a corresponding row in the README role table under the correct category heading. |
| D-13 | **README category sections** | Every `category` value in `index.yaml` has a corresponding category section (heading) in the README role table. |
| D-14 | **Ingest category options** | The category options listed in `src/ingest.md` Step 0 field #2 match the distinct `category` values in `index.yaml` (plus any planned categories from specs). |
| D-15 | **Audit triad listing consistency** | The "Part of the audit" header in all four audit files lists the same set of files with correct paths. |

#### 1c. Template conformance

| # | Check | Description |
|---|-------|-------------|
| D-16 | **Prompt structure** | Every `prompt.md` contains: `<MASTER_PROMPT>`, `<PERSONA>`, `<STATE>` (or stateless declaration), `<OUTPUT>`, `<EXAMPLES>`, `<RULES>`, `<WORKFLOW>`. |
| D-17 | **SemantiCode header** | Every `prompt-semanticode.md` contains: Source path, Mode (LOSSLESS), Grammar (SemantiCode v1.0), and section line references. |
| D-18 | **README sections** | Every role README contains: Overview, Quick Start, Usage Examples (≥3), API / Agent Framework, Files table. |
| D-19 | **README safety section** | Roles with `crisis_risk: true` or `gdpr_special_category: true` in `index.yaml` have a Safety Notes section in their README. |
| D-20 | **Provenance metadata** | Every `index.yaml` entry has `provenance.author`, `provenance.created`, and `provenance.last_updated` fields. |

#### 1d. Documentation quality (Diátaxis + Tom Johnson rubric)

| # | Check | Description |
|---|-------|-------------|
| D-21 | **Findability** | Can a user discover what they need? Role table is browsable, tags are searchable, README has clear navigation. Categories in README match `index.yaml`. |
| D-22 | **Accuracy** | Do descriptions match what the prompt actually does? Spot-check 3 roles: does the README overview accurately reflect the prompt's PERSONA and SCOPE_LIMITS? |
| D-23 | **Completeness** | Are there undocumented roles, features, or options? Check for: roles without READMEs, commands without documentation, persona options not reflected in ingest.md. |
| D-24 | **Clarity** | Is the documentation clear to the stated target user? Spot-check: are Quick Start steps actionable? Do usage examples demonstrate realistic scenarios? |
| D-25 | **Readability** | Prose quality: sentence length, passive voice, jargon. Flag sentences >40 words, unexplained acronyms on first use, and inconsistent terminology. |
| D-26 | **Staleness** | Are dates, versions, and counts current? Check: `provenance.last_updated` against actual git history, README badge counts, audit dates. |

#### 1e. AI-specific documentation (Model Card–lite)

| # | Check | Description |
|---|-------|-------------|
| D-27 | **Intended use** | Each role's README states who the role is for and in what context. |
| D-28 | **Limitations** | Each role's README or prompt states what the role will NOT do (maps to SCOPE_LIMITS). |
| D-29 | **Ethical considerations** | Roles handling sensitive data (health, minors, legal) document safety constraints, crisis protocols, and GDPR obligations. |
| D-30 | **Governance metadata** | Each `index.yaml` entry has `governance.risk_tier`, `governance.ai_tier`, and `governance.data_classification`. |
| D-31 | **Version tracking** | Each role has a version field in `index.yaml`. Version is updated when prompt content changes. |

---

### Step 2: REPORT — produce the scorecard

Update the Documentation Audit section in `README.md` (create it if it
doesn't exist yet, after the Content Audit section):

1. Update the **date** to today.
2. Report **pass rate**: checks passed / total checks run.
3. Produce a **topic-by-topic assessment** table with these categories:

| Category | Checks | What it covers |
|----------|--------|---------------|
| Cross-reference integrity | D-01 through D-07 | Do all file paths resolve? |
| Content consistency | D-08 through D-15 | Do descriptions, categories, and counts match? |
| Template conformance | D-16 through D-20 | Do files follow the structural templates? |
| Documentation quality | D-21 through D-26 | Is the documentation useful, clear, and current? |
| AI-specific documentation | D-27 through D-31 | Does each role have Model Card–lite metadata? |

4. Update the **Open findings** table — list all failing checks with
   severity (Critical / High / Medium / Low) and affected files.

#### Severity definitions

| Severity | Definition |
|----------|------------|
| **Critical** | Broken link or missing file that prevents a user from using a role |
| **High** | Inconsistency that misleads a user (wrong description, stale count, missing safety section) |
| **Medium** | Documentation gap that reduces quality but doesn't block usage |
| **Low** | Style issue, minor staleness, or cosmetic inconsistency |

---

### Step 3: FIX — resolve all findings

Unlike the other three audits, the documentation audit is **read-write**.
After completing the scorecard in Step 2, fix every finding directly:

1. **Critical and High findings** — fix immediately. Update the file(s)
   that contain the broken reference, stale count, or missing section.
2. **Medium findings** — fix if the fix is straightforward (< 5 minutes).
   Otherwise, create a spec in `specs/` following existing conventions.
3. **Low findings** — log but do not fix. Note them in the audit log for
   future cleanup.

After fixing, re-run the affected checks to confirm the finding is
resolved. Update the Open findings table to reflect the fix.

---

### Step 4: REPORT — update the audit log

Append a new entry to `audits/log-docs.md` (create if it doesn't exist):

```markdown
## {today's date}

- **Pass rate:** {passed}/{total} ({percentage}%)
- **Findings:** {critical} critical, {high} high, {medium} medium, {low} low
- **Fixed in this run:** {count} ({list of check IDs})
- **Deferred to specs:** {count} ({list of spec numbers, or "none"})
- **Previous audit:** {date, or "first run"}
- **Delta:** {what changed since last audit}

### Findings detail

| ID | Check | Severity | File(s) | Status |
|----|-------|----------|---------|--------|
| ... | ... | ... | ... | Fixed / Deferred / Logged |
```

---

### Step 5: Summary

Print a concise summary of:
- Total checks run and pass rate
- Critical/High findings found and fixed
- Medium findings deferred to specs
- Files modified during this audit
- Recommended next actions

---

## Notes

- This audit IS allowed to modify documentation files (README.md,
  role READMEs, index.yaml descriptions, CONTRIBUTING.md, audit triad
  headers). It is NOT allowed to modify prompt files (`prompt.md`,
  `prompt-semanticode.md`).
- Cross-reference checks are bidirectional — verify both directions
  (A → B exists AND B → A is listed).
- When fixing findings, make the minimum change necessary. Do not
  rewrite sections that are not broken.
- If the README does not yet have a Documentation Audit section, add
  one following the pattern of the existing Standards, Functional,
  and Content audit sections.
- Be honest in scoring. A 100% pass rate is the goal, not a gift.
