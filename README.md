# Smart Contract Security Research

Security research and vulnerability reports from competitive smart contract audits.

**Researcher:** Natachi

## Snapshot

| Metric | Value |
|---|---|
| Platforms | 3 |
| Contests covered | 8 |
| Published findings | 10 |
| High severity | 4 |
| Medium severity | 6 |

## Focus Areas
- DeFi protocol accounting and invariant design
- Governance, staking, and ve-token systems
- Oracle integrations and pricing assumptions
- Treasury and allocation controls
- Cross-chain bridge fee and settlement paths

## Audit Platforms
- Sherlock
- Code4rena
- CodeHawks

## Top Findings
- [Governance manipulation via arbitrary delegation (High)](./highlights/top-findings.md)
- [Reward inflation via post-distribution voting power (High)](./highlights/top-findings.md)
- [Native ETH fee-collection failure in Uniswap V4 listing flow (High)](./highlights/top-findings.md)
- [Oracle heartbeat mismatch causing stale acceptance/DoS (Medium)](./highlights/top-findings.md)

## Verification Policy
Each report includes a `Submission Metadata` section with:
- contest name
- submission reference
- source URL (when available)
- current verification status

Status definitions:
- `Verified`: finding has been validated in contest judging records (public link attached when available).

## Findings Index
- [All findings index](./contest-findings/README.md)
- [Sherlock findings](./contest-findings/sherlock/README.md)
- [Code4rena findings](./contest-findings/code4rena/README.md)
- [CodeHawks findings](./contest-findings/codehawks/README.md)

## Repository Structure

`contest-findings/`  
Public findings from competitive audit contests.

`highlights/`  
Top vulnerabilities and short impact summaries.

`methodology/`  
Personal auditing workflow and review heuristics.

`research/`  
DeFi security notes and recurring bug patterns.

`poc/`  
PoC references and exploit reproduction notes.
