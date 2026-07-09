#!/usr/bin/env python3
"""Master local audit runner for the AXEZENT AI OPAC-018 package.

This runner intentionally avoids time-dependent receipts and shell recursion so
it can be used both in CI and inside pytest.
"""
from __future__ import annotations

import hashlib
import json
from pathlib import Path

import counterexample_stress_test
import pure_python_exact_audit
from csl.opac_engine import verify_classical_opac_bounds

VERSION = "v2.1.0"
OUT = Path("receipts/global_audit_summary.json")


def run() -> dict:
    exact_audit = pure_python_exact_audit.run()
    stress_audit = counterexample_stress_test.run()

    formula_checks = [
        verify_classical_opac_bounds("A", [3, 3], 5),
        verify_classical_opac_bounds("A", [4], 5),
        verify_classical_opac_bounds("B", [4], 4),
        verify_classical_opac_bounds("C", [4], 6),
        verify_classical_opac_bounds("D", [4], 5),
        verify_classical_opac_bounds("E6", [4], 6),
    ]
    failed_formula_checks = [r for r in formula_checks if r["status"] == "FAIL"]

    payload = {
        "package": "Shawn Calvin Snelling / AXEZENT AI OPAC-018 Green-Schur Bridge External-Review Package",
        "version": VERSION,
        "truth_label": "SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING",
        "passed": bool(exact_audit.get("passed")) and bool(stress_audit.get("passed")) and not failed_formula_checks,
        "exact_audit_passed": bool(exact_audit.get("passed")),
        "stress_audit_passed": bool(stress_audit.get("passed")),
        "formula_checks": formula_checks,
        "failed_formula_checks": failed_formula_checks,
        "software_boundary": "Consistency and exact-arithmetic checks only; independent mathematical review remains required.",
    }
    serial = json.dumps(payload, sort_keys=True)
    payload["deterministic_integrity_token"] = hashlib.sha256(serial.encode("utf-8")).hexdigest()
    OUT.parent.mkdir(exist_ok=True)
    OUT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return payload


def main() -> int:
    payload = run()
    print(json.dumps({
        "passed": payload["passed"],
        "version": VERSION,
        "failed_formula_checks": len(payload["failed_formula_checks"]),
        "output": str(OUT),
        "deterministic_integrity_token": payload["deterministic_integrity_token"],
    }, indent=2))
    return 0 if payload["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
