# Reviewer Handoff

## Package identity

- Author: Shawn Calvin Snelling
- Research label: AXEZENT AI
- Package: OPAC-018 Green-Schur Bridge
- Version: 2.1.0
- Status: SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING

## Minimum reproducibility command

```bash
python verify_all.py
pytest -q
```

## Full reproducibility command

```bash
python -m compileall -q .
python pure_python_exact_audit.py
python counterexample_stress_test.py
python verify_all.py
pytest -q
python verify_manifest.py
python build_sha_manifest.py --check
```

## Review focus

The most important mathematical focus areas are the gauge identity scope, the signed-graph structural coverage, and the Type B / Type D case split.
