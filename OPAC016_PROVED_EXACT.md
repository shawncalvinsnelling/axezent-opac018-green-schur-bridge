# AXZ-OPAC-016 — Type-C Signed-Component Exact Kappa Lemma

**Author / project owner:** Shawn Calvin Snelling  
**Internal theorem ID:** `AXZ-OPAC-016`  
**Truth-gate status:** **PROVED_EXACT**  
**Scope:** all finite ranks `C_n`, including `n=1`, and every nonzero root-spanned subspace `U`  
**Not promoted to:** `FORMALLY_VERIFIED`, `EXTERNALLY_REPLICATED`  
**Important:** this theorem is one Type-C dependency and **does not by itself solve global OPAC-018**.

## Frozen statement

Let

\[
\Phi=C_n=\{\pm2e_i:1\le i\le n\}\cup\{\pm e_i\pm e_j:1\le i<j\le n\}
\]

with root polytope \(P_\Phi=\operatorname{conv}(\Phi)\). Let \(0\ne U\subseteq\mathbb R^n\) be spanned by roots and let \(\Psi=\Phi\cap U\). Define

\[
\kappa(C_n,U)=\inf\{\kappa\ge1:\pi_U(P_\Phi)\subseteq \kappa P_\Psi\}.
\]

Write the canonical signed-component normal form

\[
U=\mathbb R^F\oplus H_{B_1,s^{(1)}}\oplus\cdots\oplus H_{B_m,s^{(m)}},
\]

where \(F\) is the union of full/unbalanced supports, the \(B_j\) are pairwise disjoint balanced supports of sizes \(b_j\ge2\), ordered \(b_1\ge\cdots\ge b_m\), and

\[
H_{B,s}=\left\{x:\operatorname{supp}(x)\subseteq B,\ \sum_{i\in B}s_i x_i=0\right\},\qquad s_i\in\{\pm1\}.
\]

Then

\[
\boxed{
\kappa(C_n,U)=
\begin{cases}
1,&m=0,\\[2mm]
\max\left(1,2-\dfrac2{b_1}\right),&m\ge1.
\end{cases}}
\]

Since \(b_1\ge2\), in the nontrivial balanced case this equals \(2-2/b_1\). Hence

\[
\boxed{\kappa(C_n,U)<2}
\]

for every finite rank. For \(C_1\), the only nonzero root-spanned subspace is the full line and \(\kappa=1\).

## Proof

### 1. Type-C root polytope

The long roots \(\pm2e_i\) are the vertices of the radius-2 cross-polytope

\[
K=\{x:\|x\|_1\le2\}.
\]

Every short root \(\pm e_i\pm e_j\) has \(\ell_1\)-norm 2, so it lies in \(K\). Therefore

\[
P_{C_n}=K=\{x:\|x\|_1\le2\}.
\]

### 2. Signed-component normal form

Represent a short root \(e_i-e_j\) or \(e_i+e_j\) as a signed edge on \(i,j\), and a long root \(2e_i\) as a coordinate long-axis generator. On each connected support component:

- If the signed component is balanced and contains no long-axis generator, switching coordinates by signs \(s_i\in\{\pm1\}\) makes a spanning set of edges ordinary differences \(e_i-e_j\). Connectivity gives the full zero-sum hyperplane on that support, of dimension \(b-1\).
- If the component is unbalanced, a spanning tree gives that zero-sum hyperplane and one unbalanced extra edge has nonzero coordinate sum after switching. It supplies the missing dimension, so the component spans its full coordinate space.
- If a long root \(2e_i\) occurs, the connected edge span together with \(e_i\) again spans the full coordinate space on that support.

The full supports may be merged into one coordinate set \(F\), yielding the displayed direct-sum normal form.

### 3. Subsystem polytope and gauge

On \(F\), \(\Psi\) contains the complete Type-C subsystem, whose root polytope is

\[
\{y\in\mathbb R^F:\|y\|_1\le2\}.
\]

