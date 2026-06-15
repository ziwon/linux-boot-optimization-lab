# Module 01 — Boot Chain: From Reset to User Space

## Generic boot chain

```text
Reset
  -> Boot ROM
  -> first-stage firmware
  -> memory initialization
  -> trusted firmware / secure monitor
  -> bootloader
  -> kernel image + initramfs + device tree
  -> kernel entry
  -> driver initialization
  -> root filesystem
  -> init process
  -> product application
```

## Qualcomm-style conceptual chain

The exact names vary across chip generations and product security models, but a conceptual chain often looks like this:

```text
PBL or Boot ROM
  -> early bootloader stage
  -> XBL or equivalent extended bootloader stage
  -> ABL / UEFI / bootloader handoff
  -> Linux kernel
  -> Android/Linux user space
```

The important point is not the exact acronym. The important point is to identify which stage owns clocks, DRAM, storage, authentication, image loading, device tree handoff, and kernel command line.

## Questions to ask while reading a boot log

- Where does the timestamp start?
- Does it include firmware and bootloader time, or only kernel time?
- What image was loaded?
- Which device tree was selected?
- Was the root filesystem mounted from eMMC, UFS, NVMe, network, or initramfs?
- Which device was the last successful initialization before the failure?
