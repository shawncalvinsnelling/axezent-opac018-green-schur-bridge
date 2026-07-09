# Start Review Here

Status: **SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING**

This file is a navigation aid for external reviewers.

## 5-minute review

Read:

1. `README.md`
2. `CLAIMS_AND_NONCLAIMS.md`
3. `OPAC018_OPEN_AUDIT_ITEMS.md`

Goal: understand the truth boundary and the remaining external-review status.

## 15-minute review

Read:

1. `DEPENDENCY_TABLE.md`
2. `docs/FORMAL_ASSUMPTIONS.md`
3. `docs/DEPENDENCY_GRAPH.md`
4. `docs/LITERATURE_COMPARISON.md`

Goal: inspect the formal assumptions and the claimed dependency chain.

## 1-hour review

Read:

1. `paper/main.tex`
2. `examples/example_A5.md`
3. `examples/example_C6.md`
4. `examples/example_D5.md`
5. `docs/PROOF_RISK_LEDGER.md`
6. `docs/KNOWN_FAILURE_MODES.md`

Then run:

```bash
python verify_all.py
pytest -q
```

Goal: compare the hand calculations, manuscript formulas, and executable checks.

## Full review

Run the complete reproducibility suite:

```bash
python -m compileall -q .
python pure_python_exact_audit.py
python counterexample_stress_test.py
python verify_all.py
pytest -q
python verify_manifest.py
python build_sha_manifest.py --check
```

Then audit the mathematical bridge manually against the assumptions in `docs/FORMAL_ASSUMPTIONS.md` and the open items in `OPAC018_OPEN_AUDIT_ITEMS.md`.
