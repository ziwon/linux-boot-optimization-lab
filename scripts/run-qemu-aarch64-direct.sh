#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-local-artifacts/qemu/linux-build/arch/arm64/boot/Image}"
INITRAMFS="${2:-local-artifacts/qemu/rootfs.cpio.gz}"
CMDLINE_FILE="${CMDLINE_FILE:-configs/qemu/kernel-cmdline.txt}"

if ! command -v qemu-system-aarch64 >/dev/null 2>&1; then
    echo "missing required tool: qemu-system-aarch64" >&2
    exit 1
fi

if [ ! -f "$IMAGE" ]; then
    echo "missing kernel Image: $IMAGE" >&2
    echo "build it with: make qemu-build-kernel" >&2
    exit 1
fi

if [ ! -f "$INITRAMFS" ]; then
    echo "missing initramfs: $INITRAMFS" >&2
    echo "build it with: make qemu-build-rootfs" >&2
    exit 1
fi

CMDLINE="$(tr '\n' ' ' < "$CMDLINE_FILE") rdinit=/init"

exec qemu-system-aarch64 \
    -machine virt \
    -cpu cortex-a57 \
    -m 1024M \
    -nographic \
    -serial mon:stdio \
    -no-reboot \
    -kernel "$IMAGE" \
    -initrd "$INITRAMFS" \
    -append "$CMDLINE"
