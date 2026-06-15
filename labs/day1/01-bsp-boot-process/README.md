# Lab 1-1 — BSP and Boot Process Mapping

## Objective

Build a complete boot timeline from reset to user space and identify which component owns each stage.

## Tasks

1. Draw the boot chain for a generic Armv8-A embedded board.
2. Mark the ownership boundary: ROM, firmware, bootloader, kernel, driver, rootfs, user space.
3. Read `docs/boot-sequence.md` and `modules/01-boot-chain/README.md`.
4. Compare the generic boot chain with a Qualcomm-style chain at a conceptual level.
5. Create your own `result.md` timeline.

## Practice questions

- Which stage initializes DRAM?
- Which stage chooses the device tree?
- Which stage passes the kernel command line?
- Which timestamp source are you using?
- What is not visible from Linux `dmesg`?

## Deliverable

A one-page boot map with ownership and measurable timestamps.
