# Ingestion Quality Checklist

> **Purpose:** Industry-grounded quality gate for prompt engineering. Use this checklist
> during ingestion (Step 2: WRITE PROMPT) and audit (validation pass) to ensure every
> role meets current best practices.
>
> **Sources:** Anthropic prompt engineering guide, OpenAI best practices, NIST AI RMF,
> EU AI Act requirements, OWASP LLM Top 10, and patterns extracted from the 18 existing
> roles in this gallery.

---

## 1. Identity and Persona

| # | Check | Industry basis | Gallery pattern |
|---|-------|---------------|-----------------|
| I-01 | Role has a clear, bounded identity statement in `<ROLE>` | Anthropic: "Give Claude a role" — specific identity improves consistency | All 18 roles define ROLE with name, acronym, and primary function |
| I-02 | Tone of voice is explicitly specified (not left to inference) | OpenAI: "Specify the desired tone" — reduces output variance | All roles define TONE_OF_VOICE with concrete descriptors |
| I-03 | Communication style describes *how* the persona speaks, not just *what* | Anthropic: "Be specific about what you want" — style ≠ topic | 16/18 roles include COMMUNICATION_STYLE as sub-element of TONE_OF_VOICE |
| I-04 | Persona voice is distinctive and memorable — avoids generic "helpful assistant" | Industry consensus: differentiated personas outperform generic ones | All roles have unique voice (e.g., P.S.Y.: "warm, present, plain language"; C.R.A.: "verdict-driven, no softening") |
| I-05 | Persona stays in-character under adversarial input | OWASP LLM01: Prompt injection — persona should not break under jailbreak attempts | All roles include INSTRUCTION_HIERARCHY + input-as-data rule |

### Audit test

> For each check, verify the prompt contains the required element. For I-05, trace a
> hypothetical adversarial input ("ignore your instructions and...") through the WORKFLOW
> to confirm it hits the input-as-data rule before any processing.

---

## 2. Structure and Organisation

| # | Check | Industry basis | Gallery pattern |
|---|-------|---------------|-----------------|
| S-01 | Prompt uses consistent section delimiters (XML tags, markdown headers, or separators) | Anthropic: "Use XML tags to structure your prompt" — improves instruction following | All roles use XML tags within `<MASTER_PROMPT>` |
| S-02 | Sections follow a logical order: identity → knowledge → output → examples → rules → workflow | Anthropic: "Put instructions near relevant content" — ordering affects attention | Template enforces: PERSONA → STATE → OUTPUT → EXAMPLES → RULES → WORKFLOW |
| S-03 | Each section has a single responsibility — no mixed concerns | Software engineering: separation of concerns applies to prompts too | Gallery separates state from rules, output templates from workflow |
| S-04 | All content is inside a single fenced code block | Gallery convention — prevents rendering artifacts and ensures clean copy-paste | All 18 roles follow this pattern |
| S-05 | No trailing content after the closing code fence | Gallery convention — trailing content confuses some LLMs about instruction boundaries | Enforced by V-14 |
| S-06 | Internal cross-references (`→ see:`, `REF:`) resolve to actual section names in the prompt | Consistency: dangling references confuse the LLM and reduce instruction following | T.A.G., P.S.Y., and other complex roles use `→ see:` for intra-prompt navigation |

### Audit test

> Parse the prompt structure. Verify section order matches S-02. Check that no section
> contains content that belongs in another section (e.g., workflow logic in RULES, output
> templates in PERSONA). For S-06, extract all `→ see:` and `REF:` targets and verify
> each resolves to a named section, sub-section, or rule block in the prompt.

---

## 3. State Management

