# L2 Intent Searcher — Cross-rollup DeFi solver + atomic router

A compact, production-style skeleton for an L2 searcher:
- **Router (Solidity)** executes multi-hop routes via pluggable adapters.
- **Bot (TypeScript)** loads TOML configs and prepares calldata.
- **Philosophy:** _no_ .env files. Non-secrets live in versioned TOML; secrets are injected at runtime (OS keychain/CI/Docker secrets) or kept SOPS-encrypted.

## Why this repo exists
Hiring managers skim structure first. This shows:
- clear contract boundaries (router ? adapters)
- reproducible configs (TOML, no hidden env)
- typed bot skeleton ready to grow into a solver

## Repo map
contracts/ # Router + adapters (stubbed examples)
adapters/
docs/ # architecture notes
configs/ # networks.toml, pools.toml (non-secret)
script/ # Foundry deploy scripts
src-bot/ # TypeScript skeleton (viem)
test/ # unit/invariant tests (add when wiring)

## Quickstart (local)
`ash
# contracts (when Foundry is installed)
forge build

# bot
cd src-bot
npm i
npm run typecheck

