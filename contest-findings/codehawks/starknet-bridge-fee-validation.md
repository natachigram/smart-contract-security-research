# Lack of msg.value Validation and Fee Estimation in RewardSupplier.tick()

## Title
Bridge Fee Handling in `tick()` Risks Underpayment Reverts and Overpayment Loss

## Platform
CodeHawks

## Contest
Starknet KYC Rewards (Sep 16, 2024 to Oct 4, 2024)

## Protocol
Starknet KYC Rewards (RewardSupplier)

## Severity
Medium

## Submission Metadata
- Researcher: 0xnatachi
- Submission reference: not recorded in local notes
- Source: submission reference available in researcher records
- Status: Verified

## Summary
`tick()` forwards full `msg.value` to bridge deposit without validating required fee or handling surplus. Dynamic Starknet/L1 fee conditions make this unsafe for users.

## Root Cause
No fee-estimation and no payment validation/refund controls around `depositWithMessage{value: msg.value}`.

## Vulnerability Details
Current flow forwards user-provided ETH directly:
- If value is too low, operation can fail.
- If value is too high, excess value can become irrecoverable depending on bridge behavior.

Because required bridge fees vary by network conditions and message characteristics, users cannot reliably choose an exact payment without helper logic.

## Impact
- Underpayment can cause transaction failures.
- Overpayment can lead to irreversible user losses.
- Bridge-driven reward operations become less reliable.

## Proof of Concept
Call `tick()` with:
- insufficient `msg.value` and observe failure;
- excessive `msg.value` and observe no protocol refund path for surplus.

## Recommended Mitigation
- Provide a view function to estimate required bridge fee.
- Validate minimum payment before bridging.
- Refund safe surplus to caller.
- Emit fee accounting events for observability.
