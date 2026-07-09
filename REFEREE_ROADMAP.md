# Referee Roadmap

## Stage 1 - Reproducibility

Run:

```bash
python -m compileall -q .
python pure_python_exact_audit.py
python counterexample_stress_test.py
python verify_all.py
pytest -q
python verify_manifest.py
python build_sha_manifest.py --check
```

## Stage 2 - Mathematical boundary

Check:

- whether the projection formulas are stated with the correct hypotheses;
- whether the gauge identities apply in each component where they are used;
- whether non-simply-laced metric normalizations are handled correctly;
- whether the signed-graph component split is exhaustive for the stated scope.

## Stage 3 - Worked examples

Read:

- `examples/example_A5.md`
- `examples/example_C6.md`
- `examples/example_D5.md`

Each example is designed to be checked by hand before inspecting the code.

## Stage 4 - Open audit items

Read `OPAC018_OPEN_AUDIT_ITEMS.md`. These questions are included as reviewer prompts, not hidden assumptions.

## Stage 5 - Visual package

Open `index.html` and inspect the SVG diagrams in `assets/`.
