# Security Policy

## Scope

This repository is a **project template**. It contains no application code, no credentials, and no runtime services. The attack surface is limited to:

- Template files copied into sibling projects
- The `a-sdlc/` governance submodule (maintained separately at [jvanheerikhuize/a-sdlc](https://github.com/jvanheerikhuize/a-sdlc))

## Reporting a Vulnerability

If you discover a security issue in this template (e.g. a file that could introduce a vulnerability into projects created from it), please **do not open a public issue**.

Report privately via [GitHub Security Advisories](../../security/advisories/new) or by emailing the repository owner directly.

Please include:

- A description of the issue and its potential impact
- Steps to reproduce or a proof of concept
- Any suggested remediation

You can expect an acknowledgement within 5 business days.

## Security in Sibling Projects

Projects created from this template are governed by the A-SDLC framework (`a-sdlc/`), which includes:

- **SC-01** — Core Directive Injection (immutable behavioural constraints)
- **SC-09** — Secrets scanning
- **SC-10** — Software composition analysis
- **SC-12 / SC-13** — SAST and DAST
- **GC-01** — Audit trail

See `a-sdlc/controls/sc/` for full security control definitions.
