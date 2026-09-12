import Mathlib.LinearAlgebra.RootSystem.Base

open Function Set

namespace Opac018

noncomputable section

variable {ι R M N : Type*}
variable [CommRing R] [IsDomain R] [CharZero R]
variable [AddCommGroup M] [Module R M] [AddCommGroup N] [Module R N]
variable {P : RootPairing ι R M N} [Finite ι] [P.IsCrystallographic]

/-- A finite root pairing with a base has a positive root of maximal height. -/
theorem exists_maximal_positive_root
    [Nonempty ι] [NeZero (2 : R)] (b : P.Base) :
    ∃ θ : ι, b.IsPos θ ∧ ∀ i : ι, b.IsPos i → b.height i ≤ b.height θ := by
  classical
  let PosRoot := {i : ι // b.IsPos i}
  have hnonempty : Nonempty PosRoot := by
    rcases b.support_nonempty with ⟨j, hj⟩
    exact ⟨⟨j, b.isPos_of_mem_support hj⟩⟩
  letI : Nonempty PosRoot := hnonempty
  obtain ⟨θ, hθmax⟩ := Finite.exists_max (fun x : PosRoot => b.height x.1)
  exact ⟨θ.1, θ.2, fun i hi => hθmax ⟨i, hi⟩⟩

/-- A positive root cannot be the negative of a simple root. -/
lemma positive_root_ne_neg_simple
    (b : P.Base) {θ j : ι} (hθ : b.IsPos θ) (hj : j ∈ b.support) :
    P.root θ ≠ -P.root j := by
  classical
  intro heq
  let f : ι → ℤ := -Pi.single j 1
  have hsum : P.root θ = ∑ k ∈ b.support, f k • P.root k := by
    rw [Finset.sum_eq_single_of_mem j hj]
    · simp [f, heq]
    · intro k hk hkj
      simp [f, Pi.single_eq_of_ne hkj]
  have hh := b.height_eq_sum hsum
  have hsumf : ∑ k ∈ b.support, f k = -1 := by
    rw [Finset.sum_eq_single_of_mem j hj]
    · simp [f]
    · intro k hk hkj
      simp [f, Pi.single_eq_of_ne hkj]
  have hheight : b.height θ = -1 := hh.trans hsumf
  have hpos : 0 < b.height θ := hθ
  omega

/--
A positive root of maximal height is dominant with respect to every simple coroot.
This is the source-side construction needed for the highest-root mark vector.
-/
theorem maximal_positive_root_dominant
    (b : P.Base) {θ : ι}
    (hθpos : b.IsPos θ)
    (hθmax : ∀ i : ι, b.IsPos i → b.height i ≤ b.height θ) :
    ∀ j ∈ b.support, 0 ≤ P.pairingIn ℤ θ j := by
  classical
  intro j hj
  by_contra hnot
  have hneg : P.pairingIn ℤ θ j < 0 := lt_of_not_ge hnot
  have hne : P.root θ ≠ -P.root j := positive_root_ne_neg_simple b hθpos hj
  obtain ⟨k, hk⟩ := P.root_add_root_mem_of_pairingIn_neg hneg hne
  have hjpos : b.IsPos j := b.isPos_of_mem_support hj
  have hkpos : b.IsPos k := b.IsPos.add hθpos hjpos hk.symm
  have hkheight : b.height k = b.height θ + b.height j := b.height_add hk.symm
  have hjheight : b.height j = 1 := b.height_one_of_mem_support hj
  have hmax := hθmax k hkpos
  rw [hkheight, hjheight] at hmax
  omega

/-- There exists a positive root of maximal height which is dominant on the simple system. -/
theorem exists_dominant_maximal_positive_root
    [Nonempty ι] [NeZero (2 : R)] (b : P.Base) :
    ∃ θ : ι,
      b.IsPos θ ∧
      (∀ i : ι, b.IsPos i → b.height i ≤ b.height θ) ∧
      (∀ j ∈ b.support, 0 ≤ P.pairingIn ℤ θ j) := by
  obtain ⟨θ, hθpos, hθmax⟩ := exists_maximal_positive_root b
  exact ⟨θ, hθpos, hθmax, maximal_positive_root_dominant b hθpos hθmax⟩

end

end Opac018
