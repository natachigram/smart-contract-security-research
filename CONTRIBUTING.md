# Contributing

## Scope
This repository tracks smart contract security research artifacts:
- contest findings
- methodology notes
- reproducible PoC snippets

## Report Contribution Rules
1. Keep each finding as one Markdown file under `contest-findings/<platform>/`.
2. Preserve this section order in every report:
   - Title
   - Platform
   - Contest
   - Protocol
   - Severity
   - Submission Metadata
   - Summary
   - Root Cause
   - Vulnerability Details
   - Impact
   - Proof of Concept
   - Recommended Mitigation
3. Use concrete technical language; avoid marketing or generic phrasing.
4. Include direct file/function references where possible.

## PoC Contribution Rules
1. Add Foundry snippets to `poc/foundry/` and Hardhat snippets to `poc/hardhat/`.
2. Name files by issue pattern, e.g. `protocol-vuln-name.t.sol` or `protocol-vuln-name.spec.ts`.
3. Include setup assumptions at the top of each file.
4. Favor deterministic assertions over log-only output.

## Quality Checklist
- Severity and impact are internally consistent.
- Mitigation is actionable and scoped to root cause.
- Links/metadata are accurate.
- Markdown renders cleanly on GitHub.

## License
By contributing, you agree contributions are released under the repository MIT License.
