# Worked Example: Type A5 with Two Blocks of Size 3 and 3

## Setup

Take a Type A system with six coordinate labels. Split the active graph into two balanced blocks:

```text
B1 = {1,2,3}, |B1| = 3
B2 = {4,5,6}, |B2| = 3
```

Choose a crossing root:

```text
alpha = e1 - e4
```

## Projection

The component-wise zero-sum projection is

```text
pi(alpha) = (e1 - (e1+e2+e3)/3) - (e4 - (e4+e5+e6)/3)
```

Coordinates on `B1` are:

```text
2/3, -1/3, -1/3
```

Coordinates on `B2` are:

```text
-2/3, 1/3, 1/3
```

## Gauge

The total `l1` norm is

```text
(2/3 + 1/3 + 1/3) + (2/3 + 1/3 + 1/3) = 8/3
```

The Type A block gauge is `1/2 ||.||_1`, so

```text
kappa = 1/2 * 8/3 = 4/3
```

The formula gives the same value:

```text
2 - 1/3 - 1/3 = 4/3 < 2
```

## Code check

```python
from csl.opac_engine import verify_classical_opac_bounds
print(verify_classical_opac_bounds("A", [3, 3], 5)["kappa_rational"])
# 4/3
```
