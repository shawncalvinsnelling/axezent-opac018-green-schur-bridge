import Mathlib.LinearAlgebra.Matrix.Cartan.Basic
import Mathlib.LinearAlgebra.Matrix.SchurComplement
import Mathlib.Tactic

open Matrix

namespace Opac018

/-- Scalar endgame once the source-to-matrix inequality and Schur identity are known. -/
theorem scalar_endgame
    (r schur detC detB : ℝ)
    (h_source : r ≤ schur)
    (h_detC : 0 < detC)
    (h_detB : 0 < detB)
    (h_schur : 2 - schur = detC / detB) :
    r < 2 := by
  have hratio : 0 < detC / detB := div_pos h_detC h_detB
  have hschur_lt : schur < 2 := by
    linarith
  exact lt_of_le_of_lt h_source hschur_lt

/-- Mathlib already proves determinant positivity for finite Cartan matrices. -/
theorem finiteCartan_det_positive
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    {C : Matrix ι ι ℤ}
    (hC : C.IsFiniteCartan) :
    0 < C.det := by
  exact hC.det_pos

/-- Abstract interface for the normalized inverse-row estimate.  The source-specific
root-system construction of this data is deliberately kept separate until formalized. -/
structure NormalizedInverseRowData (ι : Type*) [Fintype ι] where
  row : ι → ℝ
  marks : ι → ℝ
  pivot : ι
  marks_pos : ∀ j, 0 < marks j
  normalized_max : ∀ j, row j / marks j ≤ row pivot / marks pivot

/-- Restriction of the normalized maximum principle to any finite source set. -/
theorem normalized_source_bound
    {ι : Type*} [Fintype ι]
    (D : NormalizedInverseRowData ι)
    (S : Finset ι) :
    ∀ j ∈ S, D.row j / D.marks j ≤ D.row D.pivot / D.marks D.pivot := by
  intro j _hj
  exact D.normalized_max j

/-- Final interface-level OPAC-018 inequality. -/
theorem opac018_interface_bound
    (r schur detC detB : ℝ)
    (h_source : r ≤ schur)
    (h_detC : 0 < detC)
    (h_detB : 0 < detB)
    (h_schur : 2 - schur = detC / detB) :
    r < 2 := by
  exact scalar_endgame r schur detC detB h_source h_detC h_detB h_schur

end Opac018
