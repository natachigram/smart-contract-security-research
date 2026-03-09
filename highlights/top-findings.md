# Top Vulnerabilities

## Governance Manipulation via Arbitrary Delegation

**Platform:** Code4rena  
**Contest:** Virtuals Protocol  
**Severity:** High  
**Status:** Pending Verification

### Summary
Staking allowed arbitrary `receiver` and `delegatee`, enabling governance power redirection outside intended validator trust assumptions.

### Impact
Attackers can route voting power to malicious validators or controlled addresses, skewing protocol governance decisions.

### Report
- [virtuals-stake-delegation-takeover.md](../contest-findings/code4rena/virtuals-stake-delegation-takeover.md)

---

## Reward Inflation via Historical Voting Power Misuse

**Platform:** CodeHawks  
**Contest:** RAAC Core Contracts  
**Severity:** High  
**Status:** Pending Verification

### Summary
Historical rewards were distributed using current veRAAC voting power, allowing post-distribution lockers to capture prior rewards.

### Impact
Late entrants can claim rewards they did not economically earn, diluting legitimate long-term participants.

### Report
- [veRAAC-reward-inflation.md](../contest-findings/codehawks/veRAAC-reward-inflation.md)

---

## Native ETH Fee Collection Failure

**Platform:** Sherlock  
**Contest:** Super DCA Liquidity Network  
**Severity:** Medium  
**Status:** Verified

### Summary
Fee collection path assumes ERC20 balances for all currencies and fails when a listed position contains native ETH (`address(0)`).

### Impact
Owner fee collection reverts for affected positions, causing persistent revenue loss.

### Report
- [super-dca-native-eth-fee-collection.md](../contest-findings/sherlock/super-dca-native-eth-fee-collection.md)

---

## Oracle Heartbeat Mismatch Across Feeds

**Platform:** Code4rena  
**Contest:** Chainlink Data Consumer Integration  
**Severity:** Medium  
**Status:** Pending Verification

### Summary
A single global staleness threshold was applied to feeds with different heartbeat intervals.

### Impact
The protocol can either accept stale prices or reject valid feeds, producing valuation risk or downstream DoS.

### Report
- [chainlink-heartbeat-mismatch.md](../contest-findings/code4rena/chainlink-heartbeat-mismatch.md)
