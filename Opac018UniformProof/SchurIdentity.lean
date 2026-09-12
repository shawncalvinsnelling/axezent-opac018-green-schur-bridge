import Mathlib

open Matrix
open scoped BigOperators

namespace Opac018

variable {n : Type*} [Fintype n] [DecidableEq n]

/--
The exact scalar Schur identity for the finite Cartan block convention

    C = [ 2   -p^T ]
        [ -q    B   ].

The only algebraic input is invertibility of `B`; finite-Cartan positivity will
supply that in the root-system instantiation.
-/
theorem finite_block_schur_identity
    (B : Matrix n n ℝ) [Invertible B] (p q : n → ℝ) :
    let C : Matrix (Fin 1 ⊕ n) (Fin 1 ⊕ n) ℝ :=
      Matrix.fromBlocks !![2]
        (-(Matrix.replicateRow (Fin 1) p))
        (-(Matrix.replicateCol (Fin 1) q)) B
    C.det = B.det * (2 - p ⬝ᵥ (⅟B *ᵥ q)) := by
  dsimp
  rw [Matrix.det_fromBlocks₂₂]
  rw [Matrix.det_fin_one]
  simp only [Fin.isValue, Matrix.sub_apply, Matrix.cons_val_zero, Matrix.head_cons,
    Matrix.neg_apply]
  have hentry :
      ((-(Matrix.replicateRow (Fin 1) p)) * ⅟B *
          (-(Matrix.replicateCol (Fin 1) q))) 0 0 =
        p ⬝ᵥ (⅟B *ᵥ q) := by
    simp [Matrix.mul_apply, Matrix.mulVec, dotProduct, Finset.mul_sum, Finset.sum_mul]
  rw [hentry]

/-- Ratio form used by the OPAC-018 scalar endgame. -/
theorem finite_block_schur_ratio
    (B : Matrix n n ℝ) [Invertible B] (p q : n → ℝ)
    (hBdet : B.det ≠ 0) :
    let C : Matrix (Fin 1 ⊕ n) (Fin 1 ⊕ n) ℝ :=
      Matrix.fromBlocks !![2]
        (-(Matrix.replicateRow (Fin 1) p))
        (-(Matrix.replicateCol (Fin 1) q)) B
    2 - p ⬝ᵥ (⅟B *ᵥ q) = C.det / B.det := by
  dsimp
  have h := finite_block_schur_identity B p q
  rw [h]
  field_simp

end Opac018
