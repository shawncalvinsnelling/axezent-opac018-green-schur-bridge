import Opac018UniformProof.CartanGraph
import Mathlib

open scoped BigOperators

namespace Opac018

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- A negative integral Cartan entry has negation at least one after casting to `ℝ`. -/
theorem negated_integer_cartan_entry_ge_one
    {B : Matrix ι ι ℤ} {i j : ι} (hneg : B i j < 0) :
    (1 : ℝ) ≤ -(B i j : ℝ) := by
  have hz : B i j ≤ -1 := by omega
  exact_mod_cast (show (1 : ℤ) ≤ -B i j by omega)

/-- The negation of any off-diagonal finite-Cartan entry is nonnegative. -/
theorem finiteCartan_negated_offdiag_nonneg
    {B : Matrix ι ι ℤ} (hB : B.IsFiniteCartan) {i j : ι} (hij : i ≠ j) :
    0 ≤ -(B i j : ℝ) := by
  have hle : B i j ≤ 0 := hB.offDiag_nonpos i j hij
  exact_mod_cast (show (0 : ℤ) ≤ -B i j by omega)

/-- Off the diagonal, a finite Cartan entry vanishes exactly when there is no Dynkin edge. -/
theorem finiteCartan_entry_zero_of_not_adj
    {B : Matrix ι ι ℤ} (hB : B.IsFiniteCartan) {j k : ι}
    (hjk : j ≠ k) (hnot : ¬ (cartanGraph B).Adj k j) :
    B j k = 0 := by
  by_contra hne
  have hle : B j k ≤ 0 := hB.offDiag_nonpos j k hjk
  have hneg : B j k < 0 := lt_of_le_of_ne hle hne
  have hadj_jk : (cartanGraph B).Adj j k :=
    (cartanGraph_adj_iff hB j k).2 ⟨hjk, hneg⟩
  exact hnot hadj_jk.symm

/--
A Cartan column decomposes into its diagonal term plus its Dynkin-neighbor terms.
This is the finite-sum identity used to turn highest-root dominance into the
residual nonnegativity in the maximum-principle data.
-/
theorem finiteCartan_column_sum_eq_diag_add_neighbors
    {B : Matrix ι ι ℤ} (hB : B.IsFiniteCartan)
    (x : ι → ℝ) (k : ι) :
    (∑ j, x j * (B j k : ℝ)) =
      2 * x k +
        ∑ j ∈ (cartanGraph B).neighborFinset k, x j * (B j k : ℝ) := by
  classical
  let f : ι → ℝ := fun j => x j * (B j k : ℝ)
  have hsubset :
      (cartanGraph B).neighborFinset k ⊆ (Finset.univ.erase k : Finset ι) := by
    intro j hj
    have hadj : (cartanGraph B).Adj k j := by simpa using hj
    exact Finset.mem_erase.mpr ⟨hadj.ne.symm, Finset.mem_univ j⟩
  have hsmall_big :
      (∑ j ∈ (cartanGraph B).neighborFinset k, f j) =
        ∑ j ∈ (Finset.univ.erase k : Finset ι), f j := by
    apply Finset.sum_subset hsubset
    intro j hjbig hjsmall
    have hjne : j ≠ k := (Finset.mem_erase.mp hjbig).1
    have hnot : ¬ (cartanGraph B).Adj k j := by
      intro hadj
      exact hjsmall (by simpa using hadj)
    have hzero : B j k = 0 := finiteCartan_entry_zero_of_not_adj hB hjne hnot
    simp [f, hzero]
  calc
    (∑ j, x j * (B j k : ℝ))
        = (∑ j ∈ (Finset.univ.erase k : Finset ι), f j) + f k := by
            rw [← Finset.sum_erase_add (Finset.univ : Finset ι) f (Finset.mem_univ k)]
            rfl
    _ = (∑ j ∈ (cartanGraph B).neighborFinset k, f j) + f k := by
          rw [← hsmall_big]
    _ = 2 * x k +
          ∑ j ∈ (cartanGraph B).neighborFinset k, x j * (B j k : ℝ) := by
          have hdiag : B k k = 2 := hB.diag k
          simp [f, hdiag, add_comm, mul_comm]

end Opac018
