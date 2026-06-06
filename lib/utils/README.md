# Vyper deployment utilities

These files are **vendored from [snekmate](https://github.com/pcaversaccio/snekmate)** (author: [pcaversaccio](https://github.com/pcaversaccio)), based on the copies in snekmate's `lib/utils/` at tag **v0.1.2** (see [`foundry.lock`](../../foundry.lock)).

They are kept at the project root as `lib/utils/` because `VyperDeployer` invokes `lib/utils/compile.py` via FFI using that fixed path. See the [snekmate Foundry installation note](https://github.com/pcaversaccio/snekmate#2%EF%B8%8F%E2%83%A3-foundry).

## Files

| File | Upstream | Local changes in this starter |
|------|----------|-------------------------------|
| [`VyperDeployer.sol`](VyperDeployer.sol) | [snekmate `lib/utils/VyperDeployer.sol`](https://github.com/pcaversaccio/snekmate/blob/v0.1.2/lib/utils/VyperDeployer.sol) | FFI uses `.venv/bin/python` (uv-managed toolchain) instead of `python` |
| [`compile.py`](compile.py) | [snekmate `lib/utils/compile.py`](https://github.com/pcaversaccio/snekmate/blob/v0.1.2/lib/utils/compile.py) | Adds `-p <lib>` for each Foundry `libs` entry so `from snekmate.<module> import ...` resolves when compiling contracts under `src/` |

`VyperDeployer.sol` itself traces back to [Foundry-Vyper](https://github.com/0xKitsune/Foundry-Vyper) (noted in the contract NatSpec).

## Licence

- `VyperDeployer.sol` — [WTFPL](https://www.wtfpl.net/) (per upstream)
- snekmate repository — [AGPL-3.0-only](https://www.gnu.org/licenses/agpl-3.0) by default; see [snekmate licensing](https://github.com/pcaversaccio/snekmate#-licence)

When updating these vendored files, prefer syncing from the matching snekmate release tag and re-applying the local changes listed above.
