import pytest

from csl.opac_engine import kappa_type_a_two_block, kappa_type_c_single_block


def test_bad_block_sizes_rejected():
    with pytest.raises(ValueError):
        kappa_type_a_two_block(1, 2)
    with pytest.raises(ValueError):
        kappa_type_c_single_block(1)


def test_large_finite_blocks_remain_strictly_below_2():
    assert kappa_type_a_two_block(1000, 1000) < 2
    assert kappa_type_c_single_block(1000) < 2
