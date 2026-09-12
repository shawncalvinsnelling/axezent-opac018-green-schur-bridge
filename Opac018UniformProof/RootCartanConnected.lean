import Opac018UniformProof.CartanGraph
import Mathlib.LinearAlgebra.RootSystem.CartanMatrix

namespace Opac018

noncomputable section

variable {ι R M N : Type*}
variable [CommRing R] [IsDomain R] [CharZero R]
variable [AddCommGroup M] [Module R M] [AddCommGroup N] [Module R N]
variable {P : RootPairing ι R M N} [Finite ι]
variable [P.IsCrystallographic] [P.IsRootSystem]

/--
The Cartan graph of the simple system of a reduced irreducible root pairing is
preconnected.  This packages Mathlib's `induction_on_cartanMatrix` as the graph
connectivity fact required by the weighted maximum principle.
-/
theorem base_cartanGraph_preconnected
    [P.IsReduced] [P.IsIrreducible] (b : P.Base) :
    (cartanGraph b.cartanMatrix).Preconnected := by
  classical
  let hB : b.cartanMatrix.IsFiniteCartan := b.cartanMatrix_isFiniteCartan
  intro i j
  apply b.induction_on_cartanMatrix
    (p := fun k : b.support => (cartanGraph b.cartanMatrix).Reachable i k)
    (SimpleGraph.Reachable.refl i)
  intro u v huv hvu
  by_cases hvu_eq : v = u
  · simpa [hvu_eq] using huv
  have hvu_le : b.cartanMatrix v u ≤ 0 :=
    hB.offDiag_nonpos v u hvu_eq
  have hvu_neg : b.cartanMatrix v u < 0 :=
    lt_of_le_of_ne hvu_le hvu
  have hadj_vu : (cartanGraph b.cartanMatrix).Adj v u :=
    (cartanGraph_adj_iff hB v u).2 ⟨hvu_eq, hvu_neg⟩
  exact huv.trans hadj_vu.symm.reachable

end

end Opac018
