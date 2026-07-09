from pathlib import Path


def test_required_review_files_exist():
    required = [
        "START_REVIEW_HERE.md",
        "DEPENDENCY_TABLE.md",
        "docs/FORMAL_ASSUMPTIONS.md",
        "docs/LITERATURE_COMPARISON.md",
        "docs/DEPENDENCY_GRAPH.md",
        "examples/example_A5.md",
        "examples/example_C6.md",
        "examples/example_D5.md",
    ]
    for rel in required:
        assert Path(rel).exists(), rel


def test_truth_boundary_present_in_key_files():
    key_files = ["README.md", "CLAIMS_AND_NONCLAIMS.md", "START_REVIEW_HERE.md"]
    for rel in key_files:
        text = Path(rel).read_text(encoding="utf-8")
        assert "SOLUTION-CANDIDATE / EXTERNAL REVIEW PENDING" in text


def test_examples_contain_expected_fractions():
    assert "4/3" in Path("examples/example_A5.md").read_text(encoding="utf-8")
    assert "3/2" in Path("examples/example_C6.md").read_text(encoding="utf-8")
    assert "3/2" in Path("examples/example_D5.md").read_text(encoding="utf-8")
