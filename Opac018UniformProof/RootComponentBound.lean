import Opac018UniformProof.RootMaximumBridge
import Opac018UniformProof.ComponentBound

namespace Opac018

noncomputable section

variable {ι R M N : Type*}
variable [CommRing R] [IsDomain R] [CharZero R]
variable [AddCommGroup M] [Module R M] [AddCommGroup N] [Module R N]
variable {P : RootPairing ι R M N} [Finite ι]
variable [P.IsCrystallographic] [P.IsRootSystem] [P.IsReduced] [P.IsIrreducible]

/--
Per-component Cellini–Marietti source bound instantiated from an actual finite
irreducible root system.  The only source-specific input is the definition of
`c` as the maximum over the chosen extremal-node set, plus the reverse-edge
Cartan multiplicity lower bound `q ≥ 1`.
-/
theorem root_component_source_bound
    (b : P.Base) {θ : ι}
    (hθpos : b.IsPos θ)
    (hθmax : ∀ i : ι, b.IsPos i → b.height i ≤ b.height θ)
    (pivot : b.support)
    (S : Finset b.support) (hS : S.Nonempty)
    (c q : ℝ)
    (hcdef :
      c = Finset.sup' S
        (fun j =>
          (b.cartanMatrix.map (Int.cast : ℤ → ℝ))⁻¹ pivot j /
            (rootCoeffs b θ j : ℝ)) hS)
    (hq : 1 ≤ q) :
    c ≤ q *
      (b.cartanMatrix.map (Int.cast : ℤ → ℝ))⁻¹ pivot pivot := by
  classical
  let B : Matrix b.support b.support ℝ :=
    b.cartanMatrix.map (Int.cast : ℤ → ℝ)
  let marks : b.support → ℝ := fun j => (rootCoeffs b θ j : ℝ)
  have hrowmax : ∀ j,
      B⁻¹ pivot j / marks j ≤ B⁻¹ pivot pivot / marks pivot := by
    intro j
    exact (root_normalized_inverse_cartan_maximum b hθpos hθmax pivot j).2
  have hc_pivot : c ≤ B⁻¹ pivot pivot / marks pivot := by
    apply finite_source_max_le_pivot
      (fun j => B⁻¹ pivot j) marks pivot S c hS
    · simpa [B, marks] using hcdef
    · exact hrowmax
  have hmark : (1 : ℝ) ≤ marks pivot := by
    simpa [marks] using maximal_root_real_mark_ge_one b hθpos hθmax pivot
  have hmark_pos : 0 < marks pivot := lt_of_lt_of_le zero_lt_one hmark
  have hnorm_nonneg : 0 ≤ B⁻¹ pivot pivot / marks pivot :=
    (root_normalized_inverse_cartan_maximum b hθpos hθmax pivot pivot).1
  have hdiag : 0 ≤ B⁻¹ pivot pivot := by
    rcases div_nonneg_iff.mp hnorm_nonneg with h | h
    · exact h.1
    · exact False.elim ((not_le_of_gt hmark_pos) h.2)
  exact component_source_bound c (B⁻¹ pivot pivot) (marks pivot) q
    hc_pivot hdiag hmark hq

end

end Opac018
