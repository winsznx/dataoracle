# DataOracle

Decentralized data feed registry with validator consensus on Base and Stacks blockchains.

## Features

- Submit data from multiple validators
- Consensus-based data verification
- Configurable consensus threshold
- Transparent data submission tracking
- Multi-chain oracle network

## Smart Contract Functions

### Base (Solidity)
- `submit(bytes32 key, uint256 value)` - Submit data point
- `getData(bytes32 key)` - Get consensus value
- `getSubmissions(bytes32 key)` - Get submission count

### Stacks (Clarity)
- `(submit (key (buff 32)) (value uint))` - Submit data
- `(get-data (key (buff 32)))` - Get data point

## Tech Stack

- **Frontend**: Next.js 14, TypeScript, Tailwind CSS
- **Base**: Solidity 0.8.20, Foundry, Reown wallet
- **Stacks**: Clarity v4, Clarinet, @stacks/connect

## Getting Started

```bash
pnpm install
pnpm dev
```

## License

MIT License
