# Fee-on-Transfer Token Vulnerability in Treasury Deposits

## Title
`Treasury.deposit` Overstates Balances for Fee-on-Transfer Tokens

## Platform
CodeHawks

## Contest
Core Contracts - Regnum Aurum Acquisition Corp (Feb 3, 2025 to Feb 24, 2025)

## Protocol
Regnum Aurum Acquisition Corp (Core Contracts)

## Severity
Medium

## Submission Metadata
- Researcher: 0xnatachi
- Submission reference: not recorded in local notes
- Source: pending public submission URL
- Status: Pending Verification

## Summary
The treasury records the user-requested `amount` as received without verifying actual token inflow. For fee-on-transfer tokens, received amount is lower than requested amount, causing internal accounting inflation.

## Root Cause
`deposit()` increments `_balances[token]` and `_totalValue` by input amount rather than by actual post-transfer balance delta.

## Vulnerability Details
Current flow:
- Execute `transferFrom(msg.sender, address(this), amount)`.
- Increase internal accounting by `amount` unconditionally.

For fee-on-transfer tokens, treasury receives less than `amount` while recording full value.

## Impact
- Overstated treasury balances.
- Withdrawal or allocation actions may fail against insufficient real balances.
- Financial reporting and reserve assumptions become inconsistent.

## Proof of Concept
For a token charging 1% transfer fee:
- Deposit request: 100 tokens.
- Actual received: 99 tokens.
- Recorded internal value: 100 tokens.

Repeated deposits compound accounting drift.

## Recommended Mitigation
Use pre/post balance accounting and record `received` amount only:

```solidity
uint256 beforeBal = IERC20(token).balanceOf(address(this));
IERC20(token).transferFrom(msg.sender, address(this), amount);
uint256 received = IERC20(token).balanceOf(address(this)) - beforeBal;
_balances[token] += received;
_totalValue += received;
```
