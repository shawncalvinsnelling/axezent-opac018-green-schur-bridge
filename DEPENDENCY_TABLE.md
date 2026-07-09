# Theorem Dependency Table

This table is a reviewer navigation layer. It is intentionally conservative: each dependency should be independently checked against the manuscript and cited literature.

| Result or module | Depends on | Reviewer check |
|---|---|---|
| Root-polytope projection setup | Euclidean projection, root polytope definition, Minkowski gauge | Verify definitions match the target OPAC-018 setting. |
| Type A two-block formula | Component partition, zero-sum projection, Type A gauge identity | Recompute the projection and `1/2 ||.||_1` gauge. |
| Type C single-block envelope | Cross-polytope hull, long-axis projection, `1/2 ||.||_1` gauge | Confirm long-root normalization and block-size hypothesis. |
| Type B envelope | Short-axis cases plus non-simply-laced normalization | Verify no Type B-specific configuration is omitted. |
| Type D envelope | Signed-graph balanced/unbalanced components | Verify exhaustive case split and gauge transition. |
| Classical horizon statement | Type A/B/C/D formulas and finite block sizes | Confirm each family is covered only under stated assumptions. |
| Exact audit scripts | `Fraction`, integer cross-products, deterministic examples | Confirm no proof-critical float comparison is used. |
| Negative controls | Malformed cases, boundary cases, unsupported families | Confirm bad cases fail or are labeled unsupported. |
| Manifest/receipts | SHA-256 digest generation and deterministic JSON outputs | Confirm receipts reproduce after clean checkout. |

## Current status

The dependency chain is prepared for external review. A passing CI run means the repository is internally consistent; it does not replace independent mathematical validation.
