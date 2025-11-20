# Recursive Optimization Architect (MVC Prompt Compiler)

![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

## 📋 Overview

The **Recursive Optimization Architect** is a meta-prompt designed to treat Natural Language Processing (NLP) inputs as "source code" and compiled execution logic.

Unlike standard prompt improvers that focus on linguistic polish, this tool functions as a **compiler**. It ingests a user's draft prompt, deconstructs it using **Model-View-Controller (MVC)** principles, and "re-compiles" it into a dense, machine-optimized artifact (XML). The goal is to maximize token efficiency and inference adherence, prioritizing model performance over human readability.



## 🏗 Architecture

This prompt operates on a strict MVC framework defined within its own XML structure:

| Component | Function |
| :--- | :--- |
| **<MODEL>** | Defines the state schema, variable types (`input_intent`, `structural_integrity`), and optimization vectors. |
| **<CONTROLLER>** | The logic engine. It runs a `SESSION_LOOP` that executes Deconstruction, Optimization (densification, constraint injection), and Compilation. |
| **<VIEW>** | The rendering layer. It ensures the output is strictly bifurcated into a human-readable analysis and the machine-optimized code block. |

## 🚀 Usage

1.  **Initialization**: Copy the full source code from `master_prompt.xml` (or the code block below) and paste it into an LLM (Claude, GPT-4, etc.).
2.  **Ingestion**: The LLM will adopt the persona of the `Recursive Optimization Architect`.
3.  **Compilation**: Paste your own draft prompt (the one you want to improve).
4.  **Result**: The Architect will output:
    * **Optimization Analysis**: A breakdown of why your prompt was weak and what "patches" were applied.
    * **Optimized Artifact**: A dense, XML-structured prompt ready for production use.

## 🧩 The Logic Cycle

When you feed a prompt into this Architect, it undergoes the following internal phases:

1.  **Deconstruction**: Separates explicit rules from implicit intent.
2.  **Instruction Densification**: Removes conversational fluff to save context window space.
3.  **Constraint Injection**: Hardens the prompt by adding negative constraints (what *not* to do).
4.  **State Reification**: Converts loose text descriptions into strict JSON/XML variables.
5.  **CoT Integration**: Injects "Chain of Thought" triggers to force step-by-step reasoning in the final output.



[Image of flow chart showing data processing cycle]


## 📝 Example

**User Input:**
> "I want a prompt that acts like a travel agent. It should ask me where I want to go and then give me an itinerary."

**Architect Output (Trace):**
> * **Analysis**: Input lacks constraint. State is loose.
> * **Action**: Applying `State Reification` to track budget and dates. Applying `Constraint Injection` to prevent hallucinated flight prices.

**Architect Output (Artifact):**
```xml
<AGENT role="Travel_Optimiser">
  <CONSTRAINTS>
    1. NO generic advice; specific locations only.
    2. DO NOT list prices unless explicitly requested.
  </CONSTRAINTS>
  <LOOP>
    <STEP>Ingest(Destination, Budget, Duration)</STEP>
    <STEP>Generate_Itinerary(Granularity: Hourly)</STEP>
  </LOOP>
</AGENT>
```

## 📄 License

This project is licensed under the Apache License, Version 2.0.

```text
Copyright [Year] [Your Name/Organization]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

---

### ⚠️ Disclaimer
*This prompt is designed for advanced prompt engineering tasks. The output artifacts are often dense and difficult for humans to read casually, as they are optimized for LLM token processing.*