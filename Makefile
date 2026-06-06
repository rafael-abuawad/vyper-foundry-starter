.PHONY: setup build test fmt fmt-check deploy-local

setup:
	git submodule update --init --recursive
	uv sync

build:
	forge build

test:
	forge test --ffi -vvv

fmt:
	forge fmt
	uv run mamushi src/

fmt-check:
	forge fmt --check
	uv run mamushi --check src/

deploy-local:
	forge script script/Counter.s.sol:CounterScript --ffi --rpc-url http://127.0.0.1:8545 --broadcast
