# Vyper + Snekmate + Foundry starter

This repository is a minimal template for writing **Vyper** contracts (including **[Snekmate](https://github.com/pcaversaccio/snekmate)** modules), while using **Foundry** to compile, test, and deploy. Solidity is used for tests and scripts; contracts live in Vyper under `src/`.

## Prerequisites

- [Foundry](https://getfoundry.sh) (`forge`, `cast`, `anvil`, …)
- [uv](https://docs.astral.sh/uv/)
- **Python 3.11+** (see [`.python-version`](.python-version) for the local default)

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

Install the Python toolchain (pins Vyper 0.4.3 into `.venv/`):

```shell
uv sync
```

Foundry uses the uv-managed compiler via `[vyper] path = ".venv/bin/vyper"` in [`foundry.toml`](foundry.toml).

Quick setup via Makefile:

```shell
make setup
```

## Project layout

| Path | Purpose |
|------|---------|
| `src/` | Vyper contracts (`.vy`) |
| `test/` | Solidity tests; deploy Vyper with `VyperDeployer` + `--ffi` |
| `interfaces/` | Solidity interfaces for typed calls from tests and scripts |
| `script/` | Forge deployment scripts (`.s.sol`) |
| `lib/utils/` | Vendored from [snekmate](https://github.com/pcaversaccio/snekmate) — see [`lib/utils/README.md`](lib/utils/README.md) for attribution and local changes |
| `lib/forge-std` | Foundry test/script helpers (submodule) |
| `lib/snekmate` | Snekmate Vyper modules (submodule); referenced from [`foundry.toml`](foundry.toml) |

Example: [`src/Counter.vy`](src/Counter.vy) uses Snekmate's `ownable`; [`test/Counter.t.sol`](test/Counter.t.sol) deploys it via `VyperDeployer` and asserts behavior.

## VyperDeployer workflow

Tests and scripts compile Vyper contracts at runtime through FFI:

```solidity
import {VyperDeployer} from "utils/VyperDeployer.sol";

VyperDeployer deployer = new VyperDeployer();
ICounter counter = ICounter(deployer.deployContract("src/", "Counter"));
```

- Path: `"src/"`, fileName: `"Counter"` (no `.vy` suffix).
- **`--ffi` is required** for `forge test` and `forge script`.
- `lib/utils/compile.py` reads `forge config --json` and adds `-p` flags for each entry in `libs`, so `from snekmate.<module> import ...` resolves the same way as `forge build`.
- `VyperDeployer` invokes `.venv/bin/python` (created by `uv sync`) so FFI compilation uses the pinned Vyper toolchain.
- Snekmate `ownable` sets the deployer (`VyperDeployer` address) as owner; use `vm.prank(address(vyperDeployer))` before owner-only calls in tests.
- Override EVM version and optimizer: `deployContract("src/", "Counter", "prague", "gas")`.

Native Foundry Vyper compilation (`forge build`) remains enabled for artifacts, gas snapshots, `forge create`, and `forge inspect Counter abi`.

## Snekmate modules

Import Snekmate from the git submodule (not PyPI):

```python
from snekmate.auth import ownable as ow
initializes: ow
```

See [`src/Counter.vy`](src/Counter.vy) for the `initializes:` pattern.

## EVM version alignment

[`foundry.toml`](foundry.toml) sets `evm_version = "prague"`, matching Vyper 0.4.3's default. Use the `deployContract(..., "prague", "gas")` overload when overriding at deploy time.

## Common commands

### Build

```shell
make build
# or: forge build
```

### Test

```shell
make test
# or: forge test --ffi -vvv
```

### Format

```shell
make fmt
# or: forge fmt && uv run mamushi src/
```

### Format check

```shell
make fmt-check
```

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
forge script script/Counter.s.sol:CounterScript --ffi --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast
```

Local Anvil:

```shell
make deploy-local
```

### Cast and help

For interacting with contracts and chains from the CLI, see the [Foundry docs](https://getfoundry.sh/) and `cast --help`. Tool help:

```shell
forge --help
anvil --help
cast --help
```

## Known limitations

- **`forge coverage` does not support Vyper** (see Foundry docs).

## Documentation

- [Foundry](https://www.getfoundry.sh/introduction/getting-started)
- [Vyper documentation](https://docs.vyperlang.org/)
- [Snekmate](https://github.com/pcaversaccio/snekmate)
