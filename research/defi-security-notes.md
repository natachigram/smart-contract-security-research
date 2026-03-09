# DeFi Security Notes

Many severe DeFi vulnerabilities arise from broken accounting assumptions rather than obvious permission bugs.

## Recurring Patterns

1. **Unit Mismatch in Accounting**
- Aggregating balances from different asset units without normalization.
- Reporting totals that mix derivative and underlying assets without conversion.

2. **Snapshot and Time Semantics Errors**
- Using current voting power to distribute historical rewards.
- Missing per-epoch accounting for stake-based incentives.

3. **Token Compatibility Assumptions**
- Assuming all assets behave like standard ERC20.
- Failing with fee-on-transfer tokens, rebasing tokens, or native ETH handling.

4. **Oracle Freshness Misconfiguration**
- Global stale thresholds applied to feeds with distinct heartbeat intervals.
- Silent stale acceptance versus hard liveness failures.

5. **Governance Power Distortion**
- Delegation surfaces that let users assign power to arbitrary actors.
- Receiver/delegatee flexibility that breaks intended validator trust model.

## Notes from Submitted Findings
- Reward inflation via post-distribution ve-token locking.
- Transfer whitelist inversion due to boolean logic error.
- Native ETH fee-collection failure from ERC20-only assumptions.
- Treasury over-accounting and over-allocation due to missing balance validation.

## Practical Heuristics
- Always compare internal accounting to actual token balances.
- Treat timestamp-based logic as protocol-critical, not auxiliary.
- Require explicit compatibility handling for non-standard token behavior.
- Validate that "authorization intent" and "implemented checks" match line-by-line.
