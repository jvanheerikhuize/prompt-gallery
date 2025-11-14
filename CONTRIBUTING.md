# Contributing to prompt-gallery

I'm excited that you're interested in contributing!
## Code of Conduct

All contributors are expected to follow my [Code of Conduct](CODE_OF_CONDUCT.md). Please take a moment to read it before you get started.

## ❓ How to Contribute

We welcome contributions of all types, from fixing bugs to adding new features or improving documentation.

If you're unsure where to start, check the [open issues]([/issues]) for items tagged `bug` or `help wanted`.

### 1. Before You Start

* **Discuss First:** For any significant change (e.g., a new feature, a large refactor), **please open an issue first** to discuss the proposed changes. This ensures we're aligned on the direction and avoids wasted effort.
* **Check Existing Issues:** Make sure an issue for your change doesn't already exist.
* **Assign Yourself:** If you're picking up an existing issue, please leave a comment and ask to be assigned so others know it's being worked on.

### 2. The Contribution Workflow

1.  **Fork the Repository:** Create your own fork of the project.
2.  **Clone Your Fork:** `git clone https://github.com/jvanheerikhuize/prompt-gallery.git`
3.  **Create a Branch:** Create a new branch for your changes.
    * We use the following naming convention:
        * `feature/[issue-id]-short-description` (e.g., `feature/123-add-auth-endpoint`)
        * `fix/[issue-id]-fix-typo` (e.g., `fix/456-fix-login-bug`)
        * `docs/[issue-id]-update-readme`
    * **Example:** `git checkout -b feature/123-add-auth-endpoint`
4.  **Make Your Changes:** Write your code and tests!

### 3. Development Standards

To maintain code quality and streamline reviews, we enforce the following standards.

#### 💬 Commit Messages
I use **[Conventional Commits](https://www.conventionalcommits.org/)** to maintain a clear and automated version history. This is crucial for our changelogs and release process.

Your commit message header (the first line) should follow this format:

`type(scope): subject`

* **type:** `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`
* **scope (optional):** The module or component affected (e.g., `api`, `auth`, `ui`)
* **subject:** A short, imperative-tense description of the change.

**Good Examples:**
* `feat(api): add user deletion endpoint`
* `fix(auth): correct password reset token validation`
* `docs: update a code example in the README`

**Bad Examples:**
* `fixed bug`
* `wip`
* `updated stuff`

### 4. Submitting Your Pull Request (PR)

1.  **Push Your Branch:** `git push origin feature/123-add-auth-endpoint`
2.  **Open a Pull Request:** Go to the original repository on GitHub and open a new Pull Request.
3.  **Fill Out the Template:** Our PR template will appear. **Please fill it out completely.** This is vital for providing context to the reviewers.
    * Link the issue(s) your PR resolves (e.g., "Closes #123").
    * Describe *what* you changed and *why*.

### 5. The Review Process

* The maintainers will review your PR.
* We aim to provide an initial review within `[2 business days]`.
* A maintainer may request changes. Please be open to feedback!
* Once your PR is approved, a maintainer will merge it.

Thank you for contributing!