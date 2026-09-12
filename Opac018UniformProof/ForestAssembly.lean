import Mathlib

open Matrix
open scoped BigOperators

namespace Opac018

noncomputable section

variable {E : Type*} [Fintype E] [DecidableEq E]
variable {V : E → Type*}
variable [∀ e, Fintype (V e)] [∀ e, DecidableEq (V e)]

/-- The block-diagonal assembly of independently invertible component matrices is invertible. -/
def blockDiagonalInvertible
    (B : ∀ e, Matrix (V e) (V e) ℝ) [∀ e, Invertible (B e)] :
    Invertible (Matrix.blockDiagonal' B) := by
  let Binv : Matrix (Σ e, V e) (Σ e, V e) ℝ :=
    Matrix.blockDiagonal' (fun e => ⅟(B e))
  apply invertibleOfLeftInverse (Matrix.blockDiagonal' B) Binv
  rw [Matrix.blockDiagonal'_mul]
  simp

/-- The inverse of a dependent block diagonal is the dependent block diagonal of inverses. -/
theorem invOf_blockDiagonal'
    (B : ∀ e, Matrix (V e) (V e) ℝ) [∀ e, Invertible (B e)] :
    letI := blockDiagonalInvertible B
    ⅟(Matrix.blockDiagonal' B) = Matrix.blockDiagonal' (fun e => ⅟(B e)) := by
  letI := blockDiagonalInvertible B
  apply invOf_eq_left_inv
  rw [Matrix.blockDiagonal'_mul]
  simp

/-- Sparse vector supported at one distinguished vertex in each component. -/
def componentSparse (pivot : ∀ e, V e) (w : E → ℝ) : (Σ e, V e) → ℝ
  | ⟨e, i⟩ => if i = pivot e then w e else 0

/--
Exact deleted-forest quadratic-form assembly.  If `B` is the dependent block
diagonal of component matrices and `p,q` are supported at the unique former
neighbor (`pivot`) of the deleted node in each component, then

`pᵀ B⁻¹ q = Σ_e p_e q_e (B_e⁻¹)_{pivot_e,pivot_e}`.
-/
theorem blockDiagonal_sparse_schur_sum
    (B : ∀ e, Matrix (V e) (V e) ℝ) [∀ e, Invertible (B e)]
    (pivot : ∀ e, V e) (p q : E → ℝ) :
    letI := blockDiagonalInvertible B
    componentSparse pivot p ⬝ᵥ
        (⅟(Matrix.blockDiagonal' B) *ᵥ componentSparse pivot q) =
      ∑ e, p e * (q e * (⅟(B e)) (pivot e) (pivot e)) := by
  letI := blockDiagonalInvertible B
  rw [invOf_blockDiagonal' B]
  simp [componentSparse, Matrix.dotProduct, Matrix.mulVec, Matrix.blockDiagonal',
    Finset.sum_sigma']

end

end Opac018
