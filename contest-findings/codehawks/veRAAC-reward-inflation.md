# Incorrect Reward Calculation in FeeCollector.sol

## Title
Reward Inflation via Post-Distribution Voting Power Manipulation

## Platform
CodeHawks

## Contest
Core Contracts - Regnum Aurum Acquisition Corp (Feb 3, 2025 to Feb 24, 2025)

## Protocol
Regnum Aurum Acquisition Corp (Core Contracts)

## Severity
High

## Submission Metadata
- Researcher: Natachi
- Submission reference: not recorded in local notes
- Source: submission reference available in researcher records
- Status: Verified

## Summary
Reward accounting uses current veRAAC voting power to distribute cumulative historical rewards. Attackers can lock tokens after distribution events and still claim a disproportionate share of past rewards.

## Root Cause
Historical distributions are tracked cumulatively (`totalDistributed`) without storing per-period snapshots of user and total voting power. Reward calculations then read current balances (`getVotingPower`) instead of historical state.

## Vulnerability Details
In `_calculatePendingRewards`:
- `userVotingPower` and `totalVotingPower` are fetched from current state.
- Share is computed against `totalDistributed` (historical aggregate).

In `_processDistributions`:
- Distribution shares are aggregated into one cumulative variable.
- Epoch context required for fair attribution is lost.

This temporal mismatch enables late entrants to claim from prior reward periods.

## Impact
- Attackers can back-claim rewards from periods they did not participate in.
- Legitimate long-term participants are diluted.
- Reward integrity and economic fairness are compromised.

## Proof of Concept
The submitted Hardhat PoC demonstrates:
- Legitimate user locks before fee distribution.
- Attacker locks a larger amount only after distribution.
- Attacker still receives significant pending rewards from historical distributions.

## Recommended Mitigation
- Track rewards per distribution epoch.
- Snapshot user voting power and total voting power at each epoch.
- Compute claims per epoch (or via time-weighted stake), not from current balances.
