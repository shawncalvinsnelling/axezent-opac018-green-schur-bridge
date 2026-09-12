import Mathlib

open Matrix

namespace Opac018

variable {n : Type*} [Fintype n] [DecidableEq n]

/--
A row vector pairing as the `i`-th dual coordinate row is uniquely the `i`-th
row of the nonsingular inverse.  This is the pure matrix core of
`(ω_i, checkω_j) = (B⁻¹)_{ij}` once the source convention gives `x ᵥ* B = e_i`.
-/
theorem inverse_row_of_vecMul_eq_single
    (B : Matrix n n ℝ) (hdet : IsUnit B.det) (x : n → ℝ) (i : n)
    (hx : x ᵥ* B = Pi.single i 1) :
    x = (Pi.single i 1) ᵥ* B⁻¹ := by
  calc
    x = x ᵥ* (1 : Matrix n n ℝ) := (Matrix.vecMul_one x).symm
    _ = x ᵥ* (B * B⁻¹) := by rw [Matrix.mul_nonsing_inv B hdet]
    _ = (x ᵥ* B) ᵥ* B⁻¹ := by rw [Matrix.vecMul_vecMul]
    _ = (Pi.single i 1) ᵥ* B⁻¹ := by rw [hx]

/-- Component form: the unique dual-coordinate coefficient is an inverse-matrix entry. -/
theorem inverse_row_entry_of_vecMul_eq_single
    (B : Matrix n n ℝ) (hdet : IsUnit B.det) (x : n → ℝ) (i j : n)
    (hx : x ᵥ* B = Pi.single i 1) :
    x j = B⁻¹ i j := by
  rw [inverse_row_of_vecMul_eq_single B hdet x i hx]
  simp [Matrix.vecMul, dotProduct, Pi.single_apply]

end Opac018
