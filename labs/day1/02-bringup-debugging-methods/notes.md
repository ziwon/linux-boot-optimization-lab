# Notes

## Minimum Signals

| Signal | Expected State | How To Check | Result |
|---|---|---|---|
| Power rail | Rails reach valid voltage in the expected order | Real board: scope/PMIC status. QEMU: not modeled. | QEMU direct boot cannot validate this. |
| Reference clock | Required input clocks are stable | Real board: scope/clock status. QEMU: not modeled. | QEMU direct boot cannot validate this. |
| Reset | CPU leaves reset and starts executing | Real board: reset line/debugger. QEMU: kernel log starts. | QEMU proves only virtual CPU reached kernel entry. |
| UART | Console output is visible at expected baud/device | Real board: UART adapter. QEMU: serial console on `ttyAMA0`. | QEMU console log is visible with `console=ttyAMA0 earlycon`. |
| Storage boot mode | Boot media is selected and readable | Real board: boot straps/U-Boot log. QEMU: direct `-kernel` bypasses boot media. | Not validated by QEMU direct boot. |
| DRAM | Memory is initialized and stable | Real board: firmware/DDR log/memtest. QEMU: virtual RAM works if kernel runs. | QEMU proves only virtual memory is sufficient for this lab. |

## Failure Classification

| Symptom | Last Known-good Stage | Suspected Owner | Evidence |
|---|---|---|---|
| Good QEMU boot reaches `qemu-init` | User space | None observed | `qemu-init: user space reached`. |
| Requested init path is wrong | Rootfs selected init | Rootfs / init | `rdinit=/missing-init`; kernel cannot execute the requested init. |
| No usable rootfs is provided | Kernel entry or driver init | Rootfs / storage | no initramfs; `root=/dev/vda`; kernel cannot mount root. |

## QEMU Scenario Commands

```bash
make qemu-bringup-good
make qemu-bringup-missing-init
make qemu-bringup-missing-rootfs
make classify-bringup-logs
```

## Generated Logs

| Scenario | Log |
|---|---|
| Good boot | `local-artifacts/qemu/bringup-debugging/good.log` |
| Missing init | `local-artifacts/qemu/bringup-debugging/missing-init.log` |
| Missing rootfs | `local-artifacts/qemu/bringup-debugging/missing-rootfs.log` |
