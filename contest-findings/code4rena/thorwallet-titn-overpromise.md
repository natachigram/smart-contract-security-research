# Over-Promising TITN Tokens Due to Inadequate Balance Checks

## Title
`MergeTgt` Can Promise More TITN Than Contract Holds

## Platform
Code4rena

## Contest
THORWallet

## Protocol
THORWallet (MergeTgt)

## Severity
High

## Submission Metadata
- Researcher: 0xnatachi
- Submission reference: `F-6 / S-686`
- Source: submission reference available in researcher records
- Status: Verified

## Summary
`quoteTitn()` computes `titnOut` using a fixed conversion formula, and `onTokenTransfer()` increases `totalTitnClaimable` without enforcing that cumulative promises are backed by actual TITN reserves.

## Root Cause
Missing solvency check between new promised TITN liabilities and current contract-held TITN reserves.

## Vulnerability Details
Promised amount formula:

```text
titnOut = (tgtAmount × TITN_ARB) / TGT_TO_EXCHANGE
```

The contract increases aggregate claimable obligations without validating reserve sufficiency. If incoming TGT volume exceeds projected capacity, liabilities can outgrow assets.

## Impact
- User claims can revert due to insufficient TITN reserves.
- Contract exposes insolvency between promised and redeemable balances.
- Redemption reliability depends on reactive admin top-ups.

## Proof of Concept
Deposit TGT beyond expected conversion capacity and compare:
- `totalTitnClaimable` (liabilities)
- `TITN.balanceOf(address(this))` (assets)

When liabilities exceed assets, claim transactions fail.

## Recommended Mitigation
Enforce solvency in `onTokenTransfer()`:

```solidity
require(totalTitnClaimable + titnOut <= TITN.balanceOf(address(this)), "insufficient TITN reserves");
```

Optionally add intake caps and solvency-ratio monitoring events.
