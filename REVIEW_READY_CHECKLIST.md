# Review-Ready Checklist

Before sending the repository to reviewers, confirm:

- [ ] GitHub Actions latest run is green.
- [ ] `python -m compileall -q .` passes.
- [ ] `python pure_python_exact_audit.py` passes.
- [ ] `python counterexample_stress_test.py` passes.
- [ ] `python verify_all.py` passes.
- [ ] `pytest -q` passes.
- [ ] `python verify_manifest.py` passes.
- [ ] `python build_sha_manifest.py --check` passes.
- [ ] `START_REVIEW_HERE.md` points reviewers to the correct files.
- [ ] README says `SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING`.
- [ ] No file says `officially solved`, `journal accepted`, or equivalent overclaiming language.
- [ ] Release ZIP contains `examples/`, `tests/`, `docs/`, `paper/`, and `receipts/`.
- [ ] Release tag created only after checks pass.
