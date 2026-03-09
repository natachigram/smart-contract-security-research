# Unchecked Allocation Beyond Treasury Holdings

## Title
`Treasury.allocateFunds` Allows Reservations Exceeding Available Balance

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
- Source: submission reference available in researcher records
- Status: Verified

## Summary
`allocateFunds()` permits recording recipient allocations without validating treasury solvency. Allocators can reserve amounts that exceed actual holdings, creating false guarantees for downstream consumers.

## Root Cause
Missing availability/solvency checks prior to writing allocation records.

## Vulnerability Details
The function validates only recipient non-zero and amount non-zero, then stores allocation directly. It does not verify whether treasury holdings can actually back the allocation.

## Impact
- Allocation records can overstate available reserves.
- Downstream withdrawal/transfer operations may fail at execution time.
- External systems may make incorrect assumptions based on inaccurate reservation state.

## Proof of Concept
With low treasury holdings, allocator sets a significantly larger allocation for a recipient. Allocation is recorded successfully, but execution later fails due to insufficient funds.

## Recommended Mitigation
- Validate requested allocation against available unreserved balance.
- Track aggregate reserved amounts and enforce `reserved <= actualBalance` invariants.
- Emit events containing requested and accepted allocation values.
