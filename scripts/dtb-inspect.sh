#!/usr/bin/env bash
set -euo pipefail
DTB="${1:?Usage: dtb-inspect.sh <file.dtb>}"
dtc -I dtb -O dts "$DTB" | less