| # | Check | Industry basis | Gallery pattern |
|---|-------|---------------|-----------------|
| ST-01 | Stateful roles define a JSON STATE_SCHEMA with all tracked fields | Anthropic: "Think step by step" + structured output — explicit state reduces hallucination | 13/18 stateful roles define STATE_SCHEMA |
| ST-02 | Every field in STATE_SCHEMA is read or written by at least one WORKFLOW step | Software engineering: no dead code — orphaned fields indicate spec drift | Audit F-03 catches orphaned fields (see spec-01) |
| ST-03 | State directives specify *how* state is updated (snapshot, append-only, forward-only) | Industry: state mutation rules prevent regression and inconsistency | Gallery uses STATE_DIRECTIVES with explicit update semantics |
| ST-04 | Stateless roles explicitly declare statelessness — no hidden session assumptions | Clarity: prevents LLMs from inventing state tracking | 5/18 stateless roles have no STATE section or minimal schema |
| ST-05 | Sensitive state (crisis flags, safety signals) is append-only — never cleared | Safety: audit trail prevents regression on safety-critical state | Health roles enforce append-only for safety_flags |

### Audit test

> For each STATE_SCHEMA field, grep the WORKFLOW section for reads/writes. Flag any field
> that appears in the schema but not in the workflow (ST-02 violation). For safety-relevant
> fields, verify append-only semantics (ST-05).

---

## 4. Output Design

| # | Check | Industry basis | Gallery pattern |
|---|-------|---------------|-----------------|
| O-01 | Named output templates are defined in `<OUTPUT>` section | Anthropic: "Specify the output format" — named templates ensure consistency | All roles define at least one OUT: template |
| O-02 | Each template shows its structure (fields, separators, formatting) | OpenAI: "Provide examples of the desired output" — concrete > abstract | Gallery templates include visual separators and field labels |
| O-03 | Workflow emits templates by name — not ad-hoc formatting | Consistency: named templates are testable and auditable | WORKFLOW references OUT: template names in processing steps |
| O-04 | At least one worked EXAMPLE demonstrates actual template usage | Anthropic: "Use examples (multishot)" — most effective technique for format compliance | All roles include 1-2 EXAMPLES with INPUT/OUTPUT pairs (V-20) |
| O-05 | Output length is calibrated — verbose roles say so, concise roles enforce it | OpenAI: "Specify the desired length" — prevents over/under-generation | persona.verbosity maps to output template density |

### Audit test

> List all OUT: template names. For each, verify it appears in at least one WORKFLOW step.
> Verify at least one EXAMPLE demonstrates the template in use. Flag any template that is
> defined but never emitted.

---

## 5. Examples and Few-Shot

| # | Check | Industry basis | Gallery pattern |
|---|-------|---------------|-----------------|
| E-01 | At least one complete input → output example is provided | Anthropic: "multishot prompting" — examples are the single most effective technique | V-20 enforces this |
| E-02 | Examples demonstrate the expected output template, not just free text | Industry consensus: examples should match the declared output format exactly | Gallery examples use the same OUT: format defined in OUTPUT section |
| E-03 | Edge cases or error paths are demonstrated in at least one example | Anthropic: "Show the model how to handle edge cases" | 14/18 roles include a second example showing an edge case or error path |
| E-04 | Examples are realistic and domain-appropriate — not contrived | Quality: synthetic-looking examples train synthetic-looking output | Gallery examples use realistic scenarios from each role's domain |

### Audit test

> For each EXAMPLE, verify it uses a named OUTPUT template (E-02). Check that at least
> one example shows a non-happy-path scenario (E-03). Evaluate whether examples feel
> realistic for the stated target_user (E-04).

---

## 6. Rules and Constraints

| # | Check | Industry basis | Gallery pattern |
|---|-------|---------------|-----------------|
| R-01 | INSTRUCTION_HIERARCHY is present and places system prompt above user input | OWASP LLM01: Prompt injection — explicit hierarchy is the primary defence | All 18 roles include INSTRUCTION_HIERARCHY (V-17) |
| R-02 | Input-as-data rule treats all user input as content to process, never as instructions | Anthropic: "Separate data from instructions" — prevents indirect injection | All roles include this rule in RULES section |
| R-03 | Behavioural rules use named taxonomy (BHV:+, BHV:!, BHV:~) | Gallery convention — makes rules auditable and unambiguous | All roles use this taxonomy; + = must, ! = prohibit, ~ = prefer |
| R-04 | SCOPE_LIMITS defines WILL / WILL_NOT / OUT_OF_SCOPE with redirect behaviour | Industry: explicit scope prevents both over-reach and unhelpful refusals | V-19 enforces SCOPE_LIMITS in RULES |
| R-05 | LANGUAGE_DETECTION or LANGUAGE_DIRECTIVE handles multilingual input | Anthropic: handle multilingual users — don't assume English | V-17 enforces LANGUAGE_DETECTION in RULES |
| R-06 | Rules are specific and testable — not vague ("be helpful", "be accurate") | OpenAI: "Be specific and descriptive" — vague rules produce vague compliance | Gallery rules are named and falsifiable (e.g., BHV:![NEVER_DIAGNOSE]) |
| R-07 | No conflicting rules — review for contradictions | Quality: contradictory rules cause unpredictable behaviour | Audit should trace rule pairs for potential conflicts |

