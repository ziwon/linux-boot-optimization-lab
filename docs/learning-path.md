# Expanded Learning Path

This learning path organizes the repository into a practical engineering track.

## Day 1 — Boot Chain, BSP, U-Boot, Kernel Entry

| Session | Topic | Focus |
|---|---|---|
| 1 | BSP and boot process | BSP responsibility, boot ownership, Armv8-A boot chain, vendor SoC boot sequence analysis |
| 2 | Bring-up debugging mindset | Debugging tools, failure classification, minimal evidence collection, successful bring-up habits |
| 3 | U-Boot structure | execution model, ELF layout, relocation, commands, environment, Armv8-A handoff |
| 4 | U-Boot core features | board initialization, device tree handoff, boot arguments, image loading, bootloader time costs |
| 5 | Linux kernel boot flow | kernel entry, `start_kernel()`, initcalls, platform devices, driver probe |
| 6 | Bring-up issue debugging | compiler/toolchain issues, hardware/software interface errors, board-specific failure patterns |

## Day 2 — Kernel Debugging and Boot-Time Optimization

| Session | Topic | Focus |
|---|---|---|
| 1 | Kernel boot debugging | boot logs, initcall timing, ftrace, boot bottleneck identification |
| 2 | Driver initialization debugging | platform device matching, device tree dependencies, deferred probe, probe timing |
| 3 | Optimization techniques | async probe, config trimming, initcall analysis, debug option removal, rootfs and user-space tuning |
| 4 | Case study | measured before/after analysis, risk review, regression guard, production report |

## Optional Day 3 Extension — Wearable Linux, Sensors, and Physical AI Readiness

| Session | Topic | Focus |
|---|---|---|
| 1 | Wearable boot requirements | product-ready time, sensor-ready time, launch feature set |
| 2 | IIO IMU driver lab | IIO channels, buffers, triggers, IRQs, sampling frequency |
| 3 | Sensor event pipeline | IRQ to driver to kernel interface to user-space event |
| 4 | I2S microphone ASoC lab | CPU DAI, codec DAI, DAPM, PCM, audio wake path |
| 5 | Runtime PM sensor power | autosuspend, wakeup sources, resume latency |
| 6 | IMU timestamp and FIFO | timestamp semantics, FIFO watermark, drift and batching risk |
| 7 | Proximity gesture input | ToF/proximity interface choice, input/IIO events, wake behavior |
| 8 | Camera IMU latency budget | motion-to-photon budget, camera/display timestamps |
| 9 | Deferred probe for sensors | Device Tree suppliers, dependency maps, safe fixes |
| 10 | IRQ workqueue latency tracing | irq, sched, workqueue tracing for event latency |
| 11 | Product-ready time analysis | boot KPIs, owners, evidence, regression thresholds |
| 12 | Sensor hub event routing | hub firmware, transport, wake events, timestamp preservation |

## Extended self-study path

The core Day 1 and Day 2 flow is intentionally compact. For real engineering readiness, continue with:

- kernel driver core internals
- trace events and function graph tracing
- U-Boot driver model
- FIT images and secure boot implications
- initramfs and filesystem boot trade-offs
- systemd or product init optimization
- CI-based boot regression detection
- IIO, ASoC, V4L2/media, DRM, and input subsystem interactions
- runtime PM and wake-source validation
- physical AI event latency and product-ready KPI tracing
