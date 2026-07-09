# Known Failure Modes

The stress tests reject:

- equality boundary at `kappa = 2`;
- denominator zero;
- negative denominator;
- malformed rational witness;
- type label outside the audited family;
- floating-point input pretending to be exact;
- missing strict margin;
- unsupported transfer claim.
