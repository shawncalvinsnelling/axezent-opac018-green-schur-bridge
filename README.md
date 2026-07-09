# Shawn Calvin Snelling - AXEZENT AI OPAC-018 Green-Schur Bridge

**External-review package v2.1.0**

Author: Shawn Calvin Snelling  
Research label: AXEZENT AI Research Lab  
Status: **SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING**

This repository is a reviewer-facing OPAC-018 research package. It studies the root-polytope projection bound

```text
kappa(Phi, U) < 2
```

through exact rational audits, documented block formulas, negative controls, reproducibility receipts, and reviewer-facing mathematical risk notes.

## What this package is

This is a **manuscript and consistency-check suite** prepared for external mathematical review. The code checks the formulas and bounds that are encoded in the repository using exact arithmetic. The package is designed to make the proof structure, assumptions, and remaining audit questions visible to reviewers.

## What this package is not

This package is not a substitute for independent peer review. It does not claim journal acceptance, referee acceptance, arXiv endorsement, or resolution of unrelated mathematical problems.

## Start here

For a fast review path, open:

```text
START_REVIEW_HERE.md
```

For the complete reviewer path, read:

```text
START_HERE.md
CLAIMS_AND_NONCLAIMS.md
DEPENDENCY_TABLE.md
docs/LITERATURE_COMPARISON.md
examples/example_A5.md
examples/example_C6.md
examples/example_D5.md
paper/main.tex
```

## Run locally

```bash
python -m compileall -q .
python pure_python_exact_audit.py
python counterexample_stress_test.py
python verify_all.py
pytest -q
python verify_manifest.py
python build_sha_manifest.py --check
```

Expected high-level status:

```json
{"passed": true, "failures": []}
```

## Core files

| File or folder | Purpose |
|---|---|
| `csl/opac_engine.py` | Exact rational formula and envelope checker. |
| `pure_python_exact_audit.py` | Deterministic formula audit receipt generator. |
| `counterexample_stress_test.py` | Negative-control and malformed-claim rejection checks. |
| `verify_all.py` | Master local orchestration runner. |
| `tests/` | Pytest regression tests for formulas, receipts, examples, and boundaries. |
| `examples/` | Hand-checkable Type A, Type C, and Type D examples. |
| `docs/` | Review notes, dependency map, literature comparison, and risk ledger. |
| `paper/` | Manuscript source and review PDF. |
| `receipts/` | Deterministic JSON receipts and SHA-256 manifest. |

## Safe public wording

> Shawn Calvin Snelling / AXEZENT AI OPAC-018 Green-Schur Bridge v2.1.0 is an external-review research package containing a solution-candidate manuscript, exact-arithmetic consistency checks, negative controls, reproducibility receipts, and reviewer navigation materials. Independent mathematical review remains pending.
