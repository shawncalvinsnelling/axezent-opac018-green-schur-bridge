import Mathlib

namespace Opac018

/--
Scalar endgame for one deleted irreducible component.

`diag` is the pivot diagonal inverse-Cartan entry, `mark` is the highest-root
mark at the former neighbor, `q` is the reverse Cartan edge multiplicity, and
`c` is Cellini--Marietti's extremal normalized inverse-row maximum.
-/
theorem component_source_bound
    (c diag mark q : ℝ)
    (hc : c ≤ diag / mark)
    (hdiag : 0 ≤ diag)
    (hmark : 1 ≤ mark)
    (hq : 1 ≤ q) :
    c ≤ q * diag := by
  have hmark_pos : 0 < mark := lt_of_lt_of_le zero_lt_one hmark
  have hnorm : diag / mark ≤ diag := by
    rw [div_eq_mul_inv]
    have hinv_nonneg : 0 ≤ mark⁻¹ := inv_nonneg.mpr hmark_pos.le
    have hinv_le_one : mark⁻¹ ≤ 1 := by
      exact (inv_le_one₀ hmark_pos).2 hmark
    exact mul_le_of_le_one_right hdiag hinv_le_one
  have hqdiag : diag ≤ q * diag := by
    nlinarith
  exact hc.trans (hnorm.trans hqdiag)

/--
If every normalized inverse-row entry is bounded by the pivot normalized entry,
then the source maximum over a nonempty finite extremal subset obeys the same bound.
-/
theorem finite_source_max_le_pivot
    {ι : Type*} [Fintype ι]
    (row marks : ι → ℝ) (pivot : ι) (S : Finset ι) (c : ℝ)
    (hS : S.Nonempty)
    (hcdef : c = Finset.sup' S (fun j => row j / marks j) hS)
    (hrowmax : ∀ j, row j / marks j ≤ row pivot / marks pivot) :
    c ≤ row pivot / marks pivot := by
  rw [hcdef]
  exact Finset.sup'_le _ hS fun j _hj => hrowmax j

end Opac018
