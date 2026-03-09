# Flawed Logic in ShareManager Inverts Transfer Whitelist Behavior

## Title
Flawed Logic in `ShareManager.updateChecks` Inverts Transfer Whitelist Behavior

## Platform
Sherlock

## Contest
2025-07 Mellow Flexible Vaults

## Protocol
Mellow Flexible Vaults

## Severity
Medium

## Submission Metadata
- Researcher: Natachi
- Submission reference: `#26`
- Source: `https://github.com/sherlock-audit/2025-07-mellow-flexible-vaults/issues/26`
- Status: Verified

## Summary
`ShareManager.updateChecks` applies inverted boolean logic when transfer whitelist mode is enabled. Instead of allowing whitelisted accounts (`canTransfer == true`), it reverts for those senders and permits non-whitelisted sender/whitelisted receiver combinations, contradicting intended policy and interface documentation.

## Root Cause
A conditional check in `updateChecks` uses the wrong predicate:
- Implemented behavior: revert when sender `canTransfer == true`.
- Intended behavior: revert only when both sender and receiver are not transfer-whitelisted.

## Vulnerability Details
The interface documents `canTransfer` as:
- "Whether the account is allowed to transfer (send or receive) shares when `hasTransferWhitelist` is active."

However, current logic in `ShareManager.sol` effectively blocks whitelisted senders. The associated tests also encode this inverted behavior, allowing the bug to pass validation and making runtime behavior diverge from documentation and operator expectations.

Affected references:
- `flexible-vaults/src/managers/ShareManager.sol` (whitelist check near line 139)
- `ShareManager.t.sol` (tests expecting revert on whitelisted sender path)

## Impact
- Transfer whitelist feature becomes operationally inverted.
- Vault operators can unintentionally block approved transfer participants.
- Security policy enforcement becomes unreliable and operationally risky.

## Proof of Concept
The submitted PoC demonstrates four cases with `hasTransferWhitelist = true`:
- Case 1: both sender/receiver not whitelisted -> revert (expected).
- Case 2: sender whitelisted, receiver not whitelisted -> revert (unexpected).
- Case 3: sender not whitelisted, receiver whitelisted -> pass.
- Case 4: both whitelisted -> revert (unexpected).

## Recommended Mitigation
Revert only when both endpoints are not transfer-whitelisted:

```solidity
// before
if (info.canTransfer || !$.accounts[to].canTransfer) {
    revert TransferNotAllowed(from, to);
}

// after
if (!info.canTransfer && !$.accounts[to].canTransfer) {
    revert TransferNotAllowed(from, to);
}
```

Update tests to enforce intended whitelist semantics and prevent regressions.
