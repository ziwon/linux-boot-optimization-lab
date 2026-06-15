# Lab 2-2 — Device Driver Initialization Debugging

## Objective

Understand platform device creation, driver matching, probe, and deferred probe.

## Tasks

1. Read `modules/04-device-tree/README.md` and `modules/06-driver-core/README.md`.
2. Inspect a DTS/DTB if available.
3. Map a device tree node to a driver compatible string.
4. Analyze why a probe is delayed or repeated.

## Commands

```bash
scripts/dtb-inspect.sh path/to/board.dtb
cat /sys/kernel/debug/devices_deferred
```

## Deliverable

A dependency graph for one device: clocks, regulators, pinctrl, reset, interrupts, bus, and supplier devices.
