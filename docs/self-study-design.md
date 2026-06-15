# Self-study Design

This lab is organized as a self-study path for engineers who want a repeatable way to practice Linux boot analysis and optimization.

## Design goals

The material is designed for engineers who work close to hardware and need to make Linux boot reliably and quickly on embedded platforms. The target audience includes BSP engineers, bootloader engineers, kernel engineers, device-driver developers, and platform engineers working in automotive, mobile, AI edge devices, industrial systems, robotics, drones, IoT, or consumer electronics.

The required background is intentionally modest: C programming, Linux command-line usage, and basic embedded Linux familiarity. Kernel development experience helps, but the lab explains the boot path from first principles.

## Core learning outcomes

After completing the full path, an engineer should be able to:

- Describe the boot sequence at the level of CPU reset, ROM code, firmware stages, bootloader, kernel decompression, kernel init, driver probe, and user space.
- Explain what a BSP contains and why BSP work is not merely “making Linux boot.”
- Read a device tree and map nodes to platform devices and drivers.
- Understand how `compatible`, `of_match_table`, resources, clocks, regulators, pinctrl, interrupts, and probe ordering affect bring-up.
- Use boot logs, kernel command-line parameters, ftrace, initcall timing, and boot charts to identify bottlenecks.
- Differentiate correctness delays from accidental delays.
- Optimize boot time with data, not guesses.
- Produce a professional bring-up or optimization report.

## Practical environment

The lab uses two kinds of practice material:

1. Open local samples included in this repository.
2. Optional board-specific artifacts you provide locally, such as U-Boot ELF files, kernel dumps, ftrace logs, and vendor boot logs.

The repository never assumes access to proprietary board files. Instead, the exercises teach the analysis workflow so the same method can be applied to Qualcomm, NXP, Rockchip, Renesas, TI, Samsung, or custom SoC platforms.

## Expanded learning map

| Area | What to learn | Why it matters |
|---|---|---|
| Boot chain | ROM, firmware, bootloader, kernel entry, init | Gives you the full system timeline |
| BSP | Board files, defconfig, DTS, drivers, vendor patches | Connects hardware to Linux |
| U-Boot | SPL/TPL, relocation, driver model, commands, environment | Explains pre-kernel initialization |
| Device Tree | Hardware description, resources, dependencies | Most boot failures are dependency failures |
| Kernel init | start_kernel, initcalls, scheduler, driver core | Shows where Linux time is spent |
| Driver probe | platform bus, deferred probe, async probe | Key to bring-up and boot-time tuning |
| Tracing | ftrace, initcall_debug, trace-cmd, bootgraph | Converts speculation into evidence |
| Optimization | config trimming, probe ordering, async init, rootfs/init tuning | Delivers measurable product improvement |
| Production debugging | regression control, metrics, rollback | Makes optimization safe for real products |
| Wearable systems | sensors, audio wake, camera/display latency, runtime PM | Connects boot optimization to product readiness |
| Physical AI latency | IRQs, workqueues, sensor fusion, timestamping | Converts kernel traces into user-visible latency budgets |

## What not to do

Boot optimization fails when engineers:

- Remove sleeps without understanding hardware timing.
- Disable drivers only because they are slow.
- Treat `dmesg` timestamps as the only source of truth.
- Ignore firmware or bootloader time.
- Optimize QEMU and assume the same result on silicon.
- Tune one board and forget product variants.
- Make changes without regression tests.

This self-study path takes the opposite approach: measure, hypothesize, change, verify, and document.
