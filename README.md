# Shawn Calvin Snelling — AXEZENT AI OPAC-018 Green-Schur Bridge

[![Axezent Proof-Audit CI](https://github.com/shawncalvinsnelling/axezent-opac018-green-schur-bridge/actions/workflows/audit.yml/badge.svg)](https://github.com/shawncalvinsnelling/axezent-opac018-green-schur-bridge/actions/workflows/audit.yml)
[![Latest Release](https://img.shields.io/github/v/release/shawncalvinsnelling/axezent-opac018-green-schur-bridge?label=release)](https://github.com/shawncalvinsnelling/axezent-opac018-green-schur-bridge/releases)
[![License](https://img.shields.io/github/license/shawncalvinsnelling/axezent-opac018-green-schur-bridge)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.11%2B-blue)](pyproject.toml)
[![Status](https://img.shields.io/badge/status-external%20review%20pending-orange)](#truth-boundary)

> **External-review research package for the OPAC-018 Green-Schur Bridge framework.**

**Author:** Shawn Calvin Snelling  
**Research label:** AXEZENT AI Research Lab  
**Current release:** [`v2.1.2`](https://github.com/shawncalvinsnelling/axezent-opac018-green-schur-bridge/releases/tag/v2.1.2)  
**Status:** **SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING**

---

## Overview

This repository contains the flagship Shawn Calvin Snelling / AXEZENT AI OPAC-018 Green-Schur Bridge external-review package.

It studies the root-polytope projection bound

```text
κ(Φ, U) < 2
```

through a reviewer-facing package that combines:

- a mathematical manuscript,
- exact rational verification tools,
- worked examples,
- negative-control stress tests,
- deterministic receipts,
- GitHub Actions continuous integration,
- release packaging,
- GitHub Pages reviewer navigation,
- contribution and issue templates,
- manifest integrity checks,
- SHA-256 release-integrity checking,
- and documentation designed for independent mathematical review.

This repository is intended to be the single public home for the OPAC-018 Green-Schur Bridge package.

---

## Truth Boundary

**SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING**

This project is presented as a solution candidate and external-review research package.

It does **not** claim:

- journal acceptance,
- referee acceptance,
- arXiv endorsement,
- independent mathematical verification already completed,
- resolution of unrelated mathematical problems,
- or replacement of expert peer review.

The included software checks the formulas, bounds, receipts, manifests, and consistency rules encoded in this repository.  
It is not a substitute for independent mathematical review.

---

## Table of Contents

- [Overview](#overview)
- [Truth Boundary](#truth-boundary)
- [Reviewer Quick Start](#reviewer-quick-start)
- [Run the Verification Suite](#run-the-verification-suite)
- [Release-Integrity Checks](#release-integrity-checks)
- [Repository Structure](#repository-structure)
- [Core Verification Programs](#core-verification-programs)
- [Manuscript and Review Files](#manuscript-and-review-files)
- [Examples](#examples)
- [Documentation Highlights](#documentation-highlights)
- [Receipts and Reproducibility](#receipts-and-reproducibility)
- [Release Package](#release-package)
- [Project Governance](#project-governance)
- [Citation](#citation)
- [License](#license)
- [Suggested Public Description](#suggested-public-description)
- [Roadmap](#roadmap)

---

## Reviewer Quick Start

For the fastest review path, begin here:

| Step | File | Purpose |
|---:|---|---|
| 1 | [`START_REVIEW_HERE.md`](START_REVIEW_HERE.md) | Fast reviewer entry point |
| 2 | [`CLAIMS_AND_NONCLAIMS.md`](CLAIMS_AND_NONCLAIMS.md) | Scope and truth-boundary summary |
| 3 | [`DEPENDENCY_TABLE.md`](DEPENDENCY_TABLE.md) | Proof and verification dependency table |
| 4 | [`docs/LITERATURE_COMPARISON.md`](docs/LITERATURE_COMPARISON.md) | Relationship to prior work |
| 5 | [`examples/example_A5.md`](examples/example_A5.md) | Worked Type A example |
| 6 | [`examples/example_C6.md`](examples/example_C6.md) | Worked Type C example |
| 7 | [`examples/example_D5.md`](examples/example_D5.md) | Worked Type D example |
| 8 | [`paper/main.tex`](paper/main.tex) | Manuscript source |

For the full repository path, start with:

```text
START_HERE.md
```

---

## Run the Verification Suite

From the repository root, run:

```bash
python -m compileall -q .
python pure_python_exact_audit.py
python counterexample_stress_test.py
python verify_all.py
python -m pytest tests/ -q
python verify_manifest.py
python build_sha_manifest.py --check
```

These are the same core checks now used by the restored GitHub Actions proof-audit workflow.

The workflow is located at:

```text
.github/workflows/audit.yml
```

---

## Release-Integrity Checks

As of `v2.1.2`, manifest verification and SHA-256 checking have been restored into the main CI workflow.

The repository includes:

```bash
python verify_manifest.py
python build_sha_manifest.py --check
```

The manifest refresh workflow is located at:

```text
.github/workflows/manifest-refresh.yml
```

It can be run manually when repository files change and the release-integrity receipts need to be regenerated.

---

## Repository Structure

| Folder | Purpose |
|---|---|
| [`assets/`](assets/) | Figures, diagrams, and visual documentation |
| [`csl/`](csl/) | Exact rational OPAC verification engine |
| [`docs/`](docs/) | Reviewer documentation, proof-risk notes, GitHub Pages guide, and literature comparison |
| [`examples/`](examples/) | Hand-checkable worked examples |
| [`paper/`](paper/) | Manuscript source and review PDFs |
| [`receipts/`](receipts/) | Deterministic JSON receipts and SHA-256 files |
| [`sage/`](sage/) | SageMath-related audit assets |
| [`tests/`](tests/) | Pytest regression tests |

---

## Core Verification Programs

| File | Purpose |
|---|---|
| [`csl/opac_engine.py`](csl/opac_engine.py) | Exact rational formula and envelope checker |
| [`pure_python_exact_audit.py`](pure_python_exact_audit.py) | Deterministic pure-Python audit runner |
| [`counterexample_stress_test.py`](counterexample_stress_test.py) | Negative-control and malformed-claim rejection checks |
| [`verify_all.py`](verify_all.py) | Master local verification runner |
| [`verify_manifest.py`](verify_manifest.py) | Release-manifest consistency checker |
| [`build_sha_manifest.py`](build_sha_manifest.py) | SHA-256 manifest builder and checker |
| [`receipt_summary.py`](receipt_summary.py) | Receipt summary utility |

---

## Manuscript and Review Files

| File | Purpose |
|---|---|
| [`paper/main.tex`](paper/main.tex) | Main manuscript source |
| [`paper/OPAC018-Green-Schur-Bridge-External-Review-v2_1_0.pdf`](paper/OPAC018-Green-Schur-Bridge-External-Review-v2_1_0.pdf) | v2.1.0 review PDF |
| [`START_HERE.md`](START_HERE.md) | Complete project entry point |
| [`START_REVIEW_HERE.md`](START_REVIEW_HERE.md) | Fast reviewer entry point |
| [`CLAIMS_AND_NONCLAIMS.md`](CLAIMS_AND_NONCLAIMS.md) | Claim boundary and non-claim list |
| [`REVIEW_READY_CHECKLIST.md`](REVIEW_READY_CHECKLIST.md) | Review readiness checklist |
| [`REFEREE_QA_MATRIX.md`](REFEREE_QA_MATRIX.md) | Referee question-and-answer matrix |
| [`REFEREE_ROADMAP.md`](REFEREE_ROADMAP.md) | Review roadmap |
| [`OPAC018_OPEN_AUDIT_ITEMS.md`](OPAC018_OPEN_AUDIT_ITEMS.md) | Open audit items |

---

## Examples

| Example | Purpose |
|---|---|
| [`examples/example_A5.md`](examples/example_A5.md) | Type A worked calculation |
| [`examples/example_C6.md`](examples/example_C6.md) | Type C worked calculation |
| [`examples/example_D5.md`](examples/example_D5.md) | Type D worked calculation |
| [`examples/README.md`](examples/README.md) | Examples overview |

---

## Documentation Highlights

| File | Purpose |
|---|---|
| [`docs/FORMAL_ASSUMPTIONS.md`](docs/FORMAL_ASSUMPTIONS.md) | Formal assumptions and input boundaries |
| [`docs/DEPENDENCY_GRAPH.md`](docs/DEPENDENCY_GRAPH.md) | Dependency graph documentation |
| [`docs/LITERATURE_COMPARISON.md`](docs/LITERATURE_COMPARISON.md) | Comparison to related literature |
| [`docs/PROOF_RISK_LEDGER.md`](docs/PROOF_RISK_LEDGER.md) | Proof-risk and review-risk notes |
| [`docs/KNOWN_FAILURE_MODES.md`](docs/KNOWN_FAILURE_MODES.md) | Known failure modes and boundaries |
| [`docs/VISUAL_ASSET_GUIDE.md`](docs/VISUAL_ASSET_GUIDE.md) | Visual asset guide |
| [`docs/ZERO_FLOAT_INTEGER_CROSS_PRODUCT_RULE.md`](docs/ZERO_FLOAT_INTEGER_CROSS_PRODUCT_RULE.md) | Zero-float verification rule |
| [`docs/GITHUB_PAGES_SETUP.md`](docs/GITHUB_PAGES_SETUP.md) | GitHub Pages setup guide |

---

## Receipts and Reproducibility

The repository includes deterministic receipt files under:

```text
receipts/
```

Important files include:

| File | Purpose |
|---|---|
| [`receipts/opac18_green_schur_pure_python_results.json`](receipts/opac18_green_schur_pure_python_results.json) | Exact audit receipt |
| [`receipts/counterexample_stress_test_results.json`](receipts/counterexample_stress_test_results.json) | Stress-test receipt |
| [`receipts/global_audit_summary.json`](receipts/global_audit_summary.json) | Global audit summary |
| [`receipts/manifest_verification_results.json`](receipts/manifest_verification_results.json) | Manifest verification receipt |
| [`receipts/SHA256SUMS.txt`](receipts/SHA256SUMS.txt) | SHA-256 file manifest |

---

## Release Package

Latest release:

```text
v2.1.2
```

Latest release page:

```text
https://github.com/shawncalvinsnelling/axezent-opac018-green-schur-bridge/releases/tag/v2.1.2
```

Release sequence:

| Release | Purpose |
|---|---|
| `v2.1.0` | External-review root-upload package |
| `v2.1.1` | Repository polish and reviewer navigation |
| `v2.1.2` | Manifest refresh and CI release-integrity restoration |

The original v2.1.0 external-review root-upload archive remains available on the v2.1.0 release page:

```text
https://github.com/shawncalvinsnelling/axezent-opac018-green-schur-bridge/releases/tag/v2.1.0
```

Primary v2.1.0 downloadable archive:

```text
Shawn-Calvin-Snelling-AXEZENT-AI-OPAC018-Green-Schur-Bridge-External-Review-v2.1.0-GITHUB-ROOT-UPLOAD.zip
```

Published v2.1.0 ZIP SHA-256:

```text
dc0c97c04265f9d96eddf4024d2c2a75999d7708d1e9c962ddb1b2c13117f7ef
```

GitHub provides automatic source archives for v2.1.1 and v2.1.2.

---

## Project Governance

This repository includes:

| File | Purpose |
|---|---|
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | Contribution and review guidance |
| [`SECURITY.md`](SECURITY.md) | Security and responsible disclosure policy |
| [`.github/pull_request_template.md`](.github/pull_request_template.md) | Pull request template |
| [`.github/ISSUE_TEMPLATE/mathematical-review.yml`](.github/ISSUE_TEMPLATE/mathematical-review.yml) | Mathematical review issue template |
| [`.github/ISSUE_TEMPLATE/documentation.yml`](.github/ISSUE_TEMPLATE/documentation.yml) | Documentation issue template |
| [`.github/ISSUE_TEMPLATE/reproducibility-bug.yml`](.github/ISSUE_TEMPLATE/reproducibility-bug.yml) | Reproducibility bug issue template |

---

## Citation

Citation metadata is provided in:

```text
CITATION.cff
```

Researchers, reviewers, or downstream users should cite the repository using that metadata.

---

## License

This repository is released under the MIT License.

See:

```text
LICENSE
```

---

## Suggested Public Description

Shawn Calvin Snelling / AXEZENT AI OPAC-018 Green-Schur Bridge is an external-review research package containing a solution-candidate manuscript, exact-arithmetic verification tools, reproducibility receipts, reviewer documentation, worked examples, and supporting software. Independent mathematical review remains pending.

---

## Roadmap

### Current baseline

```text
v2.1.2 — Manifest refresh and CI release-integrity restoration
```

### Next review-focused target

```text
v2.2.0 — Reviewer feedback integration
```

Potential v2.2.0 tasks:

- incorporate independent review feedback,
- strengthen proof explanations,
- add more worked examples,
- expand literature comparison,
- refine theorem dependency documentation.

### Future maintenance target

```text
v2.2.1 — Minor fixes after external review
```

Potential v2.2.1 tasks:

- typo fixes,
- link fixes,
- documentation cleanup,
- receipt refresh if needed.

---

## Final Status Statement

**SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING**

This repository is a structured, reproducible, external-review research package.

The software checks encoded formulas and reproducibility conditions using exact arithmetic.  
The mathematical claims remain subject to independent expert review.

---

© 2026 Shawn Calvin Snelling • AXEZENT AI Research Lab
