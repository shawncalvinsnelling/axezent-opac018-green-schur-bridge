# Release Build Report v2.1.0

Package: Shawn Calvin Snelling / AXEZENT AI OPAC-018 Green-Schur Bridge  
Release type: GitHub root-upload ZIP  
Status: SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING

## Local validation performed

```bash
python -m compileall -q .
python pure_python_exact_audit.py
python counterexample_stress_test.py
python verify_all.py
PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 python -m pytest tests/ -q
python build_sha_manifest.py
python verify_manifest.py
python build_sha_manifest.py --check
```

Observed results:

- Exact arithmetic audit: passed.
- Counterexample stress test: passed.
- Master audit runner: passed.
- Pytest suite: 12 passed.
- Manifest verification: passed.
- v2.1.0 review PDF rendered successfully for visual inspection.

## Release posture

This is a research manuscript and executable consistency-check suite prepared for independent expert review. It does not claim independent journal acceptance.
