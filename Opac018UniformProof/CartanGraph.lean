import Mathlib

namespace Opac018

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The unoriented Dynkin graph of a Cartan matrix, defined from negative off-diagonal entries. -/
def cartanGraph (B : Matrix ι ι ℤ) : SimpleGraph ι :=
  SimpleGraph.fromRel fun i j => B i j < 0

/-- For a finite Cartan matrix, negativity occurs in both orientations across an edge. -/
theorem cartan_negative_comm {B : Matrix ι ι ℤ} (hB : B.IsFiniteCartan)
    {i j : ι} (hij : i ≠ j) :
    B i j < 0 ↔ B j i < 0 := by
  constructor
  · intro hneg
    have hne0 : B i j ≠ 0 := ne_of_lt hneg
    have hne0' : B j i ≠ 0 := by
      intro hz
      exact hne0 ((hB.zero_comm i j).mpr hz)
    have hle : B j i ≤ 0 := hB.offDiag_nonpos j i hij.symm
    exact lt_of_le_of_ne hle (Ne.symm hne0')
  · intro hneg
    have hne0 : B j i ≠ 0 := ne_of_lt hneg
    have hne0' : B i j ≠ 0 := by
      intro hz
      exact hne0 ((hB.zero_comm i j).mp hz)
    have hle : B i j ≤ 0 := hB.offDiag_nonpos i j hij
    exact lt_of_le_of_ne hle (Ne.symm hne0')

/-- Exact adjacency criterion for the finite-Cartan Dynkin graph. -/
theorem cartanGraph_adj_iff {B : Matrix ι ι ℤ} (hB : B.IsFiniteCartan)
    (i j : ι) :
    (cartanGraph B).Adj i j ↔ i ≠ j ∧ B i j < 0 := by
  rw [cartanGraph, SimpleGraph.fromRel_adj]
  constructor
  · rintro ⟨hij, h | h⟩
    · exact ⟨hij, h⟩
    · exact ⟨hij, (cartan_negative_comm hB hij).mpr h⟩
  · rintro ⟨hij, h⟩
    exact ⟨hij, Or.inl h⟩

end Opac018
