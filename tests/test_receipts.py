import json
import subprocess
import sys
from pathlib import Path


def run_script(script: str):
    return subprocess.run([sys.executable, script], text=True, capture_output=True, check=True)


def test_pure_python_audit_receipt_is_written():
    run_script("pure_python_exact_audit.py")
    data = json.loads(Path("receipts/opac18_green_schur_pure_python_results.json").read_text())
    assert data["passed"] is True
    assert data["truth_label"] == "SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING"
    assert data["total_formula_cases"] == 32


def test_counterexample_receipt_is_written():
    run_script("counterexample_stress_test.py")
    data = json.loads(Path("receipts/counterexample_stress_test_results.json").read_text())
    assert data["passed"] is True
    assert data["total_cases"] == 9
    assert data["unexpected_acceptances"] == []


def test_verify_all_receipt_is_written():
    run_script("verify_all.py")
    data = json.loads(Path("receipts/global_audit_summary.json").read_text())
    assert data["passed"] is True
    assert data["truth_label"] == "SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING"
    assert "deterministic_integrity_token" in data
