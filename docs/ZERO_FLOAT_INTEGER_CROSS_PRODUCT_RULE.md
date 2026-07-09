# Zero-Float Integer Cross-Product Rule

All core audit comparisons are performed over integers or rational numbers.

For rational inequalities:

```text
a/b < c/d
```

the verifier checks:

```text
a*d < c*b
```

with positive denominators. No floating-point comparison is used for proof-critical checks.
