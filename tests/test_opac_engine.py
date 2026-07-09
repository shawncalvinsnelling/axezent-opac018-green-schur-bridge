from fractions import Fraction

from csl.opac_engine import (
    kappa_type_a_two_block,
    kappa_type_c_single_block,
    verify_classical_opac_bounds,
)


def test_type_a_benchmark_3_3():
    assert kappa_type_a_two_block(3, 3) == Fraction(4, 3)
    result = verify_classical_opac_bounds("A", [3, 3], 5)
    assert result["status"] == "PASS"
    assert result["kappa_rational"] == "4/3"
    assert result["strict_opac018_bound_passed"] is True


def test_type_c_benchmark_4():
    assert kappa_type_c_single_block(4) == Fraction(3, 2)
    result = verify_classical_opac_bounds("C", [4], 6)
    assert result["status"] == "PASS"
    assert result["kappa_rational"] == "3/2"


def test_type_b_and_d_encoded_envelope():
    assert verify_classical_opac_bounds("B", [4], 4)["kappa_rational"] == "3/2"
    assert verify_classical_opac_bounds("D", [4], 5)["kappa_rational"] == "3/2"


def test_unsupported_exceptional_family_is_not_passed():
    result = verify_classical_opac_bounds("E6", [4], 6)
    assert result["status"] == "UNKNOWN"
    assert result["truth_label"] == "UNSUPPORTED_FAMILY_REVIEW_REQUIRED"
