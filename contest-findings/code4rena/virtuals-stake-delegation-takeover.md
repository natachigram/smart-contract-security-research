# Stake Malicious Users Can Delegate Other Users' Stakes

## Title
Arbitrary Receiver/Delegatee in Staking Enables Governance Power Redirection

## Platform
Code4rena

## Contest
Virtuals Protocol

## Protocol
Virtuals Protocol

## Severity
High

## Submission Metadata
- Researcher: 0xnatachi
- Submission reference: `F-5 / S-701`
- Source: submission reference available in researcher records
- Status: Verified

## Summary
When staking is enabled (`canStake == true`), callers can invoke `stake(amount, receiver, delegatee)` with arbitrary `receiver` and `delegatee`. This permits delegation flows that bypass intended validator-trust semantics and enables concentrated governance influence by malicious actors.

## Root Cause
The staking interface allows user-controlled `receiver` and `delegatee` without strict coupling to `msg.sender` and without robust validator eligibility checks at delegation time.

## Vulnerability Details
By combining balance/allowance with flexible parameters, attackers can:
- Mint ve-tokens to arbitrary receivers.
- Delegate resulting voting power to attacker-controlled addresses or malicious validators.

This weakens the intended DPoS-style trust model where delegation should be constrained to approved validator pathways.

## Impact
- Governance manipulation via concentrated delegated voting power.
- Validator selection and protocol decisions can be skewed.
- Fairness and security assumptions for on-chain governance degrade.

## Proof of Concept
Issue is reproducible by staking with attacker-selected `delegatee` while satisfying ordinary stake preconditions (balance + allowance), then confirming governance power accrues to non-intended actors.

## Recommended Mitigation
- Remove or tightly constrain `receiver`; credit stake directly to `msg.sender`.
- Enforce `delegatee` membership in approved validator registry.
- Add invariant tests ensuring delegation cannot bypass validator authorization rules.
