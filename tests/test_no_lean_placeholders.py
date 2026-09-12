"""Fail closed if active Lean source contains proof placeholders or local axioms."""

from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PLACEHOLDER = re.compile(r"(^|[^A-Za-z])(sorry|admit)([^A-Za-z]|$)")
LOCAL_AXIOM = re.compile(r"^\s*axiom\s+", re.MULTILINE)
BLOCK_COMMENT = re.compile(r"/-.*?-/", re.DOTALL)
LINE_COMMENT = re.compile(r"--.*$")


def active_lean_source(text: str) -> str:
    """Remove ordinary Lean comments before lexical release checks.

    Lean itself remains the authority on syntax and proof checking.  The project
    sources under audit do not use nested block comments, so this deliberately
    small scanner is sufficient as an independent fail-closed release guard.
    """
    text = BLOCK_COMMENT.sub("", text)
    return "\n".join(LINE_COMMENT.sub("", line) for line in text.splitlines())


def test_all_lean_sources_are_placeholder_free() -> None:
    offenders: list[str] = []
    for path in sorted(ROOT.rglob("*.lean")):
        text = active_lean_source(path.read_text(encoding="utf-8"))
        for lineno, line in enumerate(text.splitlines(), start=1):
            if PLACEHOLDER.search(line):
                offenders.append(f"{path.relative_to(ROOT)}:{lineno}: {line.strip()}")
    assert not offenders, "Lean proof placeholders found:\n" + "\n".join(offenders)


def test_no_project_local_axiom_declarations() -> None:
    """Reject project-authored `axiom` declarations after comment stripping.

    Mathlib/Lean may rely on standard kernel axioms such as classical choice,
    quotient soundness, and propositional extensionality.  This check has the
    narrower and auditable purpose of ensuring this repository does not hide a
    new theorem assumption behind a local `axiom` declaration.
    """
    offenders: list[str] = []
    for path in sorted(ROOT.rglob("*.lean")):
        text = active_lean_source(path.read_text(encoding="utf-8"))
        for match in LOCAL_AXIOM.finditer(text):
            lineno = text.count("\n", 0, match.start()) + 1
            line = text.splitlines()[lineno - 1].strip()
            offenders.append(f"{path.relative_to(ROOT)}:{lineno}: {line}")
    assert not offenders, "Project-local Lean axiom declarations found:\n" + "\n".join(offenders)
