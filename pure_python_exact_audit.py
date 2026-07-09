#!/usr/bin/env python3
"""Exact arithmetic audit for OPAC-018 Green-Schur Bridge package.

This script intentionally uses Fraction / integer cross-products only. It does
not prove OPAC-018 by itself; it audits the finite documented formulas and
conservative envelopes encoded in the repository and emits a deterministic
reproducibility receipt.
"""
from __future__ import annotations

from fractions import Fraction
import json
from pathlib import Path

from csl.opac_engine import (
    lt_rational,
    kappa_type_a_two_block,
    kappa_type_c_single_block,
    verify_classical_opac_bounds,
)

OUT = Path("receipts/opac18_green_schur_pure_python_results.json")
VERSION = "v2.1.0"


def run() -> dict:
    cases = []
    failures = []

    for b1 in range(2, 18):
        k = kappa_type_c_single_block(b1)
        ok = lt_rational(k, Fraction(2, 1))
        rec = {"family": "C_single_block", "b1": b1, "kappa": f"{k.numerator}/{k.denominator}", "strict_lt_2": ok}
        cases.append(rec)
        if not ok:
            failures.append(rec)

    pairs = [(2,2),(2,3),(2,4),(2,5),(3,3),(3,4),(3,5),(3,6),
             (4,4),(4,5),(4,6),(5,5),(5,6),(6,6),(7,8),(9,10)]
    for b1, b2 in pairs:
        k = kappa_type_a_two_block(b1, b2)
        ok = lt_rational(k, Fraction(2, 1))
        rec = {"family": "A_two_block", "b1": b1, "b2": b2, "kappa": f"{k.numerator}/{k.denominator}", "strict_lt_2": ok}
        cases.append(rec)
        if not ok:
            failures.append(rec)

    envelope_cases = [
        ("A", [3, 3], 5),
        ("A", [4], 5),
        ("B", [4], 4),
        ("C", [4], 6),
        ("D", [4], 5),
        ("E6", [3], 6),
    ]
    envelope_results = [verify_classical_opac_bounds(fam, blocks, rank) for fam, blocks, rank in envelope_cases]
    for rec in envelope_results:
        if rec["status"] == "FAIL":
            failures.append(rec)

    data = {
        "package": "Shawn Calvin Snelling / AXEZENT AI OPAC-018 Green-Schur Bridge External-Review Package",
        "version": VERSION,
        "truth_label": "SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING",
        "passed": len(failures) == 0 and len(cases) == 32,
        "total_formula_cases": len(cases),
        "total_envelope_cases": len(envelope_results),
        "failures": failures,
        "cases": cases,
        "envelope_results": envelope_results,
        "arithmetic": "Fraction and integer cross-product only; no proof-critical floats",
        "receipt_mode": "deterministic",
        "software_boundary": "Checks encoded formulas/envelopes; does not replace independent mathematical proof review."
    }
    OUT.parent.mkdir(exist_ok=True)
    OUT.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return data


if __name__ == "__main__":
    result = run()
    print(json.dumps({
        "passed": result["passed"],
        "total_formula_cases": result["total_formula_cases"],
        "total_envelope_cases": result["total_envelope_cases"],
        "failures": result["failures"],
        "output": str(OUT)
    }, indent=2))
    raise SystemExit(0 if result["passed"] else 1)
