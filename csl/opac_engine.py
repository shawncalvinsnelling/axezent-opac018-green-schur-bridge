#!/usr/bin/env python3
"""Exact rational audit helpers for OPAC-018 review package.

The functions in this module evaluate the formulas and conservative envelopes
encoded in the repository. They intentionally avoid proof-critical floats.
Passing these checks means the encoded formulas satisfy the encoded rational
bound for the supplied inputs; it does not replace independent mathematical
review of the reductions leading to those formulas.
"""
from __future__ import annotations

from fractions import Fraction
from typing import Iterable, List, Dict, Any

SUPPORTED_CLASSICAL = {"A", "B", "C", "D"}


def _clean_blocks(active_blocks: Iterable[int]) -> List[int]:
    """Return descending active block sizes, keeping only sizes >= 2."""
    return sorted([int(b) for b in active_blocks if int(b) >= 2], reverse=True)


def lt_rational(a: Fraction, b: Fraction) -> bool:
    """Compare positive-denominator fractions by integer cross-product."""
    if a.denominator <= 0 or b.denominator <= 0:
        raise ValueError("Fractions must have positive denominators")
    return a.numerator * b.denominator < b.numerator * a.denominator


def kappa_type_a_two_block(b1: int, b2: int) -> Fraction:
    """Type A two-block formula: 2 - 1/b1 - 1/b2."""
    b1 = int(b1)
    b2 = int(b2)
    if b1 < 2 or b2 < 2:
        raise ValueError("Type A active block sizes must be at least 2")
    return Fraction(2, 1) - Fraction(1, b1) - Fraction(1, b2)


def kappa_type_c_single_block(b1: int) -> Fraction:
    """Type C single-block envelope: max(1, 2 - 2/b1)."""
    b1 = int(b1)
    if b1 < 2:
        raise ValueError("Type C active block size must be at least 2")
    return max(Fraction(1, 1), Fraction(2, 1) - Fraction(2, b1))


def verify_classical_opac_bounds(family: str, active_blocks: Iterable[int], rank_n: int) -> Dict[str, Any]:
    """Evaluate an encoded classical-family formula/envelope over Q.

    Parameters
    ----------
    family:
        One of A, B, C, D. Exceptional labels return UNKNOWN.
    active_blocks:
        Iterable of active block sizes. Values below 2 are ignored as inactive
        for this finite-block audit layer.
    rank_n:
        Finite rank parameter. Used for scope validation and reporting.
    """
    try:
        rank_n = int(rank_n)
    except Exception:
        return {"status": "FAIL", "truth_label": "INVALID_RANK", "reason": "Rank n must be an integer."}

    if rank_n < 2:
        return {"status": "FAIL", "truth_label": "INVALID_RANK", "reason": "Rank n must be >= 2."}

    family_upper = str(family).upper().strip()
    blocks = _clean_blocks(active_blocks)
    m = len(blocks)

    if family_upper not in SUPPORTED_CLASSICAL:
        return {
            "status": "UNKNOWN",
            "truth_label": "UNSUPPORTED_FAMILY_REVIEW_REQUIRED",
            "reason": f"Family {family} is outside the encoded classical audit scope.",
            "components_audited": blocks,
        }

    if family_upper == "A":
        formula = "A_two_block" if m >= 2 else "A_identity_or_single_component"
        kappa = Fraction(1, 1) if m <= 1 else kappa_type_a_two_block(blocks[0], blocks[1])
    else:
        formula = f"{family_upper}_single_block_envelope"
        kappa = Fraction(1, 1) if m == 0 else kappa_type_c_single_block(blocks[0])

    strict = lt_rational(kappa, Fraction(2, 1))
    margin = Fraction(2, 1) - kappa

    return {
        "family": f"Type-{family_upper}_{rank_n}",
        "status": "PASS" if strict else "FAIL",
        "truth_label": "BOUND_VERIFIED_FOR_ENCODED_INPUT" if strict else "BOUND_FAILED_FOR_ENCODED_INPUT",
        "formula_mode": formula,
        "kappa_rational": f"{kappa.numerator}/{kappa.denominator}",
        "margin_to_2_rational": f"{margin.numerator}/{margin.denominator}",
        "kappa_float_for_display_only": float(kappa),
        "strict_opac018_bound_passed": strict,
        "components_audited": blocks,
        "software_boundary": "Checks encoded formulas/envelopes; does not replace independent mathematical proof review.",
    }
