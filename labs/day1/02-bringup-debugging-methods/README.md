# Lab 1-2 — Bring-up Debugging Methods

## Objective

Learn the tools and reasoning process used during board bring-up.

## Tasks

1. List the minimum signals needed for first boot: power, clock, reset, UART, storage, DRAM.
2. Build a bring-up checklist using `checklists/bringup-checklist.md`.
3. Read a boot log and identify the last known-good stage.
4. Classify failures as hardware, firmware, bootloader, kernel, device tree, driver, or rootfs.

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
