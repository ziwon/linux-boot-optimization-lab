#!/usr/bin/env bash
set -euo pipefail
LOG_FILE="${1:-boot.log}"

if [ -t 0 ]; then
  echo "usage: <boot command or serial reader> | collect-boot-log.sh [boot.log]" >&2
  echo "example: picocom -b 115200 /dev/ttyUSB0 | scripts/collect-boot-log.sh local-artifacts/kernel-dump/boot.log" >&2
  exit 2
fi

mkdir -p "$(dirname "$LOG_FILE")"
echo "[INFO] Capturing serial boot log to ${LOG_FILE}"
tee "$LOG_FILE"
