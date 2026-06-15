# Module 07 — Kernel Internals Needed for Boot Optimization

## Memory initialization

Boot time can be affected by memory size, page allocator setup, CMA reservation, IOMMU setup, and debug options.

Watch for:

- large CMA reservation
- expensive memory tests
- initrd decompression time
- module loading from slow storage
- debug poisoning or sanitizers enabled in production builds

## Scheduler and workqueues

Async initialization is not magic. Workqueues and kernel threads still compete for CPU time, locks, IO, and dependencies.

Ask:

- Is this work actually parallelizable?
- Does it wait on a shared lock?
- Does it hit the same storage device?
- Does it depend on a supplier that is still missing?

## Filesystem and rootfs

Rootfs boot time depends on:

- storage latency
- filesystem type
- fsck policy
- initramfs size
- compression algorithm
- number of services started immediately

## Logging overhead

Verbose logging can be useful during bring-up and harmful in production boot-time measurement. Maintain separate debug and production profiles.
