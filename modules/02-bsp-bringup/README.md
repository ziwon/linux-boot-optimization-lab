# Module 02 — BSP Bring-up

## What a BSP engineer owns

A BSP engineer connects silicon, board design, boot firmware, bootloader, kernel, and product requirements.

Typical deliverables:

- bootloader board configuration
- kernel defconfig
- device tree source files
- clock, pinctrl, regulator, GPIO, reset, interrupt configuration
- storage, display, camera, network, USB, PCIe, audio, and sensor enablement
- boot logs and known-issue documentation
- performance and boot-time baseline

## Bring-up sequence

1. Confirm power rails and clocks.
2. Confirm UART console.
3. Confirm boot ROM can load the first image.
4. Confirm DRAM initialization.
5. Confirm bootloader console.
6. Load kernel and device tree.
7. Reach kernel early console.
8. Mount root filesystem.
9. Start user space.
10. Enable peripherals one by one.

## Bring-up rule

Do not debug five unknowns at the same time. Reduce the system until there is only one unknown left.