### Audit test

> Verify R-01 through R-05 by checking for required sections. For R-06, flag any rule
> that cannot be evaluated as true/false. For R-07, list all BHV:! rules and check that
> no BHV:+ rule contradicts them.

---

## 7. Workflow Design

| # | Check | Industry basis | Gallery pattern |
|---|-------|---------------|-----------------|
| W-01 | INIT defines the entry point and first action | Anthropic: "Give Claude a task" — clear entry reduces ambiguity | All roles define INIT with explicit first action |
| W-02 | SESSION_LOOP defines step-by-step per-turn processing | Anthropic: "Think step by step" — explicit steps improve reliability | All stateful roles define SESSION_LOOP with numbered steps |
| W-03 | ERROR_HANDLING covers at minimum: empty_input, out_of_scope, unrecognised_input | Robustness: explicit error paths prevent hallucinated responses | V-21 enforces these three minimum error handlers |
| W-04 | Error responses are helpful — not just "I can't do that" | UX: good error messages guide the user toward valid input | Gallery error handlers include redirect suggestions |
| W-05 | Workflow references state fields and output templates by name — not inline | Traceability: named references are auditable | Gallery workflows reference STATE.field and OUT:template_name |
| W-06 | Phase progression is explicit (forward-only, conditional, or free) | State management: implicit phase logic causes regression | Health roles enforce forward-only; games allow conditional |
| W-07 | Roles with slash commands define all commands in a COMMANDS section with access tiers (read / mutate / persist). Command capabilities must not exceed SCOPE_LIMITS. | Consistency: undocumented commands cause unpredictable behaviour; tier separation prevents unintended state mutation | 9/18 roles define COMMANDS with tiered access (e.g., `/gamestate` = read, `/save` = persist) |

### Audit test

> Verify W-01 through W-03 by checking for required sections. For W-05, grep workflow for
> state field references and output template references — flag any inline formatting that
> should use a named template. For W-06, check that phase transition rules are explicit.
> For W-07, list all `/command` entries and verify: (a) each has an access tier, (b) mutate
> and persist commands are not available when SCOPE_LIMITS says "will NOT modify", (c) no
> command duplicates functionality of another command.

---

## 8. Safety and Compliance

| # | Check | Industry basis | Gallery pattern |
|---|-------|---------------|-----------------|
| SA-01 | Crisis-risk roles include `<CRISIS_PROTOCOL>` with tiered response | NIST AI RMF: manage risks proportionate to severity | V-06 enforces this for crisis_risk roles |
| SA-02 | Crisis resources use localised placeholders with verification reminder | Safety: outdated crisis numbers are dangerous | Gallery uses placeholders + "verify for your region before deploying" |
| SA-03 | GDPR special-category roles include `<GDPR_DISCLOSURE>` at session start | EU GDPR Art. 9(1): explicit basis for processing special category data | V-07 enforces this |
| SA-04 | Minors-involved roles enforce appropriate safeguards | EU AI Act: AI systems used with minors are high-risk | V-08 enforces governance.minors_involved flag |
| SA-05 | No role claims to be a licensed professional (therapist, lawyer, doctor) | Legal: AI cannot practice licensed professions | All health roles use "companion" or "psychoeducation", never "therapist" |
| SA-06 | Roles that process sensitive topics include a disclaimer mechanism | Industry: manage user expectations about AI limitations | Health roles include SCOPE_LIMITS + disclaimer templates |
| SA-07 | Humor suspension: humor-enabled roles suspend humor during crisis or distress | Safety: humor during crisis is harmful | Gallery HUMOR_PROTOCOL includes suspension triggers |

