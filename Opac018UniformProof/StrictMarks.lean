import Opac018UniformProof.HighestRoot
import Opac018UniformProof.RootMarks

open Function Set
open scoped BigOperators

namespace Opac018

noncomputable section

variable {ι R M N : Type*}
variable [CommRing R] [IsDomain R] [CharZero R]
variable [AddCommGroup M] [Module R M] [AddCommGroup N] [Module R N]
variable {P : RootPairing ι R M N} [Finite ι] [P.IsCrystallographic]

/-- A positive root has at least one strictly positive simple-root mark. -/
theorem exists_positive_rootMark (b : P.Base) {θ : ι} (hθpos : b.IsPos θ) :
    ∃ i : b.support, 0 < rootCoeffs b θ i := by
  classical
  have hnonneg : ∀ i : b.support, 0 ≤ rootCoeffs b θ i :=
    fun i => rootCoeffs_nonneg_of_isPos b hθpos i
  by_contra hnone
  push_neg at hnone
  have hzero : ∀ i : b.support, rootCoeffs b θ i = 0 := by
    intro i
    exact le_antisymm (hnone i) (hnonneg i)
  have hroot := root_eq_sum_rootCoeffs b θ
  have hroot0 : P.root θ = 0 := by
    rw [hroot]
    apply Finset.sum_eq_zero
    intro j hj
    have hz := hzero ⟨j, hj⟩
    simp only at hz
    rw [hz]
    simp
  exact P.ne_zero θ hroot0

/--
For an irreducible reduced root pairing, every simple-root coefficient of a
positive dominant root is strictly positive.
-/
theorem rootMarks_pos_of_dominant_irreducible
    [P.IsReduced] [P.IsIrreducible]
    (b : P.Base) {θ : ι}
    (hθpos : b.IsPos θ)
    (hdom : ∀ j ∈ b.support, 0 ≤ P.pairingIn ℤ θ j) :
    ∀ j : b.support, 0 < rootCoeffs b θ j := by
  classical
  let marks : b.support → ℤ := fun j => rootCoeffs b θ j
  have hnonneg : ∀ j : b.support, 0 ≤ marks j := by
    intro j
    exact rootCoeffs_nonneg_of_isPos b hθpos j
  obtain ⟨i, hi⟩ := exists_positive_rootMark b hθpos
  intro target
  apply b.induction_on_cartanMatrix (p := fun j : b.support => 0 < marks j) hi
  intro u v hu hvu
  by_cases huv : u = v
  · simpa [huv] using hu
  have hv_nonneg : 0 ≤ marks v := hnonneg v
  by_contra hv_not_pos
  have hv_zero : marks v = 0 := le_antisymm (le_of_not_gt hv_not_pos) hv_nonneg
  have huv_nonzero : b.cartanMatrix u v ≠ 0 := by
    intro hz
    exact hvu ((b.cartanMatrix_apply_eq_zero_iff_symm).mp hz)
  have huv_neg : b.cartanMatrix u v < 0 :=
    lt_of_le_of_ne (b.cartanMatrix_le_zero_of_ne u v huv) huv_nonzero
  have hterm_nonpos : ∀ k : b.support,
      marks k * b.cartanMatrix k v ≤ 0 := by
    intro k
    by_cases hkv : k = v
    · subst k
      simp [hv_zero]
    · exact mul_nonpos_of_nonneg_of_nonpos (hnonneg k)
        (b.cartanMatrix_le_zero_of_ne k v hkv)
  have hterm_u_neg : marks u * b.cartanMatrix u v < 0 :=
    mul_neg_of_pos_of_neg hu huv_neg
  have hsum_neg : (∑ k : b.support, marks k * b.cartanMatrix k v) < 0 := by
    calc
      (∑ k : b.support, marks k * b.cartanMatrix k v)
          < ∑ k : b.support, (0 : ℤ) := by
            refine Finset.sum_lt_sum (fun k _hk => hterm_nonpos k) ?_
            exact ⟨u, Finset.mem_univ _, by simpa using hterm_u_neg⟩
      _ = 0 := by simp
  have hdomv := hdom v v.property
  rw [pairingIn_eq_sum_marks_cartan b θ v] at hdomv
  change 0 ≤ ∑ k : b.support, marks k * b.cartanMatrix k v at hdomv
  omega

/-- A maximal-height positive root in an irreducible reduced system has strictly positive marks. -/
theorem maximal_positive_root_marks_pos
    [P.IsReduced] [P.IsIrreducible]
    (b : P.Base) {θ : ι}
    (hθpos : b.IsPos θ)
    (hθmax : ∀ i : ι, b.IsPos i → b.height i ≤ b.height θ) :
    ∀ j : b.support, 0 < rootCoeffs b θ j := by
  apply rootMarks_pos_of_dominant_irreducible b hθpos
  exact maximal_positive_root_dominant b hθpos hθmax

end

end Opac018
