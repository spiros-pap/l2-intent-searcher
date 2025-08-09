# L2 Intent Searcher — Cross-Rollup DeFi Solver + Atomic Router

Research-grade structure for a cross-rollup DeFi searcher (2025 standards):
- Foundry-first Solidity router for atomic multi-hop swaps.
- TypeScript searcher skeleton (Optimism/Arbitrum/zkSync adapters).
- No \.env\: configs in TOML; secrets via OS/CI/Docker or SOPS.

## Quickstart
\\\ash
# Contracts (later, when Foundry is installed)
forge build
forge test -vv

# Bot (TS)
cd src-bot && npm i && npm run typecheck
\\\

See \docs/architecture.md\ for design notes.
## High-level flow

`mermaid
flowchart LR
  A[Configs (TOML)] --> B[Searcher (TS)]
  B -->|Find route| C[Router calldata]
  C --> D[Router.sol]
  D --> E[Adapters]
  E --> F[DEX Pool(s)]
  D -->|final tokens| G[(Recipient)]
