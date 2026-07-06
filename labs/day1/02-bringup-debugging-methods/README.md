# Lab 1-2 — Bring-up Debugging Methods

## Objective

Learn the tools and reasoning process used during board bring-up.

## Tasks

1. List the minimum signals needed for first boot: power, clock, reset, UART, storage, DRAM.
2. Build a bring-up checklist using `checklists/bringup-checklist.md`.
3. Read a boot log and identify the last known-good stage.
4. Classify failures as hardware, firmware, bootloader, kernel, device tree, driver, or rootfs.

## QEMU experiment environment

This lab uses QEMU to generate repeatable bring-up logs. QEMU cannot prove real
board power, reset, clocks, or DRAM training, but it is useful for practicing
the debugging method:

```text
observe log
  -> find last known-good stage
  -> classify likely owner
  -> decide the next proof needed
```

Build and enter the repository container:

```bash
make docker-build
make docker-shell
```

Inside the container, prepare the QEMU artifacts if they do not already exist:

```bash
make qemu-build-rootfs
make qemu-build-kernel
```

Run the scenarios:

```bash
make qemu-bringup-good
make qemu-bringup-missing-init
make qemu-bringup-missing-rootfs
```

Logs are written to:

```text
local-artifacts/qemu/bringup-debugging/
```

Classify the generated logs:

```bash
make classify-bringup-logs
```

Expected scenarios:

| Scenario | Purpose | Expected classification |
|---|---|---|
| `good` | Prove the known-good baseline reaches user space | no failure observed |
| `missing-init` | Kernel has initramfs but requested init path is wrong | rootfs / init |
| `missing-rootfs` | Kernel has no usable root device or initramfs | rootfs / storage |

Use these logs as a controlled substitute for early board bring-up evidence.
On a real board, replace them with UART, U-Boot, firmware, JTAG, and power
measurement evidence.

## Useful tools

- UART console
- JTAG or Lauterbach-style debugger
- U-Boot console
- `dmesg`
- earlycon
- initcall_debug
- ftrace
- `/sys/kernel/debug`
- `readelf`, `objdump`, `nm`

## Deliverable

A failure classification table with evidence.
