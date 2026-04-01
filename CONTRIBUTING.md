# Contributing to AI Role Library

First off — thank you for considering a contribution. This library grows through the ideas and effort of people like you, and every role added makes it more useful for everyone.

There are several ways to contribute, from fixing a typo to proposing an entirely new role persona. All are welcome.

---

## Ways to contribute

### Add a new role

Have an idea for an AI persona that belongs in this library? The ingestion process handles all the heavy lifting. Open an issue to share your concept and get early feedback, then follow the guided process to build it out.

See [Adding a new role](#adding-a-new-role) below for the full workflow. The process definition and role templates live in [`src/`](src/).

### Improve an existing role

Found a behaviour that feels off? A scenario the prompt doesn't handle well? A better way to phrase something? Open a pull request with your change and explain what it fixes and why.

When improving a role, update both `prompt.md` and `prompt-semanticode.md` to keep them in sync.

### Report a bug

Open a [GitHub Issue](../../issues) and describe:
- Which role and which LLM you were using
- What you expected the role to do
- What it actually did
- The input that triggered it (if reproducible)

### Improve documentation

Spotted something unclear, outdated, or missing? Documentation PRs are just as valuable as prompt improvements — submit one.

---

## Adding a new role

The process for adding a role is defined in [`src/ingest.md`](src/ingest.md) and is designed to be run with an AI coding agent (Claude Code, Cursor, Copilot, etc.). Role file templates live in [`src/templates/`](src/templates/) — the agent uses these as a structural baseline and fills in the placeholders.

**Step 1 — Open an issue first**

Share your concept before building. Include:
- What the role does and who it's for
- The category it belongs to (`entertainment`, `engineering`, `health`, `education`, `utility`, or `productivity`)
- The persona — tone, humor, voice
- Any special constraints (sensitive topics, language requirements, scope limits)

Early feedback saves rework later.

**Step 2 — Fork and run ingestion**

Once the concept is aligned, fork the repo and paste the contents of [`src/ingest.md`](src/ingest.md) into any AI coding agent. The agent walks you through each step and pauses at the two human gates (COLLECT and REVIEW) for your input. It produces all required files: `prompt.md`, `prompt-semanticode.md`, `README.md`, and the `index.yaml` entry.

**Step 3 — Open a pull request**

Submit your PR against `main`. Fill in the template with:
- A summary of the role
- The concept and target user
- Any design decisions that aren't obvious from the prompt itself

---

## Pull request guidelines

- **One concern per PR** — a new role, a prompt fix, or a docs update. Not all three at once.
- **Test your prompt** — paste it into at least one LLM and verify it behaves as intended before submitting.
- **Keep `prompt.md` and `prompt-semanticode.md` in sync** — if you change the canonical prompt, update the SemantiCode variant too.
- **No SCRIBE_META blocks** — do not add metadata sections to prompt files. See [`src/ingest.md`](src/ingest.md) validation rules V-13 through V-16.
- **Health and sensitive roles** — if your role touches mental health, crisis risk, minors, or GDPR Art. 9 data, follow the safety notes pattern in existing health roles.

---

## Industry standards audit (RSI loop)

This repo is continuously evaluated against published prompt engineering
standards from Anthropic, OpenAI, Google, and OWASP using a Recursive
Self-Improvement (RSI) process.

**Cadence:** quarterly (January, April, July, October).

**How to run an audit:**

1. Open an AI coding agent at the repo root.
2. Paste the contents of the audit prompt you want to run:
   - [`src/audit.md`](src/audit.md) — standards and security compliance
   - [`src/audit-functional.md`](src/audit-functional.md) — functional readiness
3. The agent runs the full loop: audit prompts, update the scorecard,
   generate specs for any gaps.

**What it produces:**

- Updated source registry (`audits/sources.yaml`)
- Updated README scorecard with behind/spot-on/ahead per topic
- New specs in `specs/` for anything that falls behind
- An entry in `audits/log.md` tracking improvement over time

The source registry is a living document — new authorities are discovered
and added during every audit cycle. See [`audits/sources.yaml`](audits/sources.yaml)
for the current list.

---

## Code of conduct

Be respectful and constructive. Critique the work, not the person. This is a collaborative project and everyone is here to build something useful.

---

## Questions?

Open a [GitHub Discussion](../../discussions) or an [Issue](../../issues). Happy to help.
