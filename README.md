# Vyper + Snekmate + Foundry starter

This repository is a minimal template for writing **Vyper** contracts (including **[Snekmate](https://github.com/pcaversaccio/snekmate)** modules), while using **Foundry** to compile, test, and deploy. Solidity is used for tests and scripts; contracts live in Vyper under `src/`.

## Prerequisites

- [Foundry](https://getfoundry.sh) (`forge`, `cast`, `anvil`, …)
- [uv](https://docs.astral.sh/uv/)
- **Python 3.14+** (see [`.python-version`](.python-version))

## Setup

Clone the repository and initialize submodules (`forge-std`, Snekmate):

```shell
git clone <repo-url> && cd <repo-dir>
git submodule update --init --recursive
```

Or, in one step when cloning:

```shell
git clone --recurse-submodules <repo-url>
```

Install the Python toolchain so Forge can compile `.vy` files:

```shell
uv sync
```

Install the Foundry dependencies:

```shell
forge install
```



## Project layout

| Path | Purpose |
|------|---------|
| `src/` | Vyper contracts (`.vy`) |
| `test/` | Solidity tests; deploy Vyper with `deployCode("src/...")` |
| `interfaces/` | Solidity interfaces for typed calls from tests and scripts |
| `script/` | Forge deployment scripts (`.s.sol`) |
| `lib/forge-std` | Foundry test/script helpers (submodule) |
| `lib/snekmate` | Snekmate Vyper modules (submodule); referenced from [`foundry.toml`](foundry.toml) |

Example: [`src/Counter.vy`](src/Counter.vy) uses Snekmate’s `ownable`; [`test/Counter.t.sol`](test/Counter.t.sol) deploys it and asserts behavior.

## Common commands

### Build

```shell
forge build
```

### Test

```shell
forge test
```

### Format

```shell
forge fmt
```

(Formats Solidity; Vyper formatting is outside Forge—use your editor or Vyper tooling.)

### Gas snapshots

```shell
forge snapshot
```

### Local node

```shell
anvil
```

### Deploy

Replace `<your_rpc_url>` and `<your_private_key>` (or use a wallet / ledger flow per the Foundry book):

```shell
forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast and help

For interacting with contracts and chains from the CLI, see the [Foundry docs](https://getfoundry.sh/) and `cast --help`. Tool help:

```shell
forge --help
anvil --help
cast --help
```

## Documentation

- [Foundry](https://www.getfoundry.sh/introduction/getting-started)
- [Vyper documentation](https://docs.vyperlang.org/)
- [Snekmate](https://github.com/pcaversaccio/snekmate)
