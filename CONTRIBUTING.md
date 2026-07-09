# Contributing to AXEZENT AI OPAC-018 Green-Schur Bridge

Thank you for considering a contribution to the Shawn Calvin Snelling / AXEZENT AI OPAC-018 Green-Schur Bridge external-review research package.

This repository is maintained as a **solution-candidate / external-review pending** research package. Contributions are welcome when they improve clarity, reproducibility, proof review, documentation, tests, or software reliability.

---

## Truth Boundary

**SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING**

This repository does not claim journal acceptance, referee acceptance, arXiv endorsement, or completed independent mathematical verification.

Contributions should preserve this status language unless the repository owner intentionally changes the project stage after external review.

---

## Good Contribution Types

Helpful contributions include:

- correcting typos,
- improving documentation,
- adding citations or literature context,
- clarifying proof dependencies,
- improving worked examples,
- adding tests,
- reporting reproducibility problems,
- improving GitHub Actions,
- identifying unclear assumptions,
- opening review questions as GitHub Issues.

---

## Mathematical Review Contributions

For mathematical comments, please try to include:

1. The file or theorem being discussed.
2. The exact line, definition, lemma, or equation if possible.
3. Whether the concern is about:
   - notation,
   - proof completeness,
   - assumptions,
   - literature comparison,
   - counterexamples,
   - missing cases,
   - computational verification,
   - or exposition.
4. A suggested fix or reference, when available.

---

## Software Contributions

Before submitting software changes, run:

```bash
python -m compileall -q .
python pure_python_exact_audit.py
python counterexample_stress_test.py
python verify_all.py
python -m pytest tests/ -q
```

The current GitHub Actions workflow uses these same core checks.

---

## Manifest and SHA-256 Notes

The repository includes manifest and SHA-256 tools:

```bash
python verify_manifest.py
python build_sha_manifest.py --check
```

During the initial GitHub upload and CI setup, manifest verification was kept out of the blocking CI path while repository files were being finalized.

Before a maintenance release, the manifest and SHA-256 receipts should be regenerated so release-integrity checks match the current repository state.

---

## Pull Request Guidelines

A good pull request should:

- explain the purpose of the change,
- avoid mixing unrelated edits,
- preserve the truth-boundary language,
- update tests when code changes,
- update documentation when behavior changes,
- avoid claiming final theorem acceptance without independent review.

Recommended pull request title examples:

```text
docs: clarify Type C worked example
tests: add boundary case for malformed block input
paper: improve notation in projection lemma
ci: update proof-audit workflow
```

---

## Issue Guidelines

Good issue titles:

```text
Question: clarify gauge identity assumption in Type A section
Bug: verify_manifest.py reports outdated hash after workflow update
Docs: add citation for signed-graph decomposition
Example: add small Type B worked calculation
```

---

## What Not To Submit

Please avoid contributions that:

- claim unrelated major problems are solved,
- remove the external-review pending status without justification,
- add floating-point-only verification for exact arithmetic checks,
- make broad mathematical claims without proof or citation,
- replace reproducible checks with non-deterministic outputs,
- mix large manuscript rewrites with unrelated code changes.

---

## Review Style

This repository is intended to support serious mathematical and software review.

Preferred review style:

- precise,
- respectful,
- evidence-based,
- reproducible,
- citation-aware,
- and clear about what is proved, what is checked, and what remains open.

---

## Maintainer

Project author and maintainer:

```text
Shawn Calvin Snelling
AXEZENT AI Research Lab
```

---

Thank you for helping improve the OPAC-018 Green-Schur Bridge external-review package.
