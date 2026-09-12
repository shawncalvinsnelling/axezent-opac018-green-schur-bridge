import Opac018UniformProof.MaximumPrinciple
import Opac018UniformProof.CartanColumn
import Mathlib

open Matrix
open scoped BigOperators

namespace Opac018

noncomputable section

variable {ι : Type*} [Fintype ι] [DecidableEq ι] [Nonempty ι]

/--
Construct the weighted maximum-principle data directly from a finite Cartan
matrix, a positive dominant mark vector, and Dynkin-graph connectivity.

The normalized coordinates use Mathlib's canonical nonsingular inverse `B⁻¹`,
so the result is independent of any particular `Invertible B` instance.
-/
def finiteCartanWeightedData
    (Bz : Matrix ι ι ℤ) (hB : Bz.IsFiniteCartan)
    (hpre : (cartanGraph Bz).Preconnected)
    (m : ι → ℝ) (hm_pos : ∀ k, 0 < m k)
    (hdom : ∀ k, 0 ≤ ∑ j, m j * (Bz j k : ℝ))
    (pivot : ι) :
    WeightedMaximumPrincipleData (cartanGraph Bz) := by
  classical
  let B : Matrix ι ι ℝ := Bz.map (Int.cast : ℤ → ℝ)
  have hBdet_pos : 0 < B.det := by
    dsimp [B]
    rw [← (Int.castRingHom ℝ).map_det Bz]
    exact_mod_cast hB.det_pos
  have hBunit : IsUnit B.det := Ne.isUnit hBdet_pos.ne'
  refine
    { pivot := pivot
      y := fun j => B⁻¹ pivot j / m j
      m := m
      a := fun j k => -m j * B j k
      preconnected := hpre
      m_pos := hm_pos
      edgeWeight_pos := ?_
      residual_nonneg := ?_
      balance := ?_ }
  · intro j k hjk
    have hnegZ : Bz j k < 0 := ((cartanGraph_adj_iff hB j k).1 hjk).2
    have hnegR : B j k < 0 := by
      dsimp [B]
      exact_mod_cast hnegZ
    have hprod : m j * B j k < 0 := mul_neg_of_pos_of_neg (hm_pos j) hnegR
    have : 0 < -(m j * B j k) := neg_pos.mpr hprod
    convert this using 1 <;> ring
  · intro k
    have hcol := finiteCartan_column_sum_eq_diag_add_neighbors hB m k
    have hcolB :
        (∑ j, m j * B j k) =
          2 * m k +
            ∑ j ∈ (cartanGraph Bz).neighborFinset k, m j * B j k := by
      simpa [B] using hcol
    have hsumneg :
        (∑ j ∈ (cartanGraph Bz).neighborFinset k, -m j * B j k) =
          -(∑ j ∈ (cartanGraph Bz).neighborFinset k, m j * B j k) := by
      calc
        (∑ j ∈ (cartanGraph Bz).neighborFinset k, -m j * B j k)
            = ∑ j ∈ (cartanGraph Bz).neighborFinset k, -(m j * B j k) := by
                apply Finset.sum_congr rfl
                intro j _hj
                ring
        _ = -(∑ j ∈ (cartanGraph Bz).neighborFinset k, m j * B j k) := by simp
    have hresEq :
        2 * m k -
            ∑ j ∈ (cartanGraph Bz).neighborFinset k, -m j * B j k =
          ∑ j, m j * B j k := by
      rw [hsumneg]
      linarith
    rw [hresEq]
    simpa [B] using hdom k
  · intro k
    let x : ι → ℝ := fun j => B⁻¹ pivot j
    have hrow :
        (∑ j, x j * B j k) = if k = pivot then 1 else 0 := by
      have h := congrArg (fun M : Matrix ι ι ℝ => M pivot k)
        (Matrix.nonsing_inv_mul B hBunit)
      simpa [x, Matrix.mul_apply, eq_comm] using h
    have hcol := finiteCartan_column_sum_eq_diag_add_neighbors hB x k
    have hcolB :
        (∑ j, x j * B j k) =
          2 * x k +
            ∑ j ∈ (cartanGraph Bz).neighborFinset k, x j * B j k := by
      simpa [x, B] using hcol
    have hmy : ∀ j, m j * (x j / m j) = x j := by
      intro j
      calc
        m j * (x j / m j) = x j * m j / m j := by ring
        _ = x j := mul_div_cancel_right₀ (x j) (hm_pos j).ne'
    have hsumdiff :
        (∑ j ∈ (cartanGraph Bz).neighborFinset k,
            (-m j * B j k) * (x k / m k - x j / m j)) =
          (∑ j ∈ (cartanGraph Bz).neighborFinset k, -m j * B j k) *
              (x k / m k) -
            ∑ j ∈ (cartanGraph Bz).neighborFinset k,
              (-m j * B j k) * (x j / m j) := by
      calc
        (∑ j ∈ (cartanGraph Bz).neighborFinset k,
            (-m j * B j k) * (x k / m k - x j / m j))
            = ∑ j ∈ (cartanGraph Bz).neighborFinset k,
                ((-m j * B j k) * (x k / m k) -
                  (-m j * B j k) * (x j / m j)) := by
                    apply Finset.sum_congr rfl
                    intro j _hj
                    ring
        _ = (∑ j ∈ (cartanGraph Bz).neighborFinset k,
                (-m j * B j k) * (x k / m k)) -
              ∑ j ∈ (cartanGraph Bz).neighborFinset k,
                (-m j * B j k) * (x j / m j) := by
              rw [Finset.sum_sub_distrib]
        _ = (∑ j ∈ (cartanGraph Bz).neighborFinset k, -m j * B j k) *
                (x k / m k) -
              ∑ j ∈ (cartanGraph Bz).neighborFinset k,
                (-m j * B j k) * (x j / m j) := by
              rw [Finset.sum_mul]
    have hsumay :
        (∑ j ∈ (cartanGraph Bz).neighborFinset k,
            (-m j * B j k) * (x j / m j)) =
          -(∑ j ∈ (cartanGraph Bz).neighborFinset k, x j * B j k) := by
      calc
        (∑ j ∈ (cartanGraph Bz).neighborFinset k,
            (-m j * B j k) * (x j / m j))
            = ∑ j ∈ (cartanGraph Bz).neighborFinset k,
                -(x j * B j k) := by
                    apply Finset.sum_congr rfl
                    intro j _hj
                    calc
                      (-m j * B j k) * (x j / m j)
                          = -(B j k * (m j * (x j / m j))) := by ring
                      _ = -(B j k * x j) := by rw [hmy j]
                      _ = -(x j * B j k) := by ring
        _ = -(∑ j ∈ (cartanGraph Bz).neighborFinset k, x j * B j k) := by simp
    have hrhs :
        (2 * m k -
              ∑ j ∈ (cartanGraph Bz).neighborFinset k, -m j * B j k) *
              (x k / m k) +
            ∑ j ∈ (cartanGraph Bz).neighborFinset k,
              (-m j * B j k) * (x k / m k - x j / m j) =
          2 * x k +
            ∑ j ∈ (cartanGraph Bz).neighborFinset k, x j * B j k := by
      rw [hsumdiff]
      calc
        (2 * m k -
              ∑ j ∈ (cartanGraph Bz).neighborFinset k, -m j * B j k) *
              (x k / m k) +
            ((∑ j ∈ (cartanGraph Bz).neighborFinset k, -m j * B j k) *
                (x k / m k) -
              ∑ j ∈ (cartanGraph Bz).neighborFinset k,
                (-m j * B j k) * (x j / m j))
            = 2 * (m k * (x k / m k)) -
                ∑ j ∈ (cartanGraph Bz).neighborFinset k,
                  (-m j * B j k) * (x j / m j) := by ring
        _ = 2 * x k +
              ∑ j ∈ (cartanGraph Bz).neighborFinset k, x j * B j k := by
              rw [hmy k, hsumay]
              ring
    calc
      (if k = pivot then 1 else 0) = ∑ j, x j * B j k := hrow.symm
      _ = 2 * x k +
            ∑ j ∈ (cartanGraph Bz).neighborFinset k, x j * B j k := hcolB
      _ = (2 * m k -
              ∑ j ∈ (cartanGraph Bz).neighborFinset k, -m j * B j k) *
              (x k / m k) +
            ∑ j ∈ (cartanGraph Bz).neighborFinset k,
              (-m j * B j k) * (x k / m k - x j / m j) := hrhs.symm

/-- The data's normalized coordinates are literally the canonical inverse row divided by marks. -/
@[simp] theorem finiteCartanWeightedData_y
    (Bz : Matrix ι ι ℤ) (hB : Bz.IsFiniteCartan)
    (hpre : (cartanGraph Bz).Preconnected)
    (m : ι → ℝ) (hm_pos : ∀ k, 0 < m k)
    (hdom : ∀ k, 0 ≤ ∑ j, m j * (Bz j k : ℝ))
    (pivot j : ι) :
    (finiteCartanWeightedData Bz hB hpre m hm_pos hdom pivot).y j =
      (Bz.map (Int.cast : ℤ → ℝ))⁻¹ pivot j / m j := by
  rfl

end

end Opac018
