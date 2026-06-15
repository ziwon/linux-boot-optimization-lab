# Bring-up Checklist

## Hardware basics

- [ ] Power rails verified
- [ ] Reset sequencing verified
- [ ] Reference clocks verified
- [ ] UART pins and baud rate verified
- [ ] Storage boot mode verified
- [ ] DRAM initialization verified

## Bootloader

- [ ] Bootloader console available
- [ ] Kernel image path verified
- [ ] DTB selection verified
- [ ] Kernel command line verified
- [ ] Boot delay/fallback behavior understood

## Kernel

- [ ] earlycon or serial console enabled
- [ ] `printk.time=1` enabled for debugging
- [ ] rootfs mount path verified
- [ ] init process verified
- [ ] deferred probe checked

## Optimization readiness

- [ ] baseline captured
- [ ] stage ownership known
- [ ] top delays ranked
- [ ] changes reviewed for correctness risk
- [ ] regression test defined
