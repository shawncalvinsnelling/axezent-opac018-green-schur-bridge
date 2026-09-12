import Opac018UniformProof.RootComponentBound
import Opac018UniformProof.SourceClosedIntegrated
import Opac018UniformProof.BlockSourceInterface
import Mathlib.LinearAlgebra.RootSystem.CartanMatrix

open scoped BigOperators

namespace Opac018

noncomputable section

variable {E : Type*} [Fintype E] [DecidableEq E]
variable {I : E → Type*} [∀ e, Finite (I e)]
variable {M N : E → Type*}
variable [∀ e, AddCommGroup (M e)] [∀ e, Module ℝ (M e)]
variable [∀ e, AddCommGroup (N e)] [∀ e, Module ℝ (N e)]
variable (P : ∀ e, RootPairing (I e) ℝ (M e) (N e))
variable [∀ e, (P e).IsCrystallographic]
variable [∀ e, (P e).IsRootSystem]
variable [∀ e, (P e).IsReduced]
variable [∀ e, (P e).IsIrreducible]

/--
Root-system family closure for the novel part of OPAC-018.

For each deleted irreducible component, the theorem constructs the normalized
inverse-Cartan maximum principle from the component's own root system and
maximal-height root.  It also derives `p ≥ 0` and `q ≥ 1` from the displayed
finite Cartan block and the fact that every retained pivot is a genuine former
neighbor of the deleted node.

The remaining hypotheses are exactly the published source boundary:
* `hr`: Cellini–Marietti Proposition 7.4's global coefficient formula;
* `hcdef`: the Proposition 7.4 branch maximum using `m_eta`;
* `hBreal` / `hCreal`: the deleted-component and original-Cartan block
  identifications supplied by the published component decomposition;
* `hneighbor`: each component pivot is the former neighbor of the deleted node.
-/
theorem opac018_root_family_closure
    (b : ∀ e, (P e).Base)
    (θ : ∀ e, I e)
    (hθpos : ∀ e, (b e).IsPos (θ e))
    (hθmax : ∀ e i, (b e).IsPos i → (b e).height i ≤ (b e).height (θ e))
    (pivot : ∀ e, (b e).support)
    (S : ∀ e, Finset ((b e).support))
    (hS : ∀ e, (S e).Nonempty)
    (p q c : E → ℝ) (r : ℝ)
    (Bz : Matrix (Σ e, (b e).support) (Σ e, (b e).support) ℤ)
    (Cz : Matrix (Fin 1 ⊕ (Σ e, (b e).support))
      (Fin 1 ⊕ (Σ e, (b e).support)) ℤ)
    (hB : Bz.IsFiniteCartan) (hC : Cz.IsFiniteCartan)
    (hr : r = ∑ e, p e * c e)
    (hcdef : ∀ e,
      c e = Finset.sup' (S e)
        (fun j =>
          ((b e).cartanMatrix.map (Int.cast : ℤ → ℝ))⁻¹ (pivot e) j /
            (rootCoeffs (b e) (θ e) j : ℝ)) (hS e))
    (hBreal :
      Bz.map (Int.cast : ℤ → ℝ) =
        Matrix.blockDiagonal'
          (fun e => (b e).cartanMatrix.map (Int.cast : ℤ → ℝ)))
    (hCreal :
      Cz.map (Int.cast : ℤ → ℝ) =
        Matrix.fromBlocks !![2]
          (-(Matrix.replicateRow (Fin 1) (componentSparse pivot p)))
          (-(Matrix.replicateCol (Fin 1) (componentSparse pivot q)))
          (Matrix.blockDiagonal'
            (fun e => (b e).cartanMatrix.map (Int.cast : ℤ → ℝ))))
    (hneighbor : ∀ e,
      Cz (Sum.inr (sourceNode pivot e)) (Sum.inl 0) < 0) :
    r < 2 := by
  classical
  let Bcomp : ∀ e, Matrix ((b e).support) ((b e).support) ℝ :=
    fun e => (b e).cartanMatrix.map (Int.cast : ℤ → ℝ)

  let supportNonempty : ∀ e, Nonempty ((b e).support) := fun e => by
    rcases (b e).support_nonempty with ⟨i, hi⟩
    exact ⟨⟨i, hi⟩⟩
  letI : ∀ e, Nonempty ((b e).support) := supportNonempty

  letI : ∀ e, Invertible (Bcomp e) := fun e => by
    dsimp [Bcomp]
    exact ((b e).cartanMatrix_isFiniteCartan.isUnit_map ℝ).invertible

  have hq : ∀ e, 1 ≤ q e :=
    source_block_q_ge_one Cz pivot p q (Matrix.blockDiagonal' Bcomp)
      (by simpa [Bcomp] using hCreal) hneighbor

  have hcomponent : ∀ e,
      c e ≤ q e * (Bcomp e)⁻¹ (pivot e) (pivot e) := by
    intro e
    dsimp [Bcomp]
    exact root_component_source_bound (b e)
      (hθpos e) (hθmax e) (pivot e) (S e) (hS e) (c e) (q e)
      (hcdef e) (hq e)

  exact opac018_block_source_closed_matrix_closure
    Bcomp Bz Cz hB hC pivot p q c r hr hcomponent
    (by simpa [Bcomp] using hBreal)
    (by simpa [Bcomp] using hCreal)

end

end Opac018
