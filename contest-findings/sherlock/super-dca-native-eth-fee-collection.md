# Owner Cannot Collect Fees from Native ETH Positions

## Title
`collectFees()` Reverts for Native ETH Pools, Locking Fee Revenue

## Platform
Sherlock

## Contest
2025-09 Super DCA Liquidity Network

## Protocol
Super DCA Liquidity Network

## Severity
High

## Submission Metadata
- Researcher: Natachi
- Submission reference: `#280`
- Submitted on: 2025-10-01 19:17:55 (GMT+1)
- Source: `https://github.com/sherlock-audit/2025-09-super-dca/issues/280`
- Status: Verified

## Summary
`SuperDCAListing.collectFees()` assumes both pool currencies are ERC20 tokens and calls `IERC20.balanceOf()` directly. For native ETH pools (`Currency.unwrap(token) == address(0)`), this path is invalid and fee collection reverts.

## Root Cause
The implementation treats `Currency` as ERC20 unconditionally and does not branch for native ETH handling.

## Vulnerability Details
The function captures recipient balances before/after fee collection via ERC20 calls:

```solidity
uint256 balance0Before = IERC20(Currency.unwrap(token0)).balanceOf(recipient);
uint256 balance1Before = IERC20(Currency.unwrap(token1)).balanceOf(recipient);
```

When either token resolves to `address(0)` (native ETH in Uniswap V4), invoking `IERC20(address(0)).balanceOf(...)` fails. Since listing is permissionless, users can list valid pools that include native ETH, creating positions that accrue fees but cannot be collected through this function.

## Impact
- Fee collection for affected native ETH positions fails.
- Protocol owner loses fee revenue from those listings.
- Behavior is inconsistent with Uniswap V4 native ETH support assumptions.

## Proof of Concept
The submitted PoC test validates that:
- Native ETH currency unwraps to `address(0)`.
- ERC20-style `balanceOf` calls on `address(0)` fail.

This matches the revert path reached in `collectFees()` for native ETH positions.

## Recommended Mitigation
Use Uniswap V4 currency-aware balance handling (`CurrencyLibrary.balanceOf()`), which supports:
- ERC20 token balances for non-zero token addresses.
- Native ETH balances via `account.balance` for `address(0)`.

Add regression tests for both ERC20/ERC20 and native/ERC20 pools.
