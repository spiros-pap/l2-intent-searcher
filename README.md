# Cross-Rollup DeFi Execution Engine

Intent-based searcher and atomic router for zkSync, Optimism and Arbitrum.  
Built in Solidity and TypeScript with battle-tested patterns, gas-optimized routing and no `.env` files.

---

## Overview
This repository is a production-style skeleton for building an L2 intent searcher.  
It pairs a modular Solidity router for multi-hop routing with a TypeScript searcher that simulates, selects and executes optimal trades across multiple rollups.

The design is focused on:
- Clean separation between on-chain execution (router + adapters) and off-chain logic (searcher)
- Fully reproducible builds with versioned, human-readable configs
- CI-ready structure for quick iteration and testing
- Security-conscious patterns inspired by MEV-sensitive environments

---

## Architecture
- **Router** (`contracts/`) – Solidity contract that handles multi-hop routes through pluggable adapters.
- **Adapters** – One adapter per protocol (e.g. UniswapV3, Curve) for flexible routing.
- **Searcher** (`src-bot/`) – TypeScript process that loads TOML configs, prepares calldata, and submits transactions.
- **Configs** (`configs/`) – Versioned TOML files. No secrets committed; inject at runtime or via a secure store.

---

## Design Principles
1. **Clear boundaries** – Router logic is self-contained, adapters are isolated and swappable.
2. **No hidden `.env` files** – All non-secret settings live in versioned TOML; secrets are injected securely at runtime.
3. **Reproducible builds** – Same configs produce identical results.
4. **Testability** – Includes hooks for unit tests, integration tests and invariant testing.

---

## Repo Layout

configs/      # Network + pool configs (non-secret)
contracts/    # Router + adapters (stubs and examples)
docs/         # Architecture notes and diagrams
script/       # Foundry deployment scripts
src-bot/      # TypeScript searcher (viem-based)
test/         # Unit & invariant tests

---

## Quickstart (Local)

**Build contracts** (requires Foundry):
```sh
forge build

Run the searcher bot:
cd src-bot
npm install
npm run typecheck

