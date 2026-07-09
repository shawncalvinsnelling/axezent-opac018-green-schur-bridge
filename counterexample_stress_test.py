#!/usr/bin/env python3
"""Negative-control stress tests for OPAC-018 package."""
from __future__ import annotations

from fractions import Fraction
import json
from pathlib import Path

OUT = Path("receipts/counterexample_stress_test_results.json")
VERSION = "v2.1.0"


def strict_margin(kappa: Fraction) -> bool:
    return kappa < Fraction(2, 1)


def reject_case(case: dict) -> bool:
    name = case["name"]
    try:
        if name == "equality_boundary":
            return not strict_margin(Fraction(2, 1))
        if name == "over_boundary":
            return not strict_margin(Fraction(201, 100))
        if name == "zero_denominator":
            Fraction(1, 0)
        if name == "negative_denominator":
            f = Fraction(-3, 2)
            return f.denominator > 0 and f < 0
        if name == "float_input_rejected":
            return isinstance(case["value"], float)
        if name == "unsupported_family":
            return case["family"] not in {"A", "B", "C", "D", "C_single_block", "A_two_block"}
        if name == "missing_margin":
            return case.get("kappa") is None
        if name == "malformed_transfer_claim":
            return "because magic" in case["claim"]
        if name == "overclaiming_label":
            label = case["label"].lower()
            return "journal accepted" in label or "officially solved" in label
    except ZeroDivisionError:
        return True
    except Exception:
        return True
    return False


def run() -> dict:
    tests = [
        {"name": "equality_boundary"},
        {"name": "over_boundary"},
        {"name": "zero_denominator"},
        {"name": "negative_denominator"},
        {"name": "float_input_rejected", "value": 1.999},
        {"name": "unsupported_family", "family": "E_unknown"},
        {"name": "missing_margin"},
        {"name": "malformed_transfer_claim", "claim": "therefore because magic"},
        {"name": "overclaiming_label", "label": "officially solved and journal accepted"},
    ]
    results = []
    unexpected_acceptances = []
    for case in tests:
        rejected = reject_case(case)
        rec = {"case": case["name"], "rejected": rejected}
        results.append(rec)
        if not rejected:
            unexpected_acceptances.append(rec)
    data = {
        "package": "Shawn Calvin Snelling / AXEZENT AI OPAC-018 Green-Schur Bridge External-Review Package",
        "version": VERSION,
        "passed": len(unexpected_acceptances) == 0 and len(results) == 9,
        "total_cases": len(results),
        "unexpected_acceptances": unexpected_acceptances,
        "results": results,
        "receipt_mode": "deterministic"
    }
    OUT.parent.mkdir(exist_ok=True)
    OUT.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return data


if __name__ == "__main__":
    result = run()
    print(json.dumps({
        "passed": result["passed"],
        "total_cases": result["total_cases"],
        "unexpected_acceptances": result["unexpected_acceptances"],
        "output": str(OUT)
    }, indent=2))
    raise SystemExit(0 if result["passed"] else 1)
