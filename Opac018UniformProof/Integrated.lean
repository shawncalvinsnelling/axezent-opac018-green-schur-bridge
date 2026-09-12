import Opac018UniformProof.MaximumPrinciple
import Opac018UniformProof.ComponentBound
import Opac018UniformProof.SourceSum
import Opac018UniformProof.ForestAssembly
import Opac018UniformProof.SchurIdentity
import Mathlib.LinearAlgebra.Matrix.Cartan.Basic

open Matrix
open scoped BigOperators

namespace Opac018

noncomputable section

/-- A finite Cartan determinant stays strictly positive after casting from `ℤ` to `ℝ`. -/
theorem finiteCartan_cast_det_pos
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    {C : Matrix ι ι ℤ} (hC : C.IsFiniteCartan) :
    0 < (C.map (Int.cast : ℤ → ℝ)).det := by
  rw [← (Int.castRingHom ℝ).map_det C]
  exact_mod_cast hC.det_pos

variable {E : Type*} [Fintype E] [DecidableEq E]
variable {V : E → Type*}
variable [∀ e, Fintype (V e)] [∀ e, DecidableEq (V e)] [∀ e, Nonempty (V e)]
variable (G : ∀ e, SimpleGraph (V e)) [∀ e, DecidableRel (G e).Adj]

/--
End-to-end uniform matrix closure, relative only to the published source-interface equalities.

The source-specific inputs are:
* `hr`: Proposition 7.4's global coefficient formula `r = Σ pₑ cₑ`;
* `hcdef`: Proposition 7.4's finite extremal maximum defining each `cₑ`;
* `hynorm`: identification of the weighted maximum-principle coordinate at the former neighbor
  with the normalized inverse-Cartan diagonal entry;
* `hmark` and `hq`: positivity/integrality consequences for highest-root marks and Cartan edge
  multiplicities;
* `hBreal`, `hCreal`: the frozen source-to-block-matrix dictionary.

Everything after these interfaces is derived inside Lean without a type-by-type Cartan table.
-/
theorem opac018_uniform_matrix_closure
    (D : ∀ e, WeightedMaximumPrincipleData (G e))
    (Bcomp : ∀ e, Matrix (V e) (V e) ℝ) [∀ e, Invertible (Bcomp e)]
    (Bz : Matrix (Σ e, V e) (Σ e, V e) ℤ)
    (Cz : Matrix (Fin 1 ⊕ (Σ e, V e)) (Fin 1 ⊕ (Σ e, V e)) ℤ)
    (hB : Bz.IsFiniteCartan) (hC : Cz.IsFiniteCartan)
    (p q c mark : E → ℝ)
    (S : ∀ e, Finset (V e)) (hS : ∀ e, (S e).Nonempty)
    (r : ℝ)
    (hr : r = ∑ e, p e * c e)
    (hcdef : ∀ e,
      c e = Finset.sup' (S e) (fun j => (D e).y j) (hS e))
    (hynorm : ∀ e,
      (D e).y (D e).pivot =
        (⅟(Bcomp e)) (D e).pivot (D e).pivot / mark e)
    (hmark : ∀ e, 1 ≤ mark e)
    (hq : ∀ e, 1 ≤ q e)
    (hp : ∀ e, 0 ≤ p e)
    (hBreal :
      Bz.map (Int.cast : ℤ → ℝ) = Matrix.blockDiagonal' Bcomp)
    (hCreal :
      Cz.map (Int.cast : ℤ → ℝ) =
        Matrix.fromBlocks !![2]
          (-(Matrix.replicateRow (Fin 1)
            (componentSparse (fun e => (D e).pivot) p)))
          (-(Matrix.replicateCol (Fin 1)
            (componentSparse (fun e => (D e).pivot) q)))
          (Matrix.blockDiagonal' Bcomp)) :
    r < 2 := by
  let pivot : ∀ e, V e := fun e => (D e).pivot
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

  have hcomponent : ∀ e,
      c e ≤ q e * (⅟(Bcomp e)) (pivot e) (pivot e) := by
    intro e
    have hc_pivot : c e ≤ (D e).y (D e).pivot := by
      rw [hcdef e]
      exact Finset.sup'_le _ (hS e) fun j _hj => (D e).normalized_maximum j
    have hc_norm :
        c e ≤ (⅟(Bcomp e)) (pivot e) (pivot e) / mark e := by
      calc
        c e ≤ (D e).y (D e).pivot := hc_pivot
        _ = (⅟(Bcomp e)) (pivot e) (pivot e) / mark e := by
          simpa [pivot] using hynorm e
    have hmark_pos : 0 < mark e := lt_of_lt_of_le zero_lt_one (hmark e)
    have hy0 :
        0 ≤ (⅟(Bcomp e)) (pivot e) (pivot e) / mark e := by
      rw [← hynorm e]
      simpa [pivot] using (D e).nonnegative (D e).pivot
    have hdiag : 0 ≤ (⅟(Bcomp e)) (pivot e) (pivot e) := by
      rcases div_nonneg_iff.mp hy0 with h | h
      · exact h.1
      · exact False.elim ((not_le_of_gt hmark_pos) h.2)
    exact component_source_bound
      (c e) ((⅟(Bcomp e)) (pivot e) (pivot e)) (mark e) (q e)
      hc_norm hdiag (hmark e) (hq e)

  have hforest :
      pv ⬝ᵥ (⅟B *ᵥ qv) =
        ∑ e, p e * (q e * (⅟(Bcomp e)) (pivot e) (pivot e)) := by
    dsimp [pv, qv, B, pivot]
    exact blockDiagonal_sparse_schur_sum Bcomp (fun e => (D e).pivot) p q

  have hsource : r ≤ pv ⬝ᵥ (⅟B *ᵥ qv) := by
    apply source_coefficient_le_schur_of_component_formula
      r (pv ⬝ᵥ (⅟B *ᵥ qv)) p q c
      (fun e => (⅟(Bcomp e)) (pivot e) (pivot e))
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

  have hratio :
      2 - pv ⬝ᵥ (⅟B *ᵥ qv) = C.det / B.det := by
    dsimp [C]
    exact finite_block_schur_ratio B pv qv hBdet.ne'

  have hschur_lt : pv ⬝ᵥ (⅟B *ᵥ qv) < 2 := by
    have hquot : 0 < C.det / B.det := div_pos hCdet hBdet
    linarith

  exact lt_of_le_of_lt hsource hschur_lt

end

end Opac018
