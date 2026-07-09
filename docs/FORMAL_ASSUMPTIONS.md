# Formal Assumptions

The following assumptions define the current review boundary.

## Ambient setup

- The ambient vector space is a finite-dimensional real Euclidean space with the standard inner product unless a manuscript section explicitly states another metric.
- `Phi` denotes a finite classical root system in the stated scope.
- `P_Phi = conv(Phi)` denotes the root polytope.
- `U` denotes a nonzero root-spanned subspace in the stated scope.
- `Psi = Phi cap U` denotes the induced sub-root configuration used for the gauge.

## Projection setup

- `pi_U` is the orthogonal projection onto `U` under the metric stated in the relevant section.
- Block sizes are finite positive integers.
- Active balanced blocks used in Type A-like formulas have size at least 2.

## Gauge setup

- The identity `gamma(y) = 1/2 ||y||_1` is used only where the component geometry supports it, such as zero-sum Type A components or cross-polytope Type C components under the stated normalization.
- For mixed or non-simply-laced cases, the manuscript must explicitly justify the normalization before applying an inherited gauge formula.

## Software setup

- The software uses `fractions.Fraction` for exact rational arithmetic.
- Floating-point values may be printed for readability but are not used for proof-critical comparisons.
- Passing tests indicate internal consistency with encoded formulas, not independent theorem acceptance.

## Exclusions

- Exceptional families are not certified by this package unless a future release adds explicit proofs and tests.
- Oblique subspaces outside the stated root-spanned/component-normalized scope are not automatically covered.
