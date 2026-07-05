# Result

## Boot Map Summary

| Time | Stage | Component | Owner | Evidence |
|---:|---|---|---|---|
| N/A | Boot ROM | Not visible in QEMU direct boot | QEMU machine model | Direct `-kernel` boot does not expose a real SoC Boot ROM log. |
| N/A | Firmware | Not visible in QEMU direct boot | QEMU machine model | No PMIC, DDR training, TF-A, or vendor firmware evidence is visible in this run. |
| N/A | Bootloader | Bypassed | Bootloader / BSP | Direct `-kernel` boot bypasses U-Boot. |
| ~0.000s | Kernel entry | Arm64 Linux `Image` | Kernel / BSP | Kernel console output is visible through QEMU serial console with `console=ttyAMA0 earlycon`. |
| 0.696s-0.928s | Driver init | QEMU `virt` platform devices | Kernel drivers | `initcall_debug` and probe logs are visible, for example `physmap_init`, `physmap-flash`, `clk_disable_unused`, and `regulator_init_complete`. |
| 0.955863s-0.957109s | Rootfs | initramfs `rootfs.cpio.gz` | Kernel VFS / initramfs | `Freeing unused kernel memory: 12736K` and `Run /init as init process`. |
| after 0.957109s | User space | static `/init` from initramfs | User space | `qemu-init: user space reached` and `qemu-init: this static /init came from rootfs.cpio.gz`. |
| 0.984314s-0.990665s | Shutdown | QEMU guest poweroff | Kernel shutdown path | Device shutdown logs followed by `reboot: Power down`. |

## Timeline Gaps

| Gap | Why It Is Unknown | Next Evidence Needed |
|---|---|---|
| Boot ROM time | QEMU direct boot starts the kernel directly and does not print a real Boot ROM stage. | Real board UART/ROM status, or a fuller QEMU firmware/bootloader experiment. |
| Firmware and DRAM training time | QEMU `virt` does not model board PMIC sequencing, DDR training, or vendor secure firmware logs. | Real firmware log, TF-A log, DDR training log, or vendor boot trace. |
| Bootloader handoff | U-Boot was bypassed by direct `-kernel` boot. | Run the optional QEMU U-Boot experiment and capture U-Boot banner, bootargs, kernel load address, and DTB handoff. |

## QEMU Direct-Boot Evidence

| Stage | Expected evidence | Observed evidence |
|---|---|---|
| Kernel entry | Linux banner, earlycon output, command line | Kernel console was visible through QEMU serial console. The run used `console=ttyAMA0 earlycon initcall_debug ignore_loglevel loglevel=8 rdinit=/init`. |
| Driver init | `initcall_debug` lines and platform driver logs | Observed `physmap-flash` probe, `initcall physmap_init... returned 0 after 20119 usecs`, `clk_disable_unused`, `regulator_init_complete`, and other platform driver/initcall logs. |
| Rootfs | initramfs/rootfs log | Observed `[    0.955863] Freeing unused kernel memory: 12736K` and `[    0.957109] Run /init as init process`. |
| User space | `qemu-init: user space reached` | Observed `qemu-init: user space reached`, `qemu-init: this static /init came from rootfs.cpio.gz`, and `qemu-init: evidence point = rootfs + first user-space process`. |

## QEMU Direct-Boot Limitations

| Missing stage | Reason |
|---|---|
| Boot ROM | QEMU `-kernel` direct boot does not expose a real SoC Boot ROM stage. |
| Firmware | QEMU `virt` does not model board PMIC sequencing, DDR training, or vendor secure firmware logs. |
| Bootloader | Direct boot bypasses U-Boot. Use the optional QEMU U-Boot experiment to observe this stage separately. |

## Conclusion

- Earliest visible stage: Linux kernel entry. Boot ROM, firmware, and bootloader are not visible in this QEMU direct-boot run.
- Boot-complete point: user space reached when static `/init` printed `qemu-init: user space reached`; shutdown completed at `[    0.990665] reboot: Power down`.
- Highest-risk ownership boundary: bootloader-to-kernel handoff remains untested because direct `-kernel` boot bypasses U-Boot. The kernel-to-rootfs and rootfs-to-user-space boundaries were verified.
