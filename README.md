# Prompt Gallery: The MVC Prompt Framework

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

## 📖 Introduction

**Stop writing spaghetti prompts.**

As developers, we wouldn't write an entire application in a single `main()` function. Yet, most LLM prompts are unstructured walls of text that mix persona, logic, data, and formatting instructions.

**Prompt Gallery** is an open repository dedicated to standardizing **Prompt Engineering via the Model-View-Controller (MVC) pattern**.

We maintain a strict markup-based framework that separates concerns:
* **Model:** The knowledge, state schema, and reasoning logic.
* **View:** The output formatting and presentation layer.
* **Controller:** The session flow, user interaction rules, and guardrails.

## 🏗 The Architecture

This repository uses a `<MASTER_PROMPT>` template. Every use case in this gallery must adhere to this structure.

### Why MVC for LLMs?

1.  **Maintainability:** You can tweak the *View* (output format) without breaking the *Controller* (logic).
2.  **Predictability:** By defining a `<STATE_SCHEMA>`, we force the LLM to maintain consistency across long sessions.
3.  **Scalability:** Complex agent behaviors become manageable when broken down into components.

### The Template Structure

Every prompt in this gallery is built on the following skeleton:

```xml
<MASTER_PROMPT>
    <CORE_DIRECTIVES>
        <PERSONA>...</PERSONA>
        <VISION>...</VISION>
        <MISSION>...</MISSION>
    </CORE_DIRECTIVES>

    <MODEL>
        <STATE_SCHEMA></STATE_SCHEMA>
    </MODEL>

    <VIEW>
        <TEMPLATES></TEMPLATES>
    </VIEW>

    <CONTROLLER>
        <SESSION_PHASES></SESSION_PHASES>
        <SESSION_LOOP></SESSION_LOOP>
        <SESSION_RULES></SESSION_RULES>
    </CONTROLLER>
</MASTER_PROMPT>
```

## 🚀 Getting Started

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/jvanheerikhuize/prompt-gallery.git](https://github.com/jvanheerikhuize/prompt-gallery.git)
    ```
2.  **Pick a use-case:** Browse the `/Fun` or `/Productivity` directory.
3.  **Deploy:** Copy the raw content of the `prompt-template.md` file and paste it into your LLM of choice (Claude, GPT-4, etc.).

## 🤝 How to Contribute

We are looking for robust, production-ready configurations.

### We need use cases for:
* **Technical Architecture:** A prompt that acts as a System Design interviewer.
* **QA Automation:** A prompt that takes requirements and outputs Playwright/Cypress scripts (View layer) based on logic (Model layer).
* **Refactoring:** A controller that strictly iterates through code smells.

### Contribution Steps:
1.  **Fork** the repository.
2.  **Create** a new file in the appropriate folder or add one.
3.  **Implement** the MVC tags using the `prompt-template.md` as a base.
4.  **Test** your prompt to ensure the Controller enforces the rules defined in the Model.
5.  Submit a **Pull Request**.

## 📄 License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.
