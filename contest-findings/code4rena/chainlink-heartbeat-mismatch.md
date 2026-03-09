# Same Heartbeat Interval Used for Multiple Chainlink Feeds

## Title
Global Oracle Staleness Threshold Causes Stale Acceptance or DoS Across Mixed-Heartbeat Feeds

## Platform
Code4rena

## Contest
Chainlink Data Consumer Integration Contest (name from local notes)

## Protocol
ChainLinkDataConsumer Integration

## Severity
Medium

## Submission Metadata
- Researcher: 0xnatachi
- Submission reference: not recorded in local notes
- Source: pending public submission URL
- Status: Pending Verification

## Summary
The contract applies one global `allowedPriceUpdateDelay` to all Chainlink feeds, despite feeds having different heartbeat cadences. This creates a configuration tradeoff where strict values break slower feeds (DoS), while loose values accept stale data on faster feeds.

## Root Cause
Staleness checks are centralized in one global parameter instead of feed-specific (or path-specific) heartbeat thresholds.

## Vulnerability Details
Current check:

```solidity
if (block.timestamp < updatedAt_ || block.timestamp - updatedAt_ > allowedPriceUpdateDelay) {
    return 0;
}
```

Because this threshold is reused across feeds with different heartbeat intervals:
- Strict global delay can invalidate slower feeds and force zero-price paths.
- Loose global delay can accept materially stale prices from fast-heartbeat feeds.

Both outcomes break assumptions on timely oracle data.

## Impact
- Stale data acceptance can lead to incorrect valuations.
- Strict settings can trigger DoS in downstream flows that require non-zero prices.

## Proof of Concept
The submitted test demonstrates both branches:
- `allowedPriceUpdateDelay = 1h`: a path with a 25h-old component returns zero.
- `allowedPriceUpdateDelay = 24h`: a 20h-old ETH/USD feed is accepted.
- Tightening back to 1h rejects the same value and causes downstream revert.

## Recommended Mitigation
Adopt per-feed (preferred) or per-path heartbeat thresholds:
- Store `maxDelay` per feed/path.
- Validate each leg with its own threshold.
- Reject composite paths when any component is stale by its native heartbeat.
