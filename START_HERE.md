# START HERE

Recommended review order:

1. `README.md`
2. `START_REVIEW_HERE.md`
3. `CLAIMS_AND_NONCLAIMS.md`
4. `DEPENDENCY_TABLE.md`
5. `docs/FORMAL_ASSUMPTIONS.md`
6. `docs/LITERATURE_COMPARISON.md`
7. `examples/example_A5.md`
8. `examples/example_C6.md`
9. `examples/example_D5.md`
10. `paper/main.tex`
11. `docs/PROOF_RISK_LEDGER.md`
12. `OPAC018_OPEN_AUDIT_ITEMS.md`

Then run:

```bash
python -m compileall -q .
python pure_python_exact_audit.py
python counterexample_stress_test.py
python verify_all.py
pytest -q
python verify_manifest.py
python build_sha_manifest.py --check
```

The scripts are deterministic and use exact integer/rational arithmetic for proof-critical comparisons.