On a balanced block \(B\), switching is an isometry and the roots in \(\Psi\) form an \(A_{b-1}\) system. Its root polytope is

\[
\{y\in H_{B,s}:\|y\|_1\le2\}.
\]

For zero-sum \(y\), positive and negative masses both equal \(\|y\|_1/2\); a transportation decomposition writes \(y\) as a nonnegative combination of roots with total coefficient \(\|y\|_1/2\).

Because component supports are disjoint and \(P_\Psi\) is the convex hull of the component root polytopes, the Minkowski gauge is the sum of the component gauges. Hence for every \(y\in U\),

\[
\gamma_\Psi(y)=\frac12\|y\|_1.
\]

Thus

\[
\kappa(C_n,U)=\max_{\alpha\in C_n}\frac12\|\pi_U\alpha\|_1.
\]

### 4. Orthogonal projection on a balanced block

After switching a balanced block to ordinary zero-sum form, the orthogonal projection on a block \(B\) of size \(b\) is

\[
Q_Bx=x_B-\frac{\sum_{i\in B}x_i}{b}\mathbf1_B.
\]

On \(F\), projection is the identity; on inactive coordinates it is zero.

### 5. Long roots attain the proposed maximum

For \(\alpha=2e_i\):

- If \(i\in F\), its gauge is 1.
- If \(i\in B\) with \(|B|=b\), then

  \[
  Q_B(2e_i)=2\left(e_i-\frac1b\mathbf1_B\right),
  \]

  whose \(\ell_1\)-norm is \(4-4/b\), so its gauge is

  \[
  2-\frac2b.
  \]

- If \(i\) is inactive, the gauge is 0.

Therefore a long root in a largest balanced block attains \(2-2/b_1\).

### 6. Every short-root case is no larger

For a short root \(\pm e_i\pm e_j\), switching signs preserves the Type-C root set and the \(\ell_1\)-norm. The possible placements give:

- both indices in \(F\): gauge \(1\);
- one in \(F\), one in a balanced block of size \(b\): gauge \(3/2-1/b\);
- indices in two balanced blocks of sizes \(b,c\): gauge \(2-1/b-1/c\);
- both in the same balanced block: compatible-sign gauge \(1\), incompatible-sign gauge \(\max(0,2-4/b)\);
- balanced plus inactive: gauge \(1-1/b\);
- full plus inactive: gauge \(1/2\);
- both inactive: gauge \(0\).

Since every balanced size is at most \(b_1\), all of these are bounded above by

\[
\max\left(1,2-\frac2{b_1}\right).
\]

The long root in the largest balanced block attains that value. If there is no balanced block, \(U\ne0\) implies a full component exists, and a subsystem root attains gauge 1. This proves the formula. \(\square\)

## Verification evidence

The theorem is symbolic; finite computation is corroborative, not the source of universality.

Executed project-side verification recorded:

- exhaustive nonzero root-spanned subspaces through `C_5`: **790**;
- exhaustive projected-root checks: **36,484**;
- random exact higher-rank projected-root checks: **34,728**;
- independent LP projected-root optimizations: **5,416**;
- aggregate projected-root checks: **76,628**;
- formula/gauge mismatches: **0**;
- extreme balanced block sizes checked through `1,000,000,000`, all with positive exact margin to 2.

The existing OPAC repository audit suite also passes its encoded exact-rational formula, negative-control, test, manifest, and SHA layers at the recorded current baseline. Those software checks support reproducibility but do not substitute for the proof above.

## Truth boundary

Accepted project label:

`PROVED_EXACT / UNIVERSAL_FINITE_RANK_TYPE_C / NOT_YET_FORMALLY_VERIFIED / NOT_EXTERNALLY_REPLICATED`

Not claimed:

- global OPAC-018 solved;
- Lean/Rocq/Isabelle/HOL formal verification;
- independent referee acceptance;
- journal acceptance;
- publication-level novelty or priority.

The signed-graph ingredients are classical. This document records the exact standalone OPAC-016 theorem and its project truth gate.