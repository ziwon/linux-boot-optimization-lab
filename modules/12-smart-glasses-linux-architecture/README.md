# Module 12 — Smart Glasses Linux Architecture

## Goal

Understand how a smart-glasses product maps onto Linux boot, kernel subsystems, sensor pipelines, audio, display, camera, power, and product-ready timing.

## Product Architecture

```text
SoC
  -> boot firmware / bootloader
  -> Linux kernel
  -> sensor, audio, camera, display, wireless drivers
  -> sensor fusion / AI runtime / UX services
  -> application ready
```

Smart glasses are latency- and power-sensitive. Boot success is not enough; the product must become usable with sensors, audio wake, display, and camera paths ready inside a measurable budget.

## Kernel Responsibilities

- describe board hardware with Device Tree
- bind sensors, codecs, microphones, cameras, displays, and sensor hubs
- expose data through IIO, input, V4L2/media, ALSA/ASoC, DRM, and character devices
- manage runtime PM, wakeup sources, IRQs, clocks, and regulators
- preserve timestamps across sensor, camera, and display paths

## Questions

- What does "ready" mean for a wearable product?
- Which devices are required before the first user-visible interaction?
- Which devices can initialize after product-ready time?
- Which boot delays are correctness requirements?
