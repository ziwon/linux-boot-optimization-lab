# Lab 1-3 — U-Boot Structure and ELF Analysis

## Objective

Understand U-Boot execution structure and inspect an ELF image.

## Tasks

1. Put a local U-Boot ELF under `local-artifacts/uboot-elf/`.
2. Run symbol and section inspection commands.
3. Identify entry point, text/data/bss sections, and board-specific functions.
4. Review U-Boot environment variables that affect boot time.

## Commands

```bash
readelf -h local-artifacts/uboot-elf/u-boot
readelf -S local-artifacts/uboot-elf/u-boot
nm -n local-artifacts/uboot-elf/u-boot | less
objdump -d local-artifacts/uboot-elf/u-boot | less
```

## Deliverable

A short note explaining what happens before the kernel is loaded.
