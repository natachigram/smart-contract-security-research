# Proof of Concept Tests

This folder contains exploit-oriented test snippets in contest-native styles.

## Layout
- `foundry/`: Solidity test snippets (`.t.sol`)
- `hardhat/`: TypeScript test snippets (`.spec.ts`)

## Usage
These files are designed to be copied into the relevant contest repositories where full contracts and fixtures exist.

### Foundry
1. Copy a file from `poc/foundry/` into the target repo `test/` directory.
2. Adjust import paths to match the contest repository.
3. Run:

```bash
forge test --match-test <test_name> -vv
```

### Hardhat
1. Copy a file from `poc/hardhat/` into the target repo `test/` directory.
2. Ensure fixture/helpers are available.
3. Run:

```bash
npx hardhat test test/<file>.spec.ts
```

## Included Snippets
- Foundry: Super DCA native ETH fee collection failure
- Foundry: Mellow transfer whitelist inversion
- Hardhat: veRAAC reward inflation after distribution
- Hardhat: Chainlink heartbeat mismatch stale/DoS behavior
