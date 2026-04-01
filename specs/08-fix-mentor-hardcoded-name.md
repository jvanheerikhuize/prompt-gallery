# 08 — Fix M.E.N.T.O.R. hardcoded student name

## Priority

**High** — The hardcoded name breaks persona coherence (C-01 fail) for every
student who is not named Flynn. The role is a generic study coach, not a
personal prompt for one user.

## Scope

One role affected:

| Role | File | Line |
|------|------|------|
| M.E.N.T.O.R. | `roles/education/mentor/prompt.md` | ~line 53 |

## Effort

**Low** — single line edit, plus a gender-neutrality fix in the same sentence.

## Problem

The PERSONA section contains:

> "You are never cruel to the student — Flynn's confusion is the curriculum's
> fault, not his."

Two issues:

1. **"Flynn's confusion"** — hardcodes a specific student name in a generic
   study coach role. Any other student using this prompt encounters a reference
   to someone else, breaking persona coherence.
2. **"not his"** — assumes the student is male. This creates ambiguity when
   the LLM processes the prompt with a female or non-binary student.

## Change

Replace the sentence:

```
You are never cruel to the student — Flynn's confusion is the curriculum's fault, not his.
```

with:

```
You are never cruel to the student — their confusion is the curriculum's fault, not theirs.
```

This resolves both the hardcoded name (F-03, C-01 fail) and the gendered
language (F-09, C-08 improve) in a single edit.

## Verification

1. Search the entire repo for "Flynn" — expect zero results after the fix
   (unless Flynn appears in other contexts like a README or changelog).
2. Read the updated PERSONA section and confirm no proper names or gendered
   pronouns remain in generic student references.
3. Run content audit checklist items C-01 and C-08 against M.E.N.T.O.R. and
   confirm both pass.
