import Opac018UniformProof.CartanMaximumBridge
import Opac018UniformProof.RootCartanConnected
import Opac018UniformProof.HighestRoot
import Opac018UniformProof.RootMarks
import Opac018UniformProof.StrictMarks

open Function Set
open scoped BigOperators

namespace Opac018

noncomputable section

variable {ι R M N : Type*}
variable [CommRing R] [IsDomain R] [CharZero R]
variable [AddCommGroup M] [Module R M] [AddCommGroup N] [Module R N]
variable {P : RootPairing ι R M N} [Finite ι]
variable [P.IsCrystallographic] [P.IsRootSystem] [P.IsReduced] [P.IsIrreducible]

/--
A maximal-height positive root supplies a strictly positive real mark vector
whose Cartan-column pairings are nonnegative.
-/
theorem maximal_root_real_marks_positive_dominant
    (b : P.Base) {θ : ι}
    (hθpos : b.IsPos θ)
    (hθmax : ∀ i : ι, b.IsPos i → b.height i ≤ b.height θ) :
    let m : b.support → ℝ := fun j => (rootCoeffs b θ j : ℝ)
    (∀ j, 0 < m j) ∧
      (∀ k, 0 ≤ ∑ j, m j * (b.cartanMatrix j k : ℝ)) := by
  classical
  let m : b.support → ℝ := fun j => (rootCoeffs b θ j : ℝ)
  have hm : ∀ j : b.support, 0 < m j := by
    intro j
    dsimp [m]
    exact_mod_cast (maximal_positive_root_marks_pos b hθpos hθmax j)
  have hdomZ := maximal_positive_root_dominant b hθpos hθmax
  have hdom : ∀ k : b.support,
      0 ≤ ∑ j, m j * (b.cartanMatrix j k : ℝ) := by
    intro k
    have hk := hdomZ k k.property
    rw [pairingIn_eq_sum_marks_cartan b θ k] at hk
    dsimp [m]
    exact_mod_cast hk
  exact ⟨hm, hdom⟩

/--
Root-system instantiation of the normalized inverse-Cartan maximum principle.
No `WeightedMaximumPrincipleData` is supplied by the caller: all its fields are
constructed from the irreducible finite root system and the maximal-height root.
-/
theorem root_normalized_inverse_cartan_maximum
    (b : P.Base) {θ : ι}
    (hθpos : b.IsPos θ)
    (hθmax : ∀ i : ι, b.IsPos i → b.height i ≤ b.height θ)
    (pivot j : b.support) :
    let B : Matrix b.support b.support ℝ :=
      b.cartanMatrix.map (Int.cast : ℤ → ℝ)
    let m : b.support → ℝ := fun k => (rootCoeffs b θ k : ℝ)
    0 ≤ B⁻¹ pivot j / m j ∧
      B⁻¹ pivot j / m j ≤ B⁻¹ pivot pivot / m pivot := by
  classical
  rcases b.support_nonempty with ⟨i₀, hi₀⟩
  letI : Nonempty b.support := ⟨⟨i₀, hi₀⟩⟩
  let Bz : Matrix b.support b.support ℤ := b.cartanMatrix
  let B : Matrix b.support b.support ℝ :=
    b.cartanMatrix.map (Int.cast : ℤ → ℝ)
  let m : b.support → ℝ := fun k => (rootCoeffs b θ k : ℝ)
  have hB : Bz.IsFiniteCartan := by
    dsimp [Bz]
    exact b.cartanMatrix_isFiniteCartan
  have hpre : (cartanGraph Bz).Preconnected := by
    dsimp [Bz]
    exact base_cartanGraph_preconnected b
  obtain ⟨hm_pos, hdom⟩ :=
    maximal_root_real_marks_positive_dominant b hθpos hθmax
  have hm_pos' : ∀ k, 0 < m k := by
    simpa [m] using hm_pos
  have hdom' : ∀ k, 0 ≤ ∑ l, m l * (Bz l k : ℝ) := by
    intro k
    simpa [m, Bz] using hdom k
  let D : WeightedMaximumPrincipleData (cartanGraph Bz) :=
    finiteCartanWeightedData Bz hB hpre m hm_pos' hdom' pivot
  have hnon : 0 ≤ D.y j := D.nonnegative j
  have hmax : D.y j ≤ D.y pivot := D.normalized_maximum j
  have hyj : D.y j = B⁻¹ pivot j / m j := by
    simpa [D, B, Bz] using
      finiteCartanWeightedData_y Bz hB hpre m hm_pos' hdom' pivot j
  have hyp : D.y pivot = B⁻¹ pivot pivot / m pivot := by
    simpa [D, B, Bz] using
      finiteCartanWeightedData_y Bz hB hpre m hm_pos' hdom' pivot pivot
  constructor
  · simpa [hyj] using hnon
  · simpa [hyj, hyp] using hmax

/-- Every maximal-root mark is at least one after casting to `ℝ`. -/
theorem maximal_root_real_mark_ge_one
    (b : P.Base) {θ : ι}
    (hθpos : b.IsPos θ)
    (hθmax : ∀ i : ι, b.IsPos i → b.height i ≤ b.height θ)
    (j : b.support) :
    (1 : ℝ) ≤ (rootCoeffs b θ j : ℝ) := by
  have hj : 0 < rootCoeffs b θ j :=
    maximal_positive_root_marks_pos b hθpos hθmax j
  exact_mod_cast (show (1 : ℤ) ≤ rootCoeffs b θ j by omega)

end

end Opac018
