import Opac018UniformProof.CartanColumn
import Opac018UniformProof.ForestAssembly
import Mathlib

namespace Opac018

noncomputable section

variable {E : Type*} [Fintype E] [DecidableEq E]
variable {V : E → Type*}
variable [∀ e, Fintype (V e)] [∀ e, DecidableEq (V e)]

/-- The retained pivot node of component `e`, viewed inside the deleted forest. -/
def sourceNode (pivot : ∀ e, V e) (e : E) : Σ e, V e := ⟨e, pivot e⟩

/--
The top-right block equality forces `p_e` to be the negation of the finite
Cartan entry `C_{alpha,e}`.  Hence finite-Cartan off-diagonal nonpositivity gives
`p_e ≥ 0` automatically.
-/
theorem source_block_p_nonnegative
    (Cz : Matrix (Fin 1 ⊕ (Σ e, V e)) (Fin 1 ⊕ (Σ e, V e)) ℤ)
    (hC : Cz.IsFiniteCartan)
    (pivot : ∀ e, V e) (p q : E → ℝ)
    (B : Matrix (Σ e, V e) (Σ e, V e) ℝ)
    (hCreal :
      Cz.map (Int.cast : ℤ → ℝ) =
        Matrix.fromBlocks !![2]
          (-(Matrix.replicateRow (Fin 1) (componentSparse pivot p)))
          (-(Matrix.replicateCol (Fin 1) (componentSparse pivot q))) B) :
    ∀ e, 0 ≤ p e := by
  classical
  intro e
  let top : Fin 1 ⊕ (Σ e, V e) := Sum.inl 0
  let node : Fin 1 ⊕ (Σ e, V e) := Sum.inr (sourceNode pivot e)
  have hne : top ≠ node := by simp [top, node]
  have hnon : 0 ≤ -(Cz top node : ℝ) :=
    finiteCartan_negated_offdiag_nonneg hC hne
  have hentry := congrArg
    (fun M : Matrix (Fin 1 ⊕ (Σ e, V e)) (Fin 1 ⊕ (Σ e, V e)) ℝ =>
      M top node) hCreal
  have hentry' : (Cz top node : ℝ) = -p e := by
    simpa [top, node, sourceNode, componentSparse] using hentry
  rw [hentry'] at hnon
  linarith

/--
If the retained component pivot is genuinely adjacent to the deleted node in
the original finite Cartan graph, then the bottom-left block entry is a negative
integer.  The block equality therefore forces `q_e ≥ 1` automatically.
-/
theorem source_block_q_ge_one
    (Cz : Matrix (Fin 1 ⊕ (Σ e, V e)) (Fin 1 ⊕ (Σ e, V e)) ℤ)
    (pivot : ∀ e, V e) (p q : E → ℝ)
    (B : Matrix (Σ e, V e) (Σ e, V e) ℝ)
    (hCreal :
      Cz.map (Int.cast : ℤ → ℝ) =
        Matrix.fromBlocks !![2]
          (-(Matrix.replicateRow (Fin 1) (componentSparse pivot p)))
          (-(Matrix.replicateCol (Fin 1) (componentSparse pivot q))) B)
    (hneighbor : ∀ e,
      Cz (Sum.inr (sourceNode pivot e)) (Sum.inl 0) < 0) :
    ∀ e, 1 ≤ q e := by
  classical
  intro e
  let top : Fin 1 ⊕ (Σ e, V e) := Sum.inl 0
  let node : Fin 1 ⊕ (Σ e, V e) := Sum.inr (sourceNode pivot e)
  have hqint : (1 : ℝ) ≤ -(Cz node top : ℝ) := by
    exact negated_integer_cartan_entry_ge_one (hneighbor e)
  have hentry := congrArg
    (fun M : Matrix (Fin 1 ⊕ (Σ e, V e)) (Fin 1 ⊕ (Σ e, V e)) ℝ =>
      M node top) hCreal
  have hentry' : (Cz node top : ℝ) = -q e := by
    simpa [top, node, sourceNode, componentSparse] using hentry
  rw [hentry'] at hqint
  linarith

end

end Opac018
