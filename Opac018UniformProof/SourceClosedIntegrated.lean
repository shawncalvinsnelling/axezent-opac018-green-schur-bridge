import Opac018UniformProof.Integrated
import Opac018UniformProof.BlockSourceInterface

open Matrix
open scoped BigOperators

namespace Opac018

noncomputable section

variable {E : Type*} [Fintype E] [DecidableEq E]
variable {V : E → Type*}
variable [∀ e, Fintype (V e)] [∀ e, DecidableEq (V e)] [∀ e, Nonempty (V e)]

/--
Final matrix closure after the root-system component theorem has supplied the
per-component bounds.

Unlike `opac018_uniform_matrix_closure`, this theorem has no
`WeightedMaximumPrincipleData`, no normalized-coordinate identification, and no
mark assumptions in its interface.  Those have been pushed into the actual
root-system theorem `root_component_source_bound`.

The remaining equalities `hr`, `hBreal`, and `hCreal` are the deliberately
visible Cellini–Marietti / deleted-Cartan source interface.
-/
theorem opac018_source_closed_matrix_closure
    (Bcomp : ∀ e, Matrix (V e) (V e) ℝ) [∀ e, Invertible (Bcomp e)]
    (Bz : Matrix (Σ e, V e) (Σ e, V e) ℤ)
    (Cz : Matrix (Fin 1 ⊕ (Σ e, V e)) (Fin 1 ⊕ (Σ e, V e)) ℤ)
    (hB : Bz.IsFiniteCartan) (hC : Cz.IsFiniteCartan)
    (pivot : ∀ e, V e)
    (p q c : E → ℝ) (r : ℝ)
    (hr : r = ∑ e, p e * c e)
    (hp : ∀ e, 0 ≤ p e)
    (hcomponent : ∀ e,
      c e ≤ q e * (Bcomp e)⁻¹ (pivot e) (pivot e))
    (hBreal :
      Bz.map (Int.cast : ℤ → ℝ) = Matrix.blockDiagonal' Bcomp)
    (hCreal :
      Cz.map (Int.cast : ℤ → ℝ) =
        Matrix.fromBlocks !![2]
          (-(Matrix.replicateRow (Fin 1) (componentSparse pivot p)))
          (-(Matrix.replicateCol (Fin 1) (componentSparse pivot q)))
          (Matrix.blockDiagonal' Bcomp)) :
    r < 2 := by
  let pv : (Σ e, V e) → ℝ := componentSparse pivot p
  let qv : (Σ e, V e) → ℝ := componentSparse pivot q
  let B : Matrix (Σ e, V e) (Σ e, V e) ℝ := Matrix.blockDiagonal' Bcomp
  let C : Matrix (Fin 1 ⊕ (Σ e, V e)) (Fin 1 ⊕ (Σ e, V e)) ℝ :=
    Matrix.fromBlocks !![2]
      (-(Matrix.replicateRow (Fin 1) pv))
      (-(Matrix.replicateCol (Fin 1) qv)) B

  letI : Invertible B := by
    dsimp [B]
    exact blockDiagonalInvertible Bcomp

  have hforest_invOf :
      pv ⬝ᵥ (⅟B *ᵥ qv) =
        ∑ e, p e * (q e * (⅟(Bcomp e)) (pivot e) (pivot e)) := by
    dsimp [pv, qv, B]
    exact blockDiagonal_sparse_schur_sum Bcomp pivot p q
  have hforest :
      pv ⬝ᵥ (B⁻¹ *ᵥ qv) =
        ∑ e, p e * (q e * (Bcomp e)⁻¹ (pivot e) (pivot e)) := by
    simpa only [Matrix.invOf_eq_nonsing_inv] using hforest_invOf

  have hsource : r ≤ pv ⬝ᵥ (B⁻¹ *ᵥ qv) := by
    apply source_coefficient_le_schur_of_component_formula
      r (pv ⬝ᵥ (B⁻¹ *ᵥ qv)) p q c
      (fun e => (Bcomp e)⁻¹ (pivot e) (pivot e))
    · exact hr
    · exact hforest
    · exact hp
    · exact hcomponent

  have hBdet : 0 < B.det := by
    rw [← hBreal]
    exact finiteCartan_cast_det_pos hB

  have hCdet : 0 < C.det := by
    rw [← hCreal]
    exact finiteCartan_cast_det_pos hC

  have hratio_invOf :
      2 - pv ⬝ᵥ (⅟B *ᵥ qv) = C.det / B.det := by
    dsimp [C]
    exact finite_block_schur_ratio B pv qv hBdet.ne'
  have hratio :
      2 - pv ⬝ᵥ (B⁻¹ *ᵥ qv) = C.det / B.det := by
    simpa only [Matrix.invOf_eq_nonsing_inv] using hratio_invOf

  have hschur_lt : pv ⬝ᵥ (B⁻¹ *ᵥ qv) < 2 := by
    have hquot : 0 < C.det / B.det := div_pos hCdet hBdet
    linarith

  exact lt_of_le_of_lt hsource hschur_lt

/--
Stronger source-closed wrapper: `p ≥ 0` is no longer supplied by the caller.
It is derived from the top-right block of the original finite Cartan matrix,
which freezes the Proposition 7.4 `p_e = -C_{alpha,e}` orientation in Lean.
-/
theorem opac018_block_source_closed_matrix_closure
    (Bcomp : ∀ e, Matrix (V e) (V e) ℝ) [∀ e, Invertible (Bcomp e)]
    (Bz : Matrix (Σ e, V e) (Σ e, V e) ℤ)
    (Cz : Matrix (Fin 1 ⊕ (Σ e, V e)) (Fin 1 ⊕ (Σ e, V e)) ℤ)
    (hB : Bz.IsFiniteCartan) (hC : Cz.IsFiniteCartan)
    (pivot : ∀ e, V e)
    (p q c : E → ℝ) (r : ℝ)
    (hr : r = ∑ e, p e * c e)
    (hcomponent : ∀ e,
      c e ≤ q e * (Bcomp e)⁻¹ (pivot e) (pivot e))
    (hBreal :
      Bz.map (Int.cast : ℤ → ℝ) = Matrix.blockDiagonal' Bcomp)
    (hCreal :
      Cz.map (Int.cast : ℤ → ℝ) =
        Matrix.fromBlocks !![2]
          (-(Matrix.replicateRow (Fin 1) (componentSparse pivot p)))
          (-(Matrix.replicateCol (Fin 1) (componentSparse pivot q)))
          (Matrix.blockDiagonal' Bcomp)) :
    r < 2 := by
  have hp : ∀ e, 0 ≤ p e :=
    source_block_p_nonnegative Cz hC pivot p q
      (Matrix.blockDiagonal' Bcomp) hCreal
  exact opac018_source_closed_matrix_closure
    Bcomp Bz Cz hB hC pivot p q c r hr hp hcomponent hBreal hCreal

end

end Opac018
