import Mathlib

open scoped BigOperators

namespace Opac018

variable {ι : Type*} [Fintype ι] [DecidableEq ι] [Nonempty ι]
variable (G : SimpleGraph ι) [DecidableRel G.Adj]

/--
Abstract weighted graph data underlying the normalized inverse-Cartan maximum principle.

For the Cartan application, `m` is the positive highest-root mark vector,
`a j k = -m j * B j k` on Dynkin edges, and `y j = (B⁻¹) i j / m j`.
The balance equation is just the inverse-row equation rewritten so every
neighbor term has a visible sign.
-/
structure WeightedMaximumPrincipleData where
  pivot : ι
  y : ι → ℝ
  m : ι → ℝ
  a : ι → ι → ℝ
  preconnected : G.Preconnected
  m_pos : ∀ k, 0 < m k
  edgeWeight_pos : ∀ {j k}, G.Adj j k → 0 < a j k
  residual_nonneg : ∀ k,
    0 ≤ 2 * m k - ∑ j ∈ G.neighborFinset k, a j k
  balance : ∀ k,
    (if k = pivot then 1 else 0) =
      (2 * m k - ∑ j ∈ G.neighborFinset k, a j k) * y k +
        ∑ j ∈ G.neighborFinset k, a j k * (y k - y j)

namespace WeightedMaximumPrincipleData

variable {G}

/-- At a non-pivot global maximum with nonnegative value, every neighbor has the same value. -/
lemma max_neighbor_eq (D : WeightedMaximumPrincipleData G) {k : ι}
    (hkmax : ∀ j, D.y j ≤ D.y k) (hk0 : 0 ≤ D.y k) (hkne : k ≠ D.pivot) :
    ∀ j, G.Adj k j → D.y j = D.y k := by
  intro j hadj
  have hres :
      0 ≤ (2 * D.m k - ∑ l ∈ G.neighborFinset k, D.a l k) * D.y k :=
    mul_nonneg (D.residual_nonneg k) hk0
  have hterms : ∀ l ∈ G.neighborFinset k,
      0 ≤ D.a l k * (D.y k - D.y l) := by
    intro l hl
    have hkl : G.Adj k l := by simpa using hl
    have hal : 0 ≤ D.a l k := (D.edgeWeight_pos hkl.symm).le
    have hdiff : 0 ≤ D.y k - D.y l := sub_nonneg.mpr (hkmax l)
    exact mul_nonneg hal hdiff
  have hsum : 0 ≤ ∑ l ∈ G.neighborFinset k, D.a l k * (D.y k - D.y l) :=
    Finset.sum_nonneg hterms
  have hbal := D.balance k
  rw [if_neg hkne] at hbal
  have hsum0 : ∑ l ∈ G.neighborFinset k, D.a l k * (D.y k - D.y l) = 0 := by
    linarith
  have hjmem : j ∈ G.neighborFinset k := by simpa using hadj
  have hprod : D.a j k * (D.y k - D.y j) = 0 :=
    (Finset.sum_eq_zero_iff_of_nonneg hterms).mp hsum0 j hjmem
  have ha : D.a j k ≠ 0 := ne_of_gt (D.edgeWeight_pos hadj.symm)
  have hdiff : D.y k - D.y j = 0 := (mul_eq_zero.mp hprod).resolve_left ha
  linarith

/-- At a non-pivot negative global minimum, every neighbor has the same value. -/
lemma min_neighbor_eq (D : WeightedMaximumPrincipleData G) {k : ι}
    (hkmin : ∀ j, D.y k ≤ D.y j) (hkneg : D.y k < 0) (hkne : k ≠ D.pivot) :
    ∀ j, G.Adj k j → D.y j = D.y k := by
  intro j hadj
  have hres :
      (2 * D.m k - ∑ l ∈ G.neighborFinset k, D.a l k) * D.y k ≤ 0 :=
    mul_nonpos_of_nonneg_of_nonpos (D.residual_nonneg k) hkneg.le
  have hterms : ∀ l ∈ G.neighborFinset k,
      D.a l k * (D.y k - D.y l) ≤ 0 := by
    intro l hl
    have hkl : G.Adj k l := by simpa using hl
    have hal : 0 ≤ D.a l k := (D.edgeWeight_pos hkl.symm).le
    have hdiff : D.y k - D.y l ≤ 0 := sub_nonpos.mpr (hkmin l)
    exact mul_nonpos_of_nonneg_of_nonpos hal hdiff
  have hsum : ∑ l ∈ G.neighborFinset k, D.a l k * (D.y k - D.y l) ≤ 0 :=
    Finset.sum_nonpos hterms
  have hbal := D.balance k
  rw [if_neg hkne] at hbal
  have hsum0 : ∑ l ∈ G.neighborFinset k, D.a l k * (D.y k - D.y l) = 0 := by
    linarith
  have hjmem : j ∈ G.neighborFinset k := by simpa using hadj
  have hprod : D.a j k * (D.y k - D.y j) = 0 :=
    (Finset.sum_eq_zero_iff_of_nonpos hterms).mp hsum0 j hjmem
  have ha : D.a j k ≠ 0 := ne_of_gt (D.edgeWeight_pos hadj.symm)
  have hdiff : D.y k - D.y j = 0 := (mul_eq_zero.mp hprod).resolve_left ha
  linarith

