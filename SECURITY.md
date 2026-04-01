# Security Policy

## What this repository contains

This is a library of plain-text AI prompt files. It contains no executable code, no credentials, no runtime services, and no external dependencies. The primary security consideration is **prompt content** — what the prompts instruct an AI to do, and whether that could cause harm when deployed.

## Scope

Security concerns relevant to this repository:

- **Prompt injection vectors** — a role prompt that could be manipulated to override safety constraints or produce harmful output
- **Unsafe defaults in health roles** — crisis detection, safe-messaging guidelines, or GDPR disclosures that are missing, incorrect, or misleading
- **Misinformation risk** — a role that makes false authoritative claims (medical, legal, financial) without appropriate scope limits
- **Privacy risk** — a role that inadvertently encourages users to share sensitive personal data without disclosure

Out of scope: issues with the LLM itself, the platform you run the prompts on, or your own deployment infrastructure.

## Reporting a vulnerability

If you find a security issue in any role prompt, **do not open a public issue**.

Report privately via [GitHub Security Advisories](../../security/advisories/new) or email the repository owner directly.

Please include:
- Which role is affected
- A description of the issue and its potential impact
- Steps to reproduce or an example of the problematic behaviour
- A suggested fix if you have one

You can expect an acknowledgement within 5 business days.

## Health role safety

The health roles (P.S.Y., F.R.A.N.K., V.I.T.A., P.A.P.A.) include:
- Mandatory crisis detection with tiered response
- Safe-messaging guidelines for sensitive topics
- GDPR Art. 9 disclosure for health data
- Explicit scope limits (these roles are not a substitute for clinical care)

Before deploying a health role in a product, verify that crisis line numbers are current and correct for your target region. The defaults are placeholders.