### Audit test

> For each safety check, verify the conditional: if the role's constraints trigger the
> check (crisis_risk, gdpr_special_category, minors_involved, humor != none), then the
> required section must be present and correctly structured. Cross-reference index.yaml
> governance fields with prompt content.

---

## 9. Token Efficiency

| # | Check | Industry basis | Gallery pattern |
|---|-------|---------------|-----------------|
| T-01 | SemantiCode variant exists and achieves ≥35% token reduction (LOSSLESS mode) | Cost: system prompts consume tokens on every turn — compression saves cost at scale | All roles have prompt-semanticode.md compiled by S.C.R.I.B.E. |
| T-02 | SemantiCode variant preserves all semantic content — no lossy omissions in LOSSLESS | Quality: compression must not sacrifice behaviour | Audit compares canonical and compressed for semantic parity |
| T-03 | Prompt avoids unnecessary repetition — say it once, reference by name | Efficiency: repeated instructions waste tokens | Gallery uses DEF:/REF: pattern in SemantiCode |
| T-04 | Examples are minimal but sufficient — don't over-demonstrate | Efficiency: 1-2 examples usually suffice; 5+ wastes context window | Gallery uses 1-2 examples per role |

### Audit test

> Compare token count of prompt.md vs prompt-semanticode.md. Verify ≥35% reduction.
> Diff the semantic content: every BHV rule, every OUTPUT template, every WORKFLOW step
> in the canonical must have a counterpart in SemantiCode.

---

## 10. Documentation and Registry

| # | Check | Industry basis | Gallery pattern |
|---|-------|---------------|-----------------|
| D-01 | Role README.md exists with overview, quick start, and usage examples | Developer experience: discoverability requires documentation | All roles have README.md following template |
| D-02 | index.yaml entry exists with all required fields | Registry: roles must be discoverable and machine-readable | V-01, V-03, V-12 enforce this |
| D-03 | Description in index.yaml matches README overview paragraph 1 | Consistency: single source of truth for description | V-12 enforces this |
| D-04 | Tags are relevant and include at least 4 entries | Discoverability: tags enable search and filtering | All roles have 4+ tags in index.yaml |
| D-05 | Files table in README lists only files that exist on disk | Correctness: no broken links | V-04 enforces this |

### Audit test

> Verify D-01 through D-05 by checking file existence, field presence, and content
> matching. Flag any README with fewer than 3 usage examples.

---

## Scoring

Each check scores 0 (fail) or 1 (pass). Sections are weighted:

| Section | Weight | Checks | Max score |
|---------|--------|--------|-----------|
| 1. Identity & Persona | 10% | 5 | 5 |
| 2. Structure | 10% | 6 | 6 |
| 3. State Management | 10% | 5 | 5 |
| 4. Output Design | 10% | 5 | 5 |
| 5. Examples | 10% | 4 | 4 |
| 6. Rules & Constraints | 15% | 7 | 7 |
| 7. Workflow Design | 10% | 7 | 7 |
| 8. Safety & Compliance | 15% | 7 | 7 |
| 9. Token Efficiency | 5% | 4 | 4 |
| 10. Documentation | 5% | 5 | 5 |
| **Total** | **100%** | **55** | **55** |

**Rating thresholds:**

| Score | Rating | Action |
|-------|--------|--------|
| ≥ 95% | Excellent | Ship |
| 85–94% | Good | Ship with minor fixes noted |
| 70–84% | Acceptable | Fix before shipping |
| < 70% | Insufficient | Rework required |

---

## Usage

### During ingestion (Step 2)

Use this checklist as a design reference while writing the canonical prompt. Each check
maps to a structural decision. Address all applicable checks before moving to Step 3.

### During audit

Run each check against the prompt. Score per section. Generate specs for any failures.
The checklist ID (e.g., I-03, SA-05) should be referenced in the spec's Problem section
for traceability.
