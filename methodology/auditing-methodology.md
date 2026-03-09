# Auditing Methodology

## 1. Scoping and Threat Model
- Map protocol roles, trust boundaries, and external dependencies.
- Identify critical invariants (accounting, governance integrity, solvency, liveness).
- Classify attack surfaces: user input, admin flows, oracle paths, and cross-chain interactions.

## 2. Architecture Decomposition
- Break contracts by responsibility (core logic, accounting, authorization, integrations).
- Trace state transitions for deposit, withdrawal, claim, allocation, and emergency flows.
- List assumptions each module makes about other modules.

## 3. Invariant-Driven Review
- Validate balance conservation and unit consistency across assets.
- Check snapshot/time semantics for rewards, voting power, and emissions.
- Verify permission boundaries and role restrictions for privileged operations.

## 4. Integration and Edge-Case Analysis
- Evaluate token compatibility assumptions (fee-on-transfer, rebasing, native asset handling).
- Review oracle liveness/freshness checks and fallback behavior.
- Analyze protocol behavior under partial failure (stale feeds, zero values, paused states).

## 5. Exploitability Assessment
- Build practical attack paths with internal/external preconditions.
- Estimate realistic impact on funds, governance, and protocol operation.
- Prioritize findings by blast radius and execution complexity.

## 6. Proof of Concept and Remediation
- Reproduce impact with minimal PoCs.
- Provide targeted fixes that preserve intended protocol behavior.
- Prefer mitigations with explicit checks, snapshots, and invariant enforcement.
