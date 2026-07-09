# Security Policy

This document explains how to report security concerns for the Shawn Calvin Snelling / AXEZENT AI OPAC-018 Green-Schur Bridge repository.

---

## Project Status

**SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING**

This repository is a research and verification package. It contains manuscript materials, exact-arithmetic verification scripts, deterministic receipts, GitHub Actions workflows, and release assets.

The repository does not provide production cryptographic security, financial infrastructure, medical software, or safety-critical deployment software.

---

## Supported Versions

The currently supported public release is:

| Version | Supported |
|---|---|
| v2.1.x | Yes |
| v2.0.x and earlier | Historical reference only |

---

## Security Scope

Security reports are welcome for issues involving:

- unsafe execution behavior in scripts,
- malicious or unintended file writes,
- dependency risks,
- GitHub Actions workflow risks,
- release artifact integrity issues,
- manifest or SHA-256 verification problems,
- accidental exposure of secrets or tokens,
- reproducibility failures that could mislead reviewers.

---

## Out of Scope

The following are not security vulnerabilities by themselves:

- disagreement with the mathematical claim,
- requests for proof review,
- typos in documentation,
- theoretical objections to OPAC-018,
- missing citations,
- questions about external peer review,
- normal failing tests after local file modification.

Those should be opened as normal GitHub Issues instead.

---

## Reporting a Security Concern

Please report security concerns by opening a GitHub Security Advisory if available.

If GitHub Security Advisories are not enabled, open a private communication channel with the repository owner before posting exploit details publicly.

Include:

1. A short summary.
2. The affected file or workflow.
3. Steps to reproduce.
4. Expected behavior.
5. Actual behavior.
6. Any suggested fix.

---

## Responsible Disclosure

Please avoid publicly posting exploit details before the maintainer has had a reasonable opportunity to review the report.

This project is maintained by:

```text
Shawn Calvin Snelling
AXEZENT AI Research Lab
