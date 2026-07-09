# Pull Request

## Summary

Describe the purpose of this change.

---

## Change Type

Check all that apply:

- [ ] Documentation update
- [ ] Manuscript / proof clarification
- [ ] Example update
- [ ] Test update
- [ ] Verification code update
- [ ] GitHub Actions / CI update
- [ ] Release / manifest / receipt update
- [ ] Other

---

## Truth Boundary

This repository is marked:

**SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING**

Confirm:

- [ ] This PR preserves the repository truth-boundary language.
- [ ] This PR does not claim journal acceptance, referee acceptance, arXiv endorsement, or completed independent mathematical verification.
- [ ] This PR does not add unrelated mathematical problem claims.

---

## Verification

If code, tests, receipts, or workflow behavior changed, run the relevant checks:

```bash
python -m compileall -q .
python pure_python_exact_audit.py
python counterexample_stress_test.py
python verify_all.py
python -m pytest tests/ -q
