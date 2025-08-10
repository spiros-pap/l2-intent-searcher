# L2 Intent Searcher

**Cross-rollup DeFi solver & atomic router**

This project is a compact, production-oriented skeleton for building an L2 searcher.  
It combines a Solidity router for multi-hop routing with a TypeScript bot for intent execution.

## Architecture
- **Router** (contracts/) – Solidity contract that supports multi-hop routes through pluggable adapters.
- **Bot** (src-bot/) – TypeScript process that loads TOML configs, prepares calldata, and executes transactions.
- **Config** (configs/) – TOML configuration files. *Secrets are never committed; inject them at runtime via environment variables or a secure store.*

## Design Philosophy
1. **Clear boundaries** – Router and adapters are self-contained.
2. **No hidden .env files** – Non-secrets live in versioned TOML; secrets are injected at runtime.
3. **Reproducible builds** – Same configs, same result.
4. **Test-ready** – Includes structure for unit and invariant testing.

## Repo Structure
configs/      # Network + pool configs (non-secret)
contracts/    # Router + adapters (stubbed)
docs/         # Architecture notes
script/       # Foundry deploy scripts
src-bot/      # TypeScript bot skeleton (viem)
test/         # Unit & invariant tests

## Quickstart (Local)
# build contracts (requires Foundry)
forge build

# bot
cd src-bot
npm install
npm run typecheck

## Security
If you discover a vulnerability, please **do not** open a public issue.  
See [SECURITY.md](SECURITY.md) for reporting guidelines.

## License
MIT
