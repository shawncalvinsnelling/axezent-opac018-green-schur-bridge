"""Fail-closed regressions for the Cellini–Marietti source interface.

These tests do not prove Proposition 7.4.  They prevent two convention errors
that would silently change the theorem being formalized:

1. swapping the nonsimply-laced Cartan coefficients p and q;
2. dividing every extremal inverse-row entry by the pivot mark instead of the
   extremal node's own mark m_eta from o_eta = check(omega)_eta / m_eta.
"""

from fractions import Fraction


def test_p_q_orientation_is_not_symmetric_in_b2_c2() -> None:
    # Frozen convention C_{ij} = (alpha_i, alpha_j^vee).
    b2 = ((2, -2), (-1, 2))
    c2 = ((2, -1), (-2, 2))

    # Delete alpha_0.  Proposition 7.4 uses
    # p_epsilon = -C_{alpha,epsilon}; the Schur column uses
    # q_epsilon = -C_{epsilon,alpha}.
    p_b2, q_b2 = -b2[0][1], -b2[1][0]
    p_c2, q_c2 = -c2[0][1], -c2[1][0]

    assert (p_b2, q_b2) == (2, 1)
    assert (p_c2, q_c2) == (1, 2)
    assert p_b2 != q_b2
    assert p_c2 != q_c2


def test_extremal_denominator_is_eta_mark_not_pivot_mark() -> None:
    # Synthetic exact data chosen only to make the convention error visible.
    # The source definition is o_eta = check(omega)_eta / m_eta, so each
    # inverse-row entry carries its own extremal-node mark in the denominator.
    inverse_row = (Fraction(6), Fraction(4))
    marks = (Fraction(2), Fraction(1))
    pivot = 0

    correct = max(inverse_row[j] / marks[j] for j in range(2))
    wrong_pivot_denominator = max(
        inverse_row[j] / marks[pivot] for j in range(2)
    )

    assert correct == Fraction(4)
    assert wrong_pivot_denominator == Fraction(3)
    assert correct != wrong_pivot_denominator
