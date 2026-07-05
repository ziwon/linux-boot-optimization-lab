# Notes

## Boot Chain

| Stage | Owner | Input | Output | Evidence |
|---|---|---|---|---|
| Boot ROM | | | | |
| Firmware | | | | |
| Bootloader | | | | |
| Kernel entry | | | | |
| Driver init | | | | |
| Rootfs | | | | |
| User space | | | | |

## Open Questions

- Which timestamp source starts first?
- Which stage selects the DTB?
- Which stage owns the longest unknown gap?

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
| Kernel entry | |
| Driver init | |
| Rootfs | |
| User space | |

### Known QEMU gaps

| Gap | Reason |
|---|---|
| Boot ROM | QEMU direct boot starts the kernel directly with `-kernel`. |
| Firmware | No real PMIC, DDR training, or secure firmware stage is modeled. |
| Bootloader | Direct boot bypasses U-Boot unless the optional U-Boot experiment is run. |
