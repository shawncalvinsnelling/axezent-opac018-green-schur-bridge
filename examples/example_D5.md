# Worked Example: Type D5 Balanced-Block Envelope

## Setup

Use a conservative Type D envelope check with one dominant balanced block of size

```text
b1 = 4
```

The software uses the encoded classical envelope

```text
kappa <= max(1, 2 - 2/b1)
```

for Type D in this release.

## Calculation

```text
kappa <= 2 - 2/4 = 3/2 < 2
```

## Review warning

This example checks the encoded envelope, not the entire Type D proof by itself. A mathematical reviewer should still verify the signed-graph case split and the transition from the Type D component geometry into this envelope.

## Code check

```python
from csl.opac_engine import verify_classical_opac_bounds
print(verify_classical_opac_bounds("D", [4], 5)["kappa_rational"])
# 3/2
```
