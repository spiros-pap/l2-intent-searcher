# Architecture

- **contracts/** — Router + adapters (Solidity, Foundry).
- **src-bot/** — TypeScript searcher skeleton.
- **configs/** — Non-secret TOML.
- **secrets/** — (optional) SOPS-encrypted secrets.
- **test/** — Unit + invariant tests.
- **.github/workflows/** — CI for contracts & bot.

Router MVP:
- Steps-based execution via adapters.
- Deadline + minOut guards.
- Permit/price-check hooks (future).

Searcher MVP:
- Load pools from TOML.
- Enumerate 2–3 hop routes.
- Simulate PnL; craft calldata for Router.
