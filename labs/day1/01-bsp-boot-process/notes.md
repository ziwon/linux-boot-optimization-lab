# Notes

## Boot Chain

| Stage | Owner | Input | Output | Evidence |
|---|---|---|---|---|
| Boot ROM | SoC vendor / silicon | Reset vector, boot strap, boot media selection | Next boot image loaded or boot failure status | Not visible in QEMU direct boot because the kernel is started directly with `-kernel`. |
| Firmware | Firmware / vendor BSP | Boot ROM handoff, DRAM/clock/PMIC/security requirements | DRAM and execution state ready for bootloader or kernel | Not visible in this run; QEMU `virt` does not model real PMIC sequencing, DDR training, or secure firmware logs. |
| Bootloader | Bootloader / BSP | Firmware handoff, boot media, kernel image, DTB, bootargs | Kernel loaded, DTB selected, command line passed | Bypassed in this run. A separate QEMU U-Boot run is needed to observe this stage. |
| Kernel entry | Kernel / BSP | Arm64 Linux `Image`, QEMU-provided machine description, kernel command line, initramfs | Early kernel console and kernel initialization | Kernel log is visible on QEMU serial console with `console=ttyAMA0 earlycon`. |
| Driver init | Kernel drivers | Platform devices from QEMU `virt`, kernel subsystems, initcall ordering | Probed devices and initialized subsystems | `initcall_debug` lines, `physmap-flash`, `clk_disable_unused`, and `regulator_init_complete` logs. |
| Rootfs | Kernel VFS / initramfs | `rootfs.cpio.gz` passed with `-initrd` | `/init` selected and executed | `[0.955863] Freeing unused kernel memory` and `[0.957109] Run /init as init process`. |
| User space | Init process / user space | Static `/init` from initramfs | First user-space messages and guest poweroff request | `qemu-init: user space reached` and `qemu-init: this static /init came from rootfs.cpio.gz`. |

## Open Questions

- Which timestamp source starts first?

  The first visible timestamps in this experiment are Linux kernel `printk`
  timestamps. They start from the kernel's own time base after QEMU direct boot,
  not from physical power-on. Boot ROM, firmware, and bootloader time are not
  included in these timestamps.

- Which stage selects the DTB?

  On a real embedded board, the bootloader normally selects or modifies the DTB
  and passes it to the kernel. In this QEMU direct-boot experiment, U-Boot is
  bypassed. QEMU's `virt` machine provides the machine description used by the
  kernel, so the normal bootloader DTB-selection contract is not tested.

- Which stage owns the longest unknown gap?

  The longest unknown gap is the pre-kernel path: Boot ROM, firmware, DRAM
  training, and bootloader handoff. Direct `-kernel` boot intentionally skips or
  hides that path. To measure it, use a real board UART log or add a QEMU U-Boot
  experiment.

## QEMU Direct-Boot Notes

| Item | Value |
|---|---|
| QEMU machine | `virt` |
| CPU model | `cortex-a57` |
| Kernel image | `local-artifacts/qemu/linux-build/arch/arm64/boot/Image` |
| Initramfs | `local-artifacts/qemu/rootfs.cpio.gz` |
| Kernel command line | `console=ttyAMA0 earlycon initcall_debug ignore_loglevel loglevel=8 rdinit=/init` |

### Evidence checklist

| Stage | Evidence line or observation |
|---|---|
| Kernel entry | Kernel console output was visible through QEMU serial console with `console=ttyAMA0 earlycon initcall_debug ignore_loglevel loglevel=8 rdinit=/init`. |
| Driver init | Observed `physmap-flash` probe and `initcall physmap_init... returned 0 after 20119 usecs`; also observed `clk_disable_unused`, `regulator_init_complete`, and platform device shutdown logs. |
| Rootfs | Observed `[    0.955863] Freeing unused kernel memory: 12736K` and `[    0.957109] Run /init as init process`. |
| User space | Observed `qemu-init: user space reached`, `qemu-init: this static /init came from rootfs.cpio.gz`, and `qemu-init: evidence point = rootfs + first user-space process`. |

### Known QEMU gaps

| Gap | Reason |
|---|---|
| Boot ROM | QEMU direct boot starts the kernel directly with `-kernel`. |
| Firmware | No real PMIC, DDR training, or secure firmware stage is modeled. |
| Bootloader | Direct boot bypasses U-Boot unless the optional U-Boot experiment is run. |
