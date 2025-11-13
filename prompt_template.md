#Title of you prompt

**Author:** [Jerry van Heerikhuize](https://github.com/jvanheerikhuize)

## The Prompt

```text
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
