from fractions import Fraction

import opac016_exact_audit as opac016


def test_opac016_exact_audit_passes():
    result = opac016.run(write_receipt=False)
    assert result["passed"] is True
    assert result["failures"] == []
    assert result["truth_label"] == "PROVED_EXACT"
    assert result["global_opac018"] == "NOT_CLOSED_BY_THIS_RESULT"


def test_opac016_known_values():
    assert opac016.kappa_balanced_block(2) == Fraction(1, 1)
    assert opac016.kappa_balanced_block(3) == Fraction(4, 3)
    assert opac016.kappa_balanced_block(4) == Fraction(3, 2)
    assert opac016.kappa_balanced_block(5) == Fraction(8, 5)
    assert opac016.kappa_balanced_block(10**9) < Fraction(2, 1)


def test_short_root_cases_never_exceed_long_root_envelope():
    for b in range(2, 33):
        for c in range(2, 33):
            bound = max(Fraction(1, 1), opac016.kappa_balanced_block(b), opac016.kappa_balanced_block(c))
            for value in opac016.short_root_case_values(b, c).values():
                assert value <= bound
