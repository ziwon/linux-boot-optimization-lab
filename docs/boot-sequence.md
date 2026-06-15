# Linux Boot Sequence

## Generic ARM64 Boot Flow

```text
Power On
  ↓
Boot ROM
  ↓
SPL / TF-A / vendor boot stages
  ↓
U-Boot
  ↓
Linux kernel decompression / entry
  ↓
early init / setup_arch
  ↓
initcall levels
  ↓
driver probe
  ↓
rootfs mount
  ↓
/sbin/init or systemd
```

## Common Qualcomm-style Flow

```text
PBL → XBL/SBL → ABL/U-Boot equivalent → Linux kernel → Android/Linux user space
```

Commercial Qualcomm BSPs often add secure boot, signed images, DDR training, PMIC initialization, A/B slots, and device tree overlays. This repository does not cover private vendor code; it focuses on publicly explainable boot principles and debugging methods.

## Key Observation Points

- Which stage first emits an early UART log?
- Is the kernel command line passed correctly?
- Are the DTB address and compatible strings correct?
- Where does the delay occur before or after rootfs mount?
- Which function is slow in `initcall_debug` output?
- Which drivers repeatedly hit deferred probe?
