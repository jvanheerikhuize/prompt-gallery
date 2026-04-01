# 09 — Restructure role categories

**Priority:** Medium
**Scope:** `index.yaml`, `README.md`, `roles/` directory structure
**Effort:** Medium (directory moves, index updates, README rewrite)

## Problem

The current six categories (`entertainment`, `engineering`, `health`, `education`,
`productivity`, `utility`) were organically grown and no longer align with industry-standard
AI assistant taxonomies. Key gaps:

- **No writing/content category** — the single most universal prompt category across GPT Store,
  Copilot, and enterprise libraries.
- **No business category** — marketing, sales, customer support, and finance are the largest
  enterprise segments (45.8% of deployments are customer support alone).
- **No research category** — deep-reasoning and analysis agents are a top-3 trend in 2026.
- **`productivity`** contains only governance tools (A.G.L., P.R.I.M.E.) — misnamed for what
  they actually do.
- **`utility`** is a catch-all with no clear domain boundary.

## Proposed taxonomy

| # | Category | Slug | Description | Migration |
|---|----------|------|-------------|-----------|
| 1 | **Entertainment** | `entertainment` | Interactive games, collaborative fiction, experiences | Keep as-is (T.A.G., H.E.I.S.T., D.I.C.E., E.C.H.O.) |
| 2 | **Engineering** | `engineering` | Software development, code review, QA, DevOps, architecture | Keep as-is (C.R.A., F.O.R.G.E., Q.A.V.E.) |
| 3 | **Health** | `health` | Mental health, wellness, safety-critical support | Keep as-is (P.S.Y., F.R.A.N.K., P.A.P.A., V.I.T.A.) |
| 4 | **Education** | `education` | Learning, tutoring, curriculum support, skill development | Keep as-is (A.G.O.R.A., M.E.N.T.O.R., S.C.O.U.T.) |
| 5 | **Writing** | `writing` | Content creation, copywriting, editing, translation, technical writing | NEW — no migration needed |
| 6 | **Business** | `business` | Governance, compliance, marketing, sales, customer support, finance | Absorbs `productivity` → move A.G.L., P.R.I.M.E. |
| 7 | **Research** | `research` | Analysis, investigation, data interpretation, synthesis, reasoning | NEW — no migration needed |
| 8 | **Utility** | `utility` | Meta-tools, converters, formatters, infrastructure | Keep as-is (A.T.L.A.S., S.C.R.I.B.E.) |

### Rationale

- **Entertainment stays distinct** — games have unique stateful mechanics (inventory, NPCs,
  phases) that don't fit elsewhere.
- **Health stays distinct** — safety-critical domain with GDPR, crisis protocols; must not be
  diluted.
- **Writing is split from Productivity** — industry data shows writing/content is consistently
  its own top-level category (GPT Store, Anthropic, enterprise libraries). Mixing it with
  governance tools would confuse users.
- **Business absorbs Productivity** — A.G.L. (EU AI Act classifier) and P.R.I.M.E. (spec
  review) are governance/compliance tools, which map naturally to business operations. The
  broader "business" label also opens space for marketing, sales, and support roles.
- **Research is new** — deep-reasoning agents (synthesis, literature review, root-cause
  analysis) are a top-3 industry trend. Currently no home for these in the taxonomy.
- **Utility is kept lean** — meta-tools (S.C.R.I.B.E., A.T.L.A.S.) remain here. It's the
  "infrastructure" category — tools that support other roles or serve niche single-task needs.

## Change

1. Create `roles/writing/`, `roles/business/`, `roles/research/` directories.
2. Move `roles/productivity/agl/` → `roles/business/agl/`.
3. Move `roles/productivity/prime/` → `roles/business/prime/`.
4. Remove empty `roles/productivity/` directory.
5. Update `index.yaml`: change category field for A.G.L. and P.R.I.M.E., update file paths.
6. Update `README.md`: replace ⚡ Productivity section with 💼 Business, add ✍️ Writing and
   🔬 Research sections (initially empty or with planned roles noted).
7. Update `src/ingest.md` Step 0 field #2: replace `productivity` with `business`, add
   `writing` and `research` to the options list.

## Verification

- `roles/productivity/` no longer exists.
- `roles/business/agl/` and `roles/business/prime/` exist with all files intact.
- `index.yaml` has no references to category `productivity`.
- `README.md` has sections for all 8 categories.
- `src/ingest.md` field #2 lists all 8 categories.
- No broken file path references anywhere.
