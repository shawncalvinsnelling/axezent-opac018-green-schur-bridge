# Formal-verification boundary

The mathematical theorem is currently `PROVED_EXACT` in the project ledger, but the full signed-graph / root-polytope / orthogonal-projection proof has not yet been kernel-checked in Lean.

This directory deliberately separates a machine-checked arithmetic kernel from the still-unformalized geometric dependencies. A passing arithmetic build must **not** be relabeled `FORMALLY_VERIFIED` for the full theorem.

Formalization order for the complete theorem:

1. finite-support signed component definitions;
2. switching equivalence;
3. balanced component -> zero-sum hyperplane;
4. unbalanced component -> full support;
5. Type-C root polytope = l1 ball radius 2;
6. induced subsystem description;
7. Minkowski gauge on A and C components;
8. direct-sum gauge additivity;
9. orthogonal projection formulas;
10. long-root and short-root score table;
11. exact kappa theorem;
12. global extremal corollary.

Only after all 12 compile with no `sorry`, no project-specific axioms, and an independent checker should AXZ-OPAC-016 be promoted to `FORMALLY_VERIFIED`.
