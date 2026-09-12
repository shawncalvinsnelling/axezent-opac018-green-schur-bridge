import Mathlib.LinearAlgebra.RootSystem.CartanMatrix

open Function Set
open scoped BigOperators

namespace Opac018

noncomputable section

variable {ι R M N : Type*}
variable [CommRing R] [IsDomain R] [CharZero R]
variable [AddCommGroup M] [Module R M] [AddCommGroup N] [Module R N]
variable {P : RootPairing ι R M N} [Finite ι] [P.IsCrystallographic]

/-- The unique integer simple-root coefficient vector of a root relative to a base. -/
def rootCoeffs (b : P.Base) (i : ι) : ι → ℤ :=
  (b.exists_root_eq_sum_int i).choose

/-- Reconstruction of a root from its integer simple-root coefficients. -/
theorem root_eq_sum_rootCoeffs (b : P.Base) (i : ι) :
    P.root i = ∑ j ∈ b.support, rootCoeffs b i j • P.root j := by
  exact (b.exists_root_eq_sum_int i).choose_spec.2.2

/-- A positive root has pointwise nonnegative simple-root coefficients. -/
theorem rootCoeffs_nonneg_of_isPos (b : P.Base) {i : ι} (hi : b.IsPos i) :
    ∀ j : ι, 0 ≤ rootCoeffs b i j := by
  let f := rootCoeffs b i
  have hspec := (b.exists_root_eq_sum_int i).choose_spec
  have hsign : 0 < f ∨ f < 0 := hspec.2.1
  have heq : P.root i = ∑ j ∈ b.support, f j • P.root j := hspec.2.2
  have hfpos : 0 < f := by
    refine hsign.resolve_right ?_
    intro hfneg
    have hsumle : ∑ j ∈ b.support, f j ≤ 0 :=
      Finset.sum_nonpos fun j _hj => hfneg.le j
    have hh : b.height i = ∑ j ∈ b.support, f j := b.height_eq_sum heq
    have hheight : 0 < b.height i := hi
    rw [hh] at hheight
    exact (not_lt_of_ge hsumle) hheight
  intro j
  exact hfpos.le j

/-- Pairing a root with a simple coroot is the Cartan-weighted sum of its marks. -/
theorem pairingIn_eq_sum_rootCoeffs (b : P.Base) (i : ι) (j : b.support) :
    P.pairingIn ℤ i j =
      ∑ k ∈ b.support, rootCoeffs b i k * P.pairingIn ℤ k j := by
  let f := rootCoeffs b i
  have heq : P.root i = ∑ k ∈ b.support, f k • P.root k :=
    root_eq_sum_rootCoeffs b i
  apply algebraMap_injective ℤ R
  simp_rw [algebraMap_pairingIn, map_sum, ← root_coroot_eq_pairing, heq, map_sum, map_zsmul,
    LinearMap.coe_sum, Finset.sum_apply, LinearMap.smul_apply, root_coroot_eq_pairing,
    zsmul_eq_mul, algebraMap_pairingIn, map_mul]

/-- On simple indices the preceding identity is literally a Cartan-matrix column sum. -/
theorem pairingIn_eq_sum_marks_cartan (b : P.Base) (i : ι) (j : b.support) :
    P.pairingIn ℤ i j =
      ∑ k : b.support, rootCoeffs b i k * b.cartanMatrix k j := by
  rw [pairingIn_eq_sum_rootCoeffs b i j]
  rw [b.support.sum_subtype (p := (· ∈ b.support)) (by simp) (F := inferInstance)]
  simp [RootPairing.Base.cartanMatrix, RootPairing.Base.cartanMatrixIn_def]

end

end Opac018
