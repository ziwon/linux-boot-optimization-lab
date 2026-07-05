#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="${1:-local-artifacts/qemu}"
OUT_DIR="$(mkdir -p "$OUT_DIR" && cd "$OUT_DIR" && pwd)"
WORK_DIR="$OUT_DIR/initramfs-work"
INIT_SRC="$OUT_DIR/init.c"
INITRAMFS="$OUT_DIR/rootfs.cpio.gz"

require_tool() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "missing required tool: $1" >&2
        if [ "$1" = "aarch64-linux-gnu-gcc" ]; then
            echo "" >&2
            echo "Run this lab inside the repository Docker container:" >&2
            echo "  make docker-build" >&2
            echo "  make docker-shell" >&2
            echo "  make qemu-build-rootfs" >&2
        fi
        exit 1
    fi
}

require_tool aarch64-linux-gnu-gcc
require_tool cpio
require_tool gzip

rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"/dev "$WORK_DIR"/proc "$WORK_DIR"/sys "$WORK_DIR"/tmp

cat > "$INIT_SRC" <<'EOF'
#define _GNU_SOURCE

#include <errno.h>
#include <linux/reboot.h>
#include <stdio.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/reboot.h>
#include <unistd.h>

static void try_mount(const char *source, const char *target, const char *type)
{
    if (mount(source, target, type, 0, "") != 0 && errno != EBUSY) {
        printf("init: mount %s on %s failed: %s\n", type, target, strerror(errno));
    }
}

int main(void)
{
    printf("\n");
    printf("qemu-init: user space reached\n");
    printf("qemu-init: this static /init came from rootfs.cpio.gz\n");
    printf("qemu-init: evidence point = rootfs + first user-space process\n");

    try_mount("proc", "/proc", "proc");
    try_mount("sysfs", "/sys", "sysfs");

    printf("qemu-init: proc/sys mount attempted\n");
    printf("qemu-init: powering off QEMU guest\n");
    fflush(stdout);
    sync();

    if (reboot(LINUX_REBOOT_CMD_POWER_OFF) != 0) {
        printf("qemu-init: reboot failed: %s\n", strerror(errno));
    }

    while (1) {
        pause();
    }
}
EOF

aarch64-linux-gnu-gcc -static -Os -s "$INIT_SRC" -o "$WORK_DIR/init"
chmod 0755 "$WORK_DIR/init"

if [ "$(id -u)" -eq 0 ]; then
    if ! mknod -m 600 "$WORK_DIR/dev/console" c 5 1; then
        echo "warning: could not create dev/console" >&2
    fi
    if ! mknod -m 666 "$WORK_DIR/dev/null" c 1 3; then
        echo "warning: could not create dev/null" >&2
    fi
else
    echo "warning: not root; dev/console and dev/null nodes were not created" >&2
    echo "warning: run inside the Docker container as root for the closest boot behavior" >&2
fi

(
    cd "$WORK_DIR"
    find . -print0 | cpio --null -ov --format=newc | gzip -9 > "$INITRAMFS"
)

echo "created $INITRAMFS"
