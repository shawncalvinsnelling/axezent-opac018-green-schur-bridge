import Mathlib

open scoped BigOperators

namespace Opac018

variable {E : Type*} [Fintype E]

/--
Componentwise source bounds assemble monotonically because the deleted-node
coefficients `pε = -(α, ε∨)` are nonnegative.
-/
theorem source_sum_le_component_schur
    (p q c d : E → ℝ)
    (hp : ∀ e, 0 ≤ p e)
    (hc : ∀ e, c e ≤ q e * d e) :
    (∑ e, p e * c e) ≤ ∑ e, p e * (q e * d e) := by
  apply Finset.sum_le_sum
  intro e _he
  exact mul_le_mul_of_nonneg_left (hc e) (hp e)

/-- Version with the geometric coefficient and Schur scalar named explicitly. -/
theorem source_coefficient_le_schur_of_component_formula
    (r schur : ℝ) (p q c d : E → ℝ)
    (hr : r = ∑ e, p e * c e)
    (hs : schur = ∑ e, p e * (q e * d e))
    (hp : ∀ e, 0 ≤ p e)
    (hc : ∀ e, c e ≤ q e * d e) :
    r ≤ schur := by
  rw [hr, hs]
  exact source_sum_le_component_schur p q c d hp hc

end Opac018
