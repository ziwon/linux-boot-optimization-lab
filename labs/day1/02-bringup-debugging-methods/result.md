# Result

## Failure Table

| Failure | Class | Evidence | First Check | Next Check |
|---|---|---|---|---|
| `good` scenario | No failure observed | `qemu-init: user space reached` | Confirm kernel command line and initramfs were passed | Use this as the known-good baseline |
| `missing-init` scenario | Rootfs / init | Kernel receives initramfs but `rdinit=/missing-init` points to a missing executable | Check `rdinit=` and initramfs contents | Restore `rdinit=/init` or add the requested init binary |
| `missing-rootfs` scenario | Rootfs / storage | Kernel is started without initramfs and with `root=/dev/vda`, but no usable root device is provided | Check `root=`, initramfs, and block devices | Provide initramfs or attach a root block device |

## Debugging Rule Used

- Unknown removed: QEMU proves the kernel image can execute and the serial console path works in the virtual environment.
- Remaining unknown: Real board power, reset, clock, boot media, firmware, and DRAM behavior are not modeled by QEMU direct boot.
- Proof needed: For real hardware, collect UART/U-Boot logs, firmware or ROM status, power/reset measurements, and storage boot evidence.
