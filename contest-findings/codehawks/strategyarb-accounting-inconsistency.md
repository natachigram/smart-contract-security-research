# Inconsistent Accounting in StrategyArb._harvestAndReport

## Title
Mixed-Unit Asset Aggregation and Missing Claim/Swap in `_harvestAndReport`

## Platform
CodeHawks

## Contest
Alchemix Transmuter (Dec 16, 2024 to Dec 23, 2024)

## Protocol
Alchemix Transmuter (StrategyArb)

## Severity
Medium

## Submission Metadata
- Researcher: Natachi
- Submission reference: not recorded in local notes
- Source: submission reference available in researcher records
- Status: Verified

## Summary
`_harvestAndReport` computes total assets using inconsistent state and mixed units. Claimable underlying is not atomically claimed/swapped into asset units before inclusion, resulting in inaccurate strategy reporting.

## Root Cause
The reporting path does not enforce a consistent valuation pipeline:
- claimable underlying may remain unclaimed;
- underlying and asset balances are aggregated without normalization.

## Vulnerability Details
The function:
- reads claimable underlying from transmuter,
- leaves `transmuter.claim(...)` commented out,
- sums unexchanged asset + asset balance + underlying balance directly.

This can materially distort `_totalAssets` because mixed asset units and claim state are combined in one scalar.

## Impact
- Inaccurate performance and asset reporting.
- Potentially unsafe behavior if `_totalAssets` is later used in critical on-chain decisions.
- Increased operational and accounting risk.

## Proof of Concept
In a state with non-zero claimable underlying, invoking `_harvestAndReport` without claim/swap normalization produces totals that do not match economically realizable asset value.

## Recommended Mitigation
- Claim underlying and swap to asset atomically inside `_harvestAndReport`.
- Normalize all components into one accounting unit before aggregation.
- Add invariant tests for report consistency.
