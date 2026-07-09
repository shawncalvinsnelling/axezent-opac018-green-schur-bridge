# Worked Example: Type C6 with One Balanced Block of Size 4

## Setup

Consider a Type C envelope calculation where the largest active balanced block has size

```text
b1 = 4
```

The representative long-axis projection is encoded by the single-block formula.

## Formula

```text
kappa = max(1, 2 - 2/b1)
```

For `b1 = 4`, this gives

```text
kappa = 2 - 2/4 = 3/2 < 2
```

## Margin

```text
2 - kappa = 2 - 3/2 = 1/2
```

The strict finite-rank margin is positive.

## Code check

```python
from csl.opac_engine import verify_classical_opac_bounds
print(verify_classical_opac_bounds("C", [4], 6)["kappa_rational"])
# 3/2
```