/-- The distinguished pivot cannot itself be a negative global minimum. -/
lemma pivot_not_negative_min (D : WeightedMaximumPrincipleData G)
    (hpmin : ∀ j, D.y D.pivot ≤ D.y j) (hpneg : D.y D.pivot < 0) : False := by
  have hres :
      (2 * D.m D.pivot - ∑ l ∈ G.neighborFinset D.pivot, D.a l D.pivot) *
          D.y D.pivot ≤ 0 :=
    mul_nonpos_of_nonneg_of_nonpos (D.residual_nonneg D.pivot) hpneg.le
  have hterms : ∀ l ∈ G.neighborFinset D.pivot,
      D.a l D.pivot * (D.y D.pivot - D.y l) ≤ 0 := by
    intro l hl
    have hpl : G.Adj D.pivot l := by simpa using hl
    have hal : 0 ≤ D.a l D.pivot := (D.edgeWeight_pos hpl.symm).le
    exact mul_nonpos_of_nonneg_of_nonpos hal (sub_nonpos.mpr (hpmin l))
  have hsum :
      ∑ l ∈ G.neighborFinset D.pivot,
        D.a l D.pivot * (D.y D.pivot - D.y l) ≤ 0 :=
    Finset.sum_nonpos hterms
  have hbal := D.balance D.pivot
  simp only [if_pos rfl] at hbal
  linarith

/-- Every normalized inverse-row coordinate is nonnegative. -/
theorem nonnegative (D : WeightedMaximumPrincipleData G) : ∀ j, 0 ≤ D.y j := by
  obtain ⟨k, hkmin⟩ := Finite.exists_min D.y
  have hk0 : 0 ≤ D.y k := by
    by_contra hknot
    have hkneg : D.y k < 0 := lt_of_not_ge hknot
    have hpivot_ne : D.y D.pivot ≠ D.y k := by
      intro heq
      have hpmin : ∀ j, D.y D.pivot ≤ D.y j := by
        intro j
        rw [heq]
        exact hkmin j
      have hpneg : D.y D.pivot < 0 := by simpa [heq] using hkneg
      exact D.pivot_not_negative_min hpmin hpneg
    let H : G.Subgraph := (⊤ : G.Subgraph).induce {v | D.y v = D.y k}
    have hkH : k ∈ H.verts := by simp [H]
    have hclosed : ∀ v ∈ H.verts, ∀ w, G.Adj v w → H.Adj v w := by
      intro v hv w hvw
      have hveq : D.y v = D.y k := by simpa [H] using hv
      have hvmin : ∀ j, D.y v ≤ D.y j := by
        intro j
        rw [hveq]
        exact hkmin j
      have hvneg : D.y v < 0 := by simpa [hveq] using hkneg
      have hvne : v ≠ D.pivot := by
        intro hvp
        apply hpivot_ne
        simpa [hvp] using hveq
      have hweqv : D.y w = D.y v := D.min_neighbor_eq hvmin hvneg hvne w hvw
      have hweq : D.y w = D.y k := hweqv.trans hveq
      simp [H, hvw, hveq, hweq]
    have hpH : D.pivot ∈ H.verts :=
      (D.preconnected k D.pivot).mem_subgraphVerts hclosed hkH
    have hpeq : D.y D.pivot = D.y k := by simpa [H] using hpH
    exact hpivot_ne hpeq
  intro j
  exact hk0.trans (hkmin j)

/--
Classification-free normalized inverse-Cartan maximum principle at the weighted-graph level.
The pivot coordinate dominates every normalized inverse-row coordinate.
-/
theorem normalized_maximum (D : WeightedMaximumPrincipleData G) :
    ∀ j, D.y j ≤ D.y D.pivot := by
  have hnonneg := D.nonnegative
  obtain ⟨k, hkmax⟩ := Finite.exists_max D.y
  have hpivot_eq : D.y D.pivot = D.y k := by
    by_contra hpivot_ne
    let H : G.Subgraph := (⊤ : G.Subgraph).induce {v | D.y v = D.y k}
    have hkH : k ∈ H.verts := by simp [H]
    have hclosed : ∀ v ∈ H.verts, ∀ w, G.Adj v w → H.Adj v w := by
      intro v hv w hvw
      have hveq : D.y v = D.y k := by simpa [H] using hv
      have hvmax : ∀ j, D.y j ≤ D.y v := by
        intro j
        rw [hveq]
        exact hkmax j
      have hv0 : 0 ≤ D.y v := hnonneg v
      have hvne : v ≠ D.pivot := by
        intro hvp
        apply hpivot_ne
        simpa [hvp] using hveq
      have hweqv : D.y w = D.y v := D.max_neighbor_eq hvmax hv0 hvne w hvw
      have hweq : D.y w = D.y k := hweqv.trans hveq
      simp [H, hvw, hveq, hweq]
    have hpH : D.pivot ∈ H.verts :=
      (D.preconnected k D.pivot).mem_subgraphVerts hclosed hkH
    exact hpivot_ne (by simpa [H] using hpH)
  intro j
  calc
    D.y j ≤ D.y k := hkmax j
    _ = D.y D.pivot := hpivot_eq.symm

end WeightedMaximumPrincipleData

end Opac018
