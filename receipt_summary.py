#!/usr/bin/env python3
"""Print compact receipt summary."""
from pathlib import Path
import json

for p in sorted(Path("receipts").glob("*.json")):
    try:
        data = json.loads(p.read_text(encoding="utf-8"))
    except Exception as e:
        print(p, "unreadable", e)
        continue
    print(p.name, {"passed": data.get("passed"), "version": data.get("version"), "checked": data.get("checked"), "total_types": data.get("total_types"), "total_cases": data.get("total_cases")})
