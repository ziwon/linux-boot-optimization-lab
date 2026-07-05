# Lab 1-1 — BSP and Boot Process Mapping

## Objective

Build a complete boot timeline from reset to user space and identify which component owns each stage.

## Tasks

1. Draw the boot chain for a generic Armv8-A embedded board.
2. Mark the ownership boundary: ROM, firmware, bootloader, kernel, driver, rootfs, user space.
3. Read `docs/boot-sequence.md` and `modules/01-boot-chain/README.md`.
4. Compare the generic boot chain with a Qualcomm-style chain at a conceptual level.
5. Boot a minimal Arm64 Linux system in QEMU and collect evidence from the console log.
6. Create your own `result.md` timeline.

## QEMU direct-boot environment

This mode turns the lab from a document-only exercise into a boot-log exercise.
QEMU does not emulate a real board's Boot ROM, PMIC, reset wiring, or DDR
training, but it is enough to observe the Linux handoff boundary:

```text
QEMU machine reset
  -> Linux kernel entry
  -> driver init
  -> initramfs rootfs
  -> /init user space
```

Build and enter the repository container:

```bash
make docker-build
make docker-shell
```

Inside the container, build a minimal initramfs:

```bash
make qemu-build-rootfs
```

This target is intended to run inside the repository Docker container. If you
see `missing required tool: aarch64-linux-gnu-gcc`, rebuild and enter the lab
image first:

```bash
make docker-build
make docker-shell
make qemu-build-rootfs
```

This creates:

```text
local-artifacts/qemu/rootfs.cpio.gz
```

The initramfs contains a small statically linked AArch64 `/init` program. It
prints a user-space evidence message and powers off the guest.

Build an Arm64 Linux kernel `Image`:

```bash
make qemu-build-kernel
```

This clones a shallow Linux stable tree under `local-artifacts/qemu/linux` and
builds:

```text
local-artifacts/qemu/linux-build/arch/arm64/boot/Image
```

Kernel builds are CPU and network intensive. If you already have an Arm64
kernel `Image`, place it at the path above or pass it directly to the run
script:

```bash
scripts/run-qemu-aarch64-direct.sh /path/to/Image local-artifacts/qemu/rootfs.cpio.gz
```

Run the direct-boot experiment:

```bash
make qemu-direct-boot
```

The command line comes from `configs/qemu/kernel-cmdline.txt`:

```text
console=ttyAMA0 earlycon initcall_debug ignore_loglevel loglevel=8
```

Evidence to capture from the QEMU console:

| Stage | Evidence to look for |
|---|---|
| Kernel entry | Linux banner, earlycon output, command line |
| Driver init | `initcall_debug` lines, PL011 UART, virtio/platform driver logs |
| Rootfs | initramfs unpack or `Freeing initrd memory` style log |
| User space | `qemu-init: user space reached` |

Record missing stages as gaps. In direct-boot mode, Boot ROM, firmware, and
bootloader are intentionally skipped or hidden by QEMU.

## Optional QEMU U-Boot stage

To observe a bootloader prompt separately, install `u-boot-qemu` in the
container or host and run:

```bash
qemu-system-aarch64 \
  -machine virt \
  -cpu cortex-a57 \
  -m 512M \
  -nographic \
  -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin
```

This is useful evidence for the bootloader stage, but it is not required for
the direct-boot kernel/rootfs experiment.

## Practice questions

- Which stage initializes DRAM?
- Which stage chooses the device tree?
- Which stage passes the kernel command line?
- Which timestamp source are you using?
- What is not visible from Linux `dmesg`?

## Deliverable

A one-page boot map with ownership and measurable timestamps.
