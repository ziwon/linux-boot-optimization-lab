#!/usr/bin/env bash
set -euo pipefail

KERNEL_DIR="${1:-local-artifacts/qemu/linux}"
BUILD_DIR="${2:-local-artifacts/qemu/linux-build}"
JOBS="${JOBS:-$(nproc)}"
KERNEL_URL="${KERNEL_URL:-https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git}"

require_tool() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "missing required tool: $1" >&2
        exit 1
    fi
}

require_tool git
require_tool make
require_tool aarch64-linux-gnu-gcc

if [ ! -d "$KERNEL_DIR/.git" ]; then
    mkdir -p "$(dirname "$KERNEL_DIR")"
    git clone --depth 1 "$KERNEL_URL" "$KERNEL_DIR"
fi

mkdir -p "$BUILD_DIR"

make -C "$KERNEL_DIR" O="$(pwd)/$BUILD_DIR" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
make -C "$KERNEL_DIR" O="$(pwd)/$BUILD_DIR" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j"$JOBS" Image

echo "created $BUILD_DIR/arch/arm64/boot/Image"
