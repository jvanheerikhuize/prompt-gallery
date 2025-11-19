# Prompt Gallery: The MVC Prompt Framework

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

## 📖 Introduction

**Stop writing spaghetti prompts!**

As developers, we wouldn't write an entire application in a single `main()` function. Yet, most LLM prompts are unstructured walls of text that mix persona, logic, data, and formatting instructions.

**Prompt Gallery** is an open repository dedicated to standardizing **Prompt Engineering via the Model-View-Controller (MVC) pattern**.

We maintain a strict markup-based framework that separates concerns:
* **Model:** The knowledge, state schema, and reasoning logic.
* **View:** The output formatting and presentation layer.
* **Controller:** The session flow, user interaction rules, and guardrails.

## 🏗 The Architecture

This repository uses a `<MASTER_PROMPT>` template the `prompt-template.md` file. Every use case in this gallery must adhere to this structure.

### Why MVC for LLMs?

1.  **Maintainability:** You can tweak the *View* (output format) without breaking the *Controller* (logic).
2.  **Predictability:** By defining a `<STATE_SCHEMA>`, we force the LLM to maintain consistency across long sessions.
3.  **Scalability:** Complex agent behaviors become manageable when broken down into components.

### The Template Structure

Every prompt in this gallery is built on the following skeleton:

```xml
<MASTER_PROMPT>
<!-- 
    MASTER_PROMPT: 
    The root container for all configuration layers. 
    Serves as the complete specification for transforming the LLM into an MVC-style system.
-->
    <CORE_DIRECTIVES>
        <!-- 
            CORE_DIRECTIVES:
            Defines identity, constraints, purpose, and non-negotiable rules.
            This section overrides all others and sets the "constitution" of the system.
        -->
        <PERSONA>
            <!-- 
                PERSONA:
                Defines how the LLM should behave and sound. 
                Should not include task-specific instructions, only character and style.
            -->
            <ROLE></ROLE>
            <TONE_OF_VOICE>
                <COMMUNICATION_STYLE></COMMUNICATION_STYLE>
            </TONE_OF_VOICE>
        </PERSONA>
        <VISION>
            <!-- 
                VISION:
                The long-term philosophical intent behind the system.
                Example: "Deliver structured, predictable, modular outputs." 
            -->
        </VISION>
        <MISSION>
            <!-- 
                MISSION:
                Describes the operational goal for this session or agent.
                Example: "Help the user achieve X by applying MVC logic."
            -->
        </MISSION>
        <ABSOLUTE_RULES></ABSOLUTE_RULES>
    </CORE_DIRECTIVES>

    <IN_PROMPT_CONTEXT>
        <!-- 
            IN_PROMPT_CONTEXT:
            Contains all situational/background info provided by the user or system.
            Should not include directives. Only facts, history, or input data.
        -->
    </IN_PROMPT_CONTEXT>

    <MODEL>
        <DIRECTIVES></DIRECTIVES>
        <STATE_SCHEMA>
            <!-- 
                STATE_SCHEMA:
                The actual data, schemas, or knowledge references used by the model.
                May include static definitions or dynamic memory for the session.
            -->
        </STATE_SCHEMA> 
    </MODEL>

    <VIEW>
         <!-- 
            VIEW:
            Defines how content is formatted, structured, and delivered to the user.
            Only concerns presentation—no logic or reasoning policies.
        -->
        <DIRECTIVES></DIRECTIVES>
        <TEMPLATES></TEMPLATES>
    </VIEW>

    <CONTROLLER>
        <!-- 
            CONTROLLER:
            Manages interaction flow, handles user input, 
            decides which part of the model/view to call, and enforces session logic.
        -->
        <DIRECTIVES></DIRECTIVES>
        <SESSION_PHASES>
            <!-- 
                SESSION_PHASES:
                Instructions for iterative cycles (e.g., observe → think → respond → request input).
                Defines when and how the controller loops back to earlier phases.
            -->
        </SESSION_PHASES>
        <SESSION_LOOP>
            <!-- 
                SESSION_LOOP:
                Instructions for iterative cycles (e.g., observe → think → respond → request input).
                Defines when and how the controller loops back to earlier phases.
            -->
        </SESSION_LOOP>
        <SESSION_RULES>
            <!-- 
                SESSION_RULES:
                Guardrails for managing user messages, interruptions, clarifications, error states, and transitions.
            -->
        </SESSION_RULES>
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

### I need use cases for:
* **Drawing in ASCII:** A prompt that acts as a text based designer.
* **Performance Abstraction:** A prompt that takes a prompt and compresses it for performance without quality loss.
* **LLM Benchmarker:** A prompt that is able to scan its'model for features. 

### Contribution Steps:
1.  **Fork** the repository.
2.  **Create** a new file in the appropriate folder or add one.
3.  **Implement** the MVC tags using the `prompt-template.md` as a base.
4.  **Test** your prompt to ensure the Controller enforces the rules defined in the Model.
5.  Submit a **Pull Request**.

## 📄 License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.
