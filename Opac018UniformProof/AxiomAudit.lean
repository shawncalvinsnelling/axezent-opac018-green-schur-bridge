import Opac018UniformProof.RootFamilyClosure

/--
CI-visible kernel dependency receipt for the strongest root-family closure theorem.
This command does not add assumptions; it asks Lean to print which axioms the
compiled theorem depends on so reviewers can distinguish standard Lean/Mathlib
foundations from project-local assumptions.  Project-local `axiom` declarations
are separately rejected by `tests/test_no_lean_placeholders.py`.
-/
#print axioms Opac018.opac018_root_family_closure
