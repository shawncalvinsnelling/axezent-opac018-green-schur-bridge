# Changelog

All notable changes to the Shawn Calvin Snelling / AXEZENT AI OPAC-018 Green-Schur Bridge repository are documented here.

This repository is maintained as a:

**SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING**

Independent mathematical review remains pending.

---

## v2.1.1 — Repository Polish and Reviewer Navigation

Release type:

```text
Maintenance / repository polish
```

### Added

- Added upgraded flagship `README.md` with:
  - GitHub Actions badge,
  - latest release badge,
  - license badge,
  - Python badge,
  - status badge,
  - reviewer quick-start table,
  - clickable documentation links,
  - release ZIP SHA-256 information,
  - truth-boundary section,
  - roadmap.

- Added upgraded `index.html` GitHub Pages landing page with:
  - public project overview,
  - release link,
  - review PDF link,
  - reviewer quick links,
  - verification commands,
  - release ZIP SHA-256,
  - truth-boundary status block.

- Added `CONTRIBUTING.md` with:
  - contribution rules,
  - mathematical review guidance,
  - software verification commands,
  - manifest notes,
  - pull request guidance,
  - issue guidance.

- Added `SECURITY.md` with:
  - responsible disclosure notes,
  - supported version table,
  - security scope,
  - out-of-scope clarification,
  - verification and manifest notes.

- Added GitHub issue templates:
  - `.github/ISSUE_TEMPLATE/mathematical-review.yml`
  - `.github/ISSUE_TEMPLATE/documentation.yml`
  - `.github/ISSUE_TEMPLATE/reproducibility-bug.yml`

- Added pull request template:
  - `.github/pull_request_template.md`

- Added GitHub Pages setup guide:
  - `docs/GITHUB_PAGES_SETUP.md`

- Added release notes:
  - `RELEASE_NOTES_v2.1.1.txt`

### Changed

- Improved public repository presentation.
- Improved reviewer onboarding.
- Improved contribution and issue-reporting workflow.
- Improved GitHub Pages readiness.
- Preserved the external-review truth boundary.

### Not Changed

- No mathematical theorem claim was changed.
- No proof scope was changed.
- No verification formula was changed.
- No journal/referee/arXiv acceptance claim was added.
- No unrelated mathematical problem claim was added.

### Verification

The core GitHub Actions proof-audit workflow remains based on:

```bash
python -m compileall -q .
python pure_python_exact_audit.py
python counterexample_stress_test.py
python verify_all.py
python -m pytest tests/ -q
```

---

## v2.1.0 — External-Review Repository Package

Release type:

```text
External-review package
```

### Added

- Created the flagship OPAC-018 Green-Schur Bridge repository package.
- Added reviewer-facing manuscript materials.
- Added exact rational verification tools.
- Added worked examples.
- Added deterministic receipts.
- Added tests.
- Added GitHub Actions CI.
- Added release package ZIP.
- Added SHA-256 release checksum.
- Added initial documentation structure.

### Status

```text
SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING
```

Independent mathematical review remains required.
