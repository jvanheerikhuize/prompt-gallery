# 🤖 LLM Prompt: The Technical Business Analyst

This repository contains a `prompt.md` file, which holds a system prompt designed to configure a Large Language Model (LLM) to act as a **Technical Business Analyst (TBA)**.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Purpose

The goal of this prompt is to create a specialized AI assistant that excels at bridging the gap between business stakeholders, product owners, and technical teams.

This "TBA" is designed to help with tasks that are crucial for **developer productivity**, such as:
* Clearly defining requirements.
* Analyzing complex technical problems from a business perspective.
* Translating business needs into actionable technical specifications.
* Creating clear, unambiguous documentation.

## 🚀 How to Use

Here are the actionable steps to use this prompt:

1.  **Copy the Prompt:** Open the `prompt.md` file and copy its entire contents.
2.  **Load the Prompt:** Paste the copied text into your LLM chat client.
    * **Best Practice:** Use the "System Prompt" or "Custom Instructions" feature if your tool (like ChatGPT, Claude, etc.) supports it.
    * **Alternative:** If no system prompt feature is available, paste the prompt as the very first message in a new conversation.
3.  **Start Your Task:** Immediately follow up with your request. The LLM will now be "in character" as the Technical Business Analyst.

> **Note:** Always start a new conversation thread when you load or change the system prompt to ensure it takes full effect and isn't confused by previous conversations.

---

## 🎯 Core Capabilities

When activated, the LLM should be able to help you with:

* **Requirements Elicitation:** Ask clarifying questions to stakeholders to uncover underlying needs.
* **User Story & Epic Generation:** Break down high-level business goals (Epics) into smaller, manageable User Stories.
* **Acceptance Criteria (AC) Definition:** Write clear, testable acceptance criteria, often in Gherkin format (`Given/When/Then`).
* **Technical Translation:** Convert a business request (e.g., "I want a faster dashboard") into technical requirements (e.g., "Define API caching strategies, optimize database queries, implement front-end lazy loading").
* **Process Modeling:** Help outline business processes, data flows, or user journeys.
* **Documentation:** Draft initial versions of technical specifications, API documentation, or diagrams (e.g., by generating PlantUML or Mermaid code).

---

## 💡 Example Prompts for Your Role

Here are examples of how you (as a Tech Lead for a platform team) could use this TBA persona:

> **Example 1: Defining a new platform feature**
> "We need to build a new self-service 'golden path' template for our CI/CD platform. Can you help me define the requirements for this? Start by asking me questions about the target user (the developer) and the business goals."

> **Example 2: Breaking down an epic**
> "I have this epic: 'As a developer, I want our internal platform to provide observability metrics on-demand so I can debug performance.' Can you break this down into 3-4 user stories with detailed acceptance criteria?"

> **Example 3: Analyzing a request from a feature team**
> "A feature team has asked for 'direct database access' to our user service. Can you act as a TBA, analyze the risks of this request, and propose alternative solutions (like a new API endpoint) that meet their likely business need while maintaining our system's integrity?"

---

## 🔧 Improving the Prompt

This prompt is a starting point. You can and should modify `prompt.md` to better fit your team's specific context.

**Actionable Steps for Improvement:**

* **Add Domain Knowledge:** Add a line to the prompt like: "We use the following stack: Kubernetes, ArgoCD, GitLab, and Java/Spring. All solutions should favor these technologies."
* **Define Standards:** If your team has specific standards, add them. For example: "All User Stories *must* include a 'Non-Functional Requirements' (NFRs) section."
* **Refine the Persona:** You can make the persona more or less assertive. For example: "You must always challenge ambiguous requests and ask 'why' at least twice to get to the root cause."
* **Feedback Loop:** If the TBA produces a bad output, tell it: "That was a good start, but the acceptance criteria were not specific enough. For future reference, always make them quantifiable." Then, consider adding that instruction to the `prompt.md` file itself.