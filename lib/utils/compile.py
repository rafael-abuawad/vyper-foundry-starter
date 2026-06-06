#!/usr/bin/env python
# Vendored from snekmate (pcaversaccio): https://github.com/pcaversaccio/snekmate/blob/v0.1.2/lib/utils/compile.py
# Local changes documented in lib/utils/README.md
import json
import subprocess
import sys


def get_forge_config():
    try:
        result = subprocess.run(
            ["forge", "config", "--json"],
            capture_output=True,
            text=True,
            check=True,
        )
        return json.loads(result.stdout)
    except (subprocess.CalledProcessError, json.JSONDecodeError):
        return {}


def is_experimental_codegen(config):
    return config.get("vyper", {}).get("experimental_codegen", False) is True


def build_vyper_command(config, args):
    command = (
        ["vyper", "--experimental-codegen"]
        if is_experimental_codegen(config)
        else ["vyper"]
    )

    for lib in config.get("libs", []):
        command.extend(["-p", lib])

    command.extend(args)
    return command


config = get_forge_config()
command = build_vyper_command(config, sys.argv[1:])

result = subprocess.run(command, capture_output=True, text=True)
if result.returncode != 0:
    raise Exception(f"Error compiling: {sys.argv[1:]}")

sys.stdout.write(result.stdout.strip())
