#!/usr/bin/env bash
set -euo pipefail

SCENARIO="${1:-good}"
IMAGE="${IMAGE:-local-artifacts/qemu/linux-build/arch/arm64/boot/Image}"
INITRAMFS="${INITRAMFS:-local-artifacts/qemu/rootfs.cpio.gz}"
CMDLINE_FILE="${CMDLINE_FILE:-configs/qemu/kernel-cmdline.txt}"
OUT_DIR="${OUT_DIR:-local-artifacts/qemu/bringup-debugging}"
LOG="$OUT_DIR/${SCENARIO}.log"

require_file() {
    if [ ! -f "$1" ]; then
        echo "missing required file: $1" >&2
        echo "Run inside the repository Docker container:" >&2
        echo "  make qemu-build-rootfs" >&2
        echo "  make qemu-build-kernel" >&2
        exit 1
    fi
}

if ! command -v qemu-system-aarch64 >/dev/null 2>&1; then
    echo "missing required tool: qemu-system-aarch64" >&2
    echo "Run this lab inside the repository Docker container." >&2
    exit 1
fi

require_file "$IMAGE"
mkdir -p "$OUT_DIR"

BASE_CMDLINE="$(tr '\n' ' ' < "$CMDLINE_FILE") panic=1"
INITRD_ARGS=()

case "$SCENARIO" in
    good)
        require_file "$INITRAMFS"
        INITRD_ARGS=(-initrd "$INITRAMFS")
        CMDLINE="$BASE_CMDLINE rdinit=/init"
        ;;
    missing-init)
        require_file "$INITRAMFS"
        INITRD_ARGS=(-initrd "$INITRAMFS")
        CMDLINE="$BASE_CMDLINE rdinit=/missing-init"
        ;;
    missing-rootfs)
        CMDLINE="console=ttyAMA0 earlycon ignore_loglevel loglevel=8 panic=1 root=/dev/vda rw"
        ;;
    *)
        echo "usage: $0 {good|missing-init|missing-rootfs}" >&2
        exit 2
        ;;
esac

echo "scenario: $SCENARIO" | tee "$LOG"
echo "cmdline: $CMDLINE" | tee -a "$LOG"
echo "log: $LOG" | tee -a "$LOG"

set +e
qemu-system-aarch64 \
    -machine virt \
    -cpu cortex-a57 \
    -m 1024M \
    -nographic \
    -serial mon:stdio \
    -no-reboot \
    -kernel "$IMAGE" \
    "${INITRD_ARGS[@]}" \
    -append "$CMDLINE" 2>&1 | tee -a "$LOG"
status=${PIPESTATUS[0]}
set -e

echo "qemu exit status: $status" | tee -a "$LOG"
