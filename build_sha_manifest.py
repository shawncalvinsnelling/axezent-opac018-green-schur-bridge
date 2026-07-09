
#!/usr/bin/env python3
"""Build or check SHA-256 manifest."""
from __future__ import annotations
import hashlib
from pathlib import Path
import argparse

ROOT = Path(".")
MANIFEST = Path("receipts/SHA256SUMS.txt")
EXCLUDE_DIRS = {".git", "__pycache__", ".pytest_cache"}
EXCLUDE_FILES = {
    str(MANIFEST).replace("\\", "/"),
    "receipts/manifest_verification_results.json",
}

def iter_files():
    for p in sorted(ROOT.rglob("*")):
        if not p.is_file():
            continue
        rel = p.relative_to(ROOT).as_posix()
        if any(part in EXCLUDE_DIRS for part in p.parts):
            continue
        if rel in EXCLUDE_FILES:
            continue
        if rel.endswith(".pyc"):
            continue
        yield rel, p

def digest(p: Path) -> str:
    return hashlib.sha256(p.read_bytes()).hexdigest()

def build_text() -> str:
    lines = ["# SHA-256 manifest for OPAC-018 Green-Schur Bridge v2.1.0"]
    for rel, p in iter_files():
        lines.append(f"{digest(p)}  {rel}")
    return "\n".join(lines) + "\n"

def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args()
    text = build_text()
    if args.check:
        if not MANIFEST.exists():
            print("missing manifest:", MANIFEST)
            return 1
        current = MANIFEST.read_text(encoding="utf-8")
        if current != text:
            print("manifest mismatch; run python build_sha_manifest.py")
            return 1
        print("manifest check passed")
        return 0
    MANIFEST.parent.mkdir(exist_ok=True)
    MANIFEST.write_text(text, encoding="utf-8")
    print(f"wrote {MANIFEST}")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
