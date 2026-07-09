
#!/usr/bin/env python3
"""Verify SHA-256 manifest.

The verification result file is intentionally excluded from the manifest so
this script can be run repeatedly in CI without creating a self-changing hash.
"""
from __future__ import annotations
from pathlib import Path
import hashlib
import json

MANIFEST = Path("receipts/SHA256SUMS.txt")
OUT = Path("receipts/manifest_verification_results.json")

def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()

def run() -> dict:
    missing = []
    mismatches = []
    checked = 0
    if not MANIFEST.exists():
        data = {"passed": False, "error": "manifest missing", "checked": 0, "missing": [str(MANIFEST)], "mismatches": []}
    else:
        for raw in MANIFEST.read_text(encoding="utf-8").splitlines():
            line = raw.strip()
            if not line or line.startswith("#"):
                continue
            expected, rel = line.split("  ", 1)
            p = Path(rel)
            if not p.exists():
                missing.append(rel)
                continue
            got = sha256(p)
            checked += 1
            if got != expected:
                mismatches.append({"file": rel, "expected": expected, "got": got})
        data = {
            "package": "OPAC-018 Green-Schur Bridge Referee Package",
            "version": "v2.1.0",
            "passed": not missing and not mismatches and checked > 0,
            "checked": checked,
            "missing": missing,
            "mismatches": mismatches,
            "receipt_mode": "deterministic-excluded-from-manifest"
        }
    OUT.parent.mkdir(exist_ok=True)
    OUT.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return data

if __name__ == "__main__":
    result = run()
    print(json.dumps({
        "passed": result.get("passed"),
        "checked": result.get("checked"),
        "missing": result.get("missing"),
        "mismatches": result.get("mismatches"),
        "output": str(OUT)
    }, indent=2))
    raise SystemExit(0 if result.get("passed") else 1)
