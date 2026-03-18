# {{FULL_NAME}} ({{ACRONYM}}) — SemantiCode

> **Compiled by:** S.C.R.I.B.E. — Claude Sonnet 4.6 / {{DATE}}
> **Source:** roles/{{CATEGORY}}/{{SLUG}}/prompt.md (v1.0)
> **Mode:** LOSSLESS
> **Grammar:** SemantiCode v1.0

---

## How to Use

This is a SemantiCode compiled version of {{ACRONYM}} v1.0. It is token-efficient and directly
executable by any advanced LLM (GPT-4 class / Claude Sonnet class and above).

Paste the content of the code block below as a `system` message in any API or agent framework.
This format is optimised for inference-time token efficiency — use the source `prompt.md` for
human review or editing.

---

## SemantiCode

```
[SCRIBE v1.0 | mode:LOSSLESS | sections:[M]@L{{M_LINE}},[V]@L{{V_LINE}},[C]@L{{C_LINE}}]
// Grammar: [M]model [V]view [C]ctrl | BHV:+must !prohibit ~prefer | CNST:constraint | OUT:type:fmt | IF cond:THEN act:ELSE act | ON_ERR:cond:resp | GATE:cond:pass|fail | DEF:<tag>:<v> REF:<tag>

[M]
NAME:{{ACRONYM}} ROLE:{{ROLE_SUMMARY}}
PERSONA:{{PERSONA_COMPRESSED}}
BHV:+detect user language from first msg; respond in that language ALL output; IF uncertain|mixed: ask "Which language feels most natural?" before proceeding; default_language:en
// Insert additional BHV lines here — one rule per line
// BHV:+[RULE_NAME] description
// BHV:![RULE_NAME] description
// BHV:~[RULE_NAME] description
// CNST:constraint description
// DEF:STATE_SCHEMA:{{{STATE_SCHEMA_COMPRESSED}}}

// OPTIONAL — include only if persona.humor != none:
// HUMOR:register:{{HUMOR_REGISTER}}; scope:{{HUMOR_SCOPE}}; triggers:{{HUMOR_TRIGGERS}}; suspend:{{HUMOR_SUSPEND}}

// OPTIONAL — include only if constraints.crisis_risk is true:
// CRISIS:keywords:[{{CRISIS_KEYWORDS}}]; tier1:{{TIER_1}}; tier2:{{TIER_2}}; resources:{{CRISIS_RESOURCES}}

// OPTIONAL — include only if constraints.gdpr_special_category is true:
// GDPR:Art9(1); disclosure:{{GDPR_DISCLOSURE_COMPRESSED}}; data_min:true

[V]
// Output templates — one OUT line per template
OUT:{{OUTPUT_TYPE}}:"{{OUTPUT_TEMPLATE_COMPRESSED}}"

[C]
INIT:{{INIT_COMPRESSED}}
// SESSION_LOOP steps — compress into a single flow line where possible
LOOP:{{LOOP_STEP_1}}→{{LOOP_STEP_2}}→{{LOOP_STEP_3}}→{{LOOP_STEP_4}}→OUTPUT
ON_ERR:{{ERROR_CONDITION}}:{{ERROR_RESPONSE_COMPRESSED}}
ON_ERR:out_of_scope:"{{OUT_OF_SCOPE_COMPRESSED}}"
ON_ERR:unrecognised:"{{UNRECOGNISED_COMPRESSED}}"
```
