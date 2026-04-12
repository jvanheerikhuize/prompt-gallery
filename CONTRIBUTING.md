# Contributing to Agentic Role Definitions

First off -- thank you for considering a contribution. This library grows through the ideas and effort of people like you, and every role added makes it more useful for everyone.

There are several ways to contribute, from fixing a typo to proposing an entirely new role persona. All are welcome.

---

## Ways to contribute

### Add a new role

Have an idea for an AI persona that belongs in this library? Open an issue to share your concept and get early feedback, then follow the steps below to build it out.

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

Spotted something unclear, outdated, or missing? Documentation PRs are just as valuable as prompt improvements -- submit one.

---

## Adding a new role

**Step 1 -- Open an issue first**

Share your concept before building. Include:
- What the role does and who it's for
- The category it belongs to (`entertainment`, `engineering`, `health`, `education`, `utility`, or `productivity`)
- The persona -- tone, humor, voice
- Any special constraints (sensitive topics, language requirements, scope limits)

Early feedback saves rework later.

**Step 2 -- Fork and build**

Fork the repo and create your role under `roles/<category>/<slug>/`. Each role directory should contain:
- `prompt.md` -- the full canonical system prompt
- `prompt-semanticode.md` -- a compressed variant
- `README.md` -- usage examples, API code, and safety notes

Add an entry in `index.yaml` for your role.

**Step 3 -- Open a pull request**

Submit your PR against `main`. Fill in the template with:
- A summary of the role
- The concept and target user
- Any design decisions that aren't obvious from the prompt itself

---

## Pull request guidelines

- **One concern per PR** -- a new role, a prompt fix, or a docs update. Not all three at once.
- **Test your prompt** -- paste it into at least one LLM and verify it behaves as intended before submitting.
- **Keep `prompt.md` and `prompt-semanticode.md` in sync** -- if you change the canonical prompt, update the SemantiCode variant too.
- **Health and sensitive roles** -- if your role touches mental health, crisis risk, minors, or GDPR Art. 9 data, follow the safety notes pattern in existing health roles.

---

## Code of conduct

Be respectful and constructive. Critique the work, not the person. This is a collaborative project and everyone is here to build something useful.

---

## Questions?

Open a [GitHub Discussion](../../discussions) or an [Issue](../../issues). Happy to help.
