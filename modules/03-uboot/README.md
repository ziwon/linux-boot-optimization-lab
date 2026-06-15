# Module 03 — U-Boot Internals for BSP Engineers

## Why U-Boot matters

U-Boot is often the last stage before Linux. It may configure clocks, pins, storage, networking, memory layout, display splash, boot arguments, and device tree fixups.

## Concepts

- **SPL/TPL**: Tiny earlier U-Boot stages used before full DRAM or full driver model is available.
- **Relocation**: U-Boot may move itself to a different RAM address before running fully.
- **Driver Model**: U-Boot has its own device model, not the same as Linux.
- **Environment**: Variables such as `bootcmd`, `bootargs`, `fdtfile`, and storage paths control boot behavior.
- **FIT image**: A structured boot image format that can include kernel, device tree, ramdisk, signatures, and configurations.

## ELF analysis checklist

Use:

```bash
readelf -h u-boot
readelf -S u-boot
readelf -s u-boot | less
objdump -d u-boot | less
nm -n u-boot | less
```

Look for:

- entry point
- text/data/bss layout
- board init functions
- relocation symbols
- command table symbols
- driver model symbols

## Common U-Boot boot-time costs

- storage scanning
- network fallback timeout
- autoboot delay
- repeated partition scanning
- slow device tree fixups
- unnecessary display splash initialization
- excessive logging
