#!/usr/bin/env python3
"""Standalone exact-arithmetic regression audit for AXZ-OPAC-016.

This program checks the closed-form Type-C component formulas and all short-root
case inequalities over a broad exact integer range. It is a reproducibility
layer for OPAC-016; the symbolic proof lives in OPAC016_PROVED_EXACT.md.
"""
from __future__ import annotations

from fractions import Fraction
import json
from pathlib import Path

OUT = Path("receipts/opac016_exact_audit_results.json")


def kappa_balanced_block(b: int) -> Fraction:
    b = int(b)
    if b < 2:
        raise ValueError("balanced block size must be >= 2")
    return max(Fraction(1, 1), Fraction(2, 1) - Fraction(2, b))


def short_root_case_values(b: int, c: int) -> dict[str, Fraction]:
    b = int(b)
    c = int(c)
    if b < 2 or c < 2:
        raise ValueError("balanced block sizes must be >= 2")
    return {
        "full_full": Fraction(1, 1),
        "full_balanced": Fraction(3, 2) - Fraction(1, b),
        "balanced_balanced": Fraction(2, 1) - Fraction(1, b) - Fraction(1, c),
        "same_balanced_compatible": Fraction(1, 1),
        "same_balanced_incompatible": max(Fraction(0, 1), Fraction(2, 1) - Fraction(4, b)),
        "balanced_inactive": Fraction(1, 1) - Fraction(1, b),
        "full_inactive": Fraction(1, 2),
        "inactive_inactive": Fraction(0, 1),
    }


def run(write_receipt: bool = True) -> dict:
    failures = []
    checks = 0

    # C1 edge case: only the full nonzero root-spanned line occurs.
    c1_kappa = Fraction(1, 1)
    checks += 1
    if not c1_kappa < 2:
        failures.append({"case": "C1", "kappa": str(c1_kappa)})

    # Exhaustively audit algebraic case inequalities for many finite block sizes.
    for b in range(2, 513):
        kb = kappa_balanced_block(b)
        checks += 1
        if not kb < 2:
            failures.append({"case": "long_root_margin", "b": b, "kappa": str(kb)})
        for c in range(2, 513):
            bound = max(Fraction(1, 1), kb, kappa_balanced_block(c))
            for name, value in short_root_case_values(b, c).items():
                checks += 1
                if value > bound:
                    failures.append({
                        "case": name,
                        "b": b,
                        "c": c,
                        "value": str(value),
                        "bound": str(bound),
                    })

    # Exact asymptotic-margin stress at large finite block sizes.
    extreme = [2, 3, 4, 5, 10, 100, 1000, 10_000, 10**6, 10**9]
    margins = {}
    for b in extreme:
        k = kappa_balanced_block(b)
        margin = Fraction(2, 1) - k
        checks += 1
        margins[str(b)] = f"{margin.numerator}/{margin.denominator}"
        if margin <= 0:
            failures.append({"case": "extreme_margin", "b": b, "margin": str(margin)})

    payload = {
        "theorem_id": "AXZ-OPAC-016",
        "truth_label": "PROVED_EXACT",
        "scope": "all finite Type-C ranks and nonzero root-spanned subspaces",
        "passed": not failures,
        "checks": checks,
        "failures": failures,
        "extreme_exact_margins": margins,
        "proof_boundary": "This exact audit checks the algebraic cases used by the symbolic proof; it is not a substitute for OPAC016_PROVED_EXACT.md.",
        "global_opac018": "NOT_CLOSED_BY_THIS_RESULT",
    }

    if write_receipt:
        OUT.parent.mkdir(exist_ok=True)
        OUT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return payload


if __name__ == "__main__":
    result = run(write_receipt=True)
    print(json.dumps({"passed": result["passed"], "checks": result["checks"], "failures": result["failures"], "output": str(OUT)}, indent=2))
    raise SystemExit(0 if result["passed"] else 1)
