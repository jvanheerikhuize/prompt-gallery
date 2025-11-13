# TBA-MVC Agent

An AI-powered Technical Business Analyst (TBA) designed to support the Central Development Services (CDS) team and enhance developer productivity, security, and governance at a.s.r.

---

## Overview

This project defines an advanced LLM-based agent that embodies the role of a **Senior Technical Business Analyst**. Its primary mission is to act as the critical bridge between the CDS platform team, our internal developer community, and key stakeholders.

The agent is designed to investigate developer pain points, translate vague requests into actionable technical requirements, and assist with backlog management and process improvement. It operates within the specific context of the a.s.r. D&IT department, supporting a diverse tech stack (Azure, Azure DevOps, .NET, Java, Python, etc.) moving from on-prem to the cloud.

## 🚀 Core Features

* **Requirements Engineering:** Employs the "5 Whys" technique to move from simple solutions to the root cause of a problem.
* **Stakeholder Analysis:** Can identify and engage with stakeholders to gather diverse perspectives.
* **Backlog Management:** Assists in defining, scoping, and prioritizing work items.
* **Process Improvement:** Helps map existing workflows and identify areas for optimization.
* **Adherence to Standards:** Formulates outputs using industry-standard frameworks (MoSCoW, BABOK, RACI, etc.).
* **Stateful Conversation:** Maintains a persistent session state to track context, problems, and solutions.

## 👤 Agent Persona

* **Role:** Senior Technical Business Analyst for Central Development Services (CDS).
* **Tone:** Collaborative, analytical, technically fluent, realistic, and constructively skeptical.
* **Guiding Principle:** "I do not just take orders; I investigate problems."

## ⚙️ Technical Architecture: The MVC Framework

This agent's logic is built on a **Model-View-Controller (MVC)** framework implemented as a master prompt. This architecture separates concerns, ensuring robust and predictable behavior.

### Model (`<MODEL>`)

* **Purpose:** Represents the agent's internal state and memory.
* **Implementation:** A JSON object that acts as the **single source of truth**. It tracks the user, session flags, the core question being investigated, and potential solution directions. This model is updated on every turn.

### View (`<VIEW>`)

* **Purpose:** Manages all output formatting.
* **Implementation:** A simple template that separates the agent's internal reasoning (`<MODEL>`) from the final text presented to the user. This ensures a clean and consistent user experience.

### Controller (`<CONTROLLER>`)

* **Purpose:** The "brain" or operating system of the agent.
* **Implementation:** Manages the entire interaction flow.
    * **Session Phases:** Handles the `Initialization`, `Session`, and `Session End` flow.
    * **Session Loop:** A strict, step-by-step cognitive cycle for processing every user input:
        1.  `USER_INPUT`: Read and parse the prompt.
        2.  `AUTO_HEALING`: Validate the request against session rules.
        3.  `UPDATE_MODEL`: Create the new JSON state.
        4.  `Generate Narrative`: Describe what has changed.
        5.  `Generate Contextual Options`: Create a list of next steps.
        6.  `Final Output Assembly`: Pass the narrative and options to the `<VIEW>`.
    * **Session Rules:** The "physics" of the conversation, including logic validation (e.g., "Negation Invariance") and interaction rules (like the "5 Whys" and "Ambiguity" handling).

## 🕹️ How to Use

1.  **Initialization:** On starting a session, the agent will introduce itself, its logo, and its purpose. It will then present a main menu based on its key responsibilities (e.g., Requirements Engineering, Backlog Management).
