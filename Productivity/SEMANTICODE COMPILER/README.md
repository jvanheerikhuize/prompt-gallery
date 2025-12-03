# SemantiCode Compiler

**A Meta-Prompt for compressing human-readable system instructions into token-efficient logic streams.**

![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

## 📖 Overview

The **SemantiCode Compiler** is a system prompt utility designed to optimize Large Language Model (LLM) context windows. It acts as a "compiler" that takes verbose, human-readable prompt structures (specifically those following an MVC architecture) and strips them down to their bare semantic logic.

The output is **SemantiCode**: a highly compressed, syntax-heavy format that retains 100% of the instruction's intent while reducing token usage by significant margins.

## 🚀 Why Use This?

For developers and prompt engineers working with complex chains or limited context windows, verbose prompts are expensive and prone to "forgetting."

* **Token Efficiency:** Reduces prompt size by removing conversational padding and structural XML overhead.
* **Logic Hardening:** Forces a strict separation of concerns (Kernel, Operations, Interface).
* **Auditability:** Retains trace references (`[#RefID]`) to the original source prompt for debugging.

## ⚙️ Architecture: MVC to KPI

The compiler transforms standard Prompt Engineering architecture into a Tensor format known as **KPI**:

| Source (MVC) | Target (KPI) | Description |
| :--- | :--- | :--- |
| **<CORE/MODEL>** | **K (Kernel)** | Identity, fundamental truths, context data, and state definitions. |
| **<CONTROLLER>** | **OP (Operations)** | Logic flows, algorithmic chains, decision trees, and guardrails. |
| **<VIEW>** | **IF (Interface)** | Output formatting, styling, and templates. |

## 🛠️ Syntax Reference

The output SemantiCode utilizes specific syntax to define relationships and constraints:

* `SECTION:{...}` : Defines the scope (Kernel, Operations, or Interface).
* `A->B` : Linear logic flow (If A, then B).
* `A|B` : Logical OR.
* `!` : Strict Constraint / negative constraint.
* `$Var` : Variable placeholder.
* `[#Ref]` : Reference tag tracing back to the original verbose prompt.

## 📋 Usage Instructions

### 1. Initialize the Compiler
Copy the contents of `prompt.md` and paste it into a fresh LLM session (ChatGPT, Claude, etc.).

### 2. Input Your Master Prompt
Paste your verbose, structured system prompt into the chat.
*Tip: The compiler works best if your input prompt uses XML tags like `<ROLE>`, `<INSTRUCTIONS>`, `<OUTPUT>`.*

### 3. Receive Compiled Code
The LLM will output a code block containing the `::SYS_v1::` SemantiCode string.

### 4. Deploy
Copy the compiled code block and use it as the `System Message` in your API calls or generic chatbot interactions to save tokens.

---

## ⚡ Example

**Input (Verbose):**
```xml
<SYSTEM_ROLE>
You are a weather assistant. You only speak in JSON.
</SYSTEM_ROLE>
<INSTRUCTIONS>
If the user asks for rain, check the precipitation database.
</INSTRUCTIONS>