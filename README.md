# Shawn Calvin Snelling — AXEZENT AI OPAC-018 Green-Schur Bridge

> **External-Review Research Package • Version 2.1.0**

**Author:** Shawn Calvin Snelling  
**Research Lab:** AXEZENT AI Research Lab

---

## Project Status

**Current Status**

- Solution Candidate
- External Review Pending
- Continuous Integration Enabled
- Exact Rational Verification Included

This repository contains the complete external-review package for the OPAC-018 Green-Schur Bridge research project.

The project combines:

- Mathematical manuscript
- Exact arithmetic verification
- Worked examples
- Reproducibility receipts
- Automated testing
- GitHub Actions continuous integration
- Reviewer documentation

---

# Research Scope

This repository investigates the root-polytope projection bound

```
κ(Φ,U) < 2
```

using:

- Green-Schur techniques
- Exact rational arithmetic
- Classification-aware reductions
- Deterministic verification
- Reproducibility-first engineering

---

# Repository Purpose

This repository is intended for:

- Independent mathematical review
- Verification of encoded formulas
- Reproducibility
- Documentation
- Long-term archival
- Research collaboration

---

# Truth Boundary

This repository presents a **solution candidate**.

It does **not** claim:

- Journal acceptance
- Referee acceptance
- arXiv endorsement
- Resolution of unrelated mathematical problems
- Independent verification has already occurred

Independent mathematical review remains an essential next step.

---

# Quick Start

## Fast reviewer path

Read these files first:

```
START_REVIEW_HERE.md
```

---

## Complete reviewer path

```
START_HERE.md

CLAIMS_AND_NONCLAIMS.md

DEPENDENCY_TABLE.md

docs/LITERATURE_COMPARISON.md

examples/example_A5.md

examples/example_C6.md

examples/example_D5.md

paper/main.tex
```

---

# Running the Verification Suite

```bash
python -m compileall -q .

python pure_python_exact_audit.py

python counterexample_stress_test.py

python verify_all.py

python -m pytest tests/ -q
```

---

# Repository Structure

| Folder | Purpose |
|---------|----------|
| assets | Figures and diagrams |
| csl | Exact rational verification engine |
| docs | Reviewer documentation |
| examples | Hand-worked examples |
| paper | Manuscript and PDF |
| receipts | Verification receipts |
| sage | SageMath verification |
| tests | Automated regression tests |

---

# Core Programs

| File | Purpose |
|------|----------|
| verify_all.py | Master verification runner |
| pure_python_exact_audit.py | Exact arithmetic audit |
| counterexample_stress_test.py | Negative-control verification |
| csl/opac_engine.py | Projection verification engine |

---

# Release Information

Current Release:

**v2.1.0**

Release Type:

**External Review Package**

---

# Citation

Please see

```
CITATION.cff
```

for citation information.

---

# License

This project is released under the MIT License.

See

```
LICENSE
```

---

# Repository Highlights

- Exact Rational Arithmetic
- Continuous Integration
- Deterministic Verification
- Worked Mathematical Examples
- Reproducibility Receipts
- Reviewer Navigation
- External Review Package
- Versioned Releases

---

# Safe Public Description

Shawn Calvin Snelling / AXEZENT AI OPAC-018 Green-Schur Bridge is an external-review research package containing a solution-candidate manuscript, exact-arithmetic verification tools, reproducibility receipts, reviewer documentation, and supporting software. Independent mathematical review remains pending.

---

© 2026 Shawn Calvin Snelling • AXEZENT AI Research Lab
