# Lab 1-4 — U-Boot Board Initialization and Device Tree Handoff

## Objective

Understand board initialization, device tree selection, and kernel handoff.

## Tasks

1. Inspect boot commands and environment variables.
2. Identify how the kernel image, initramfs, and DTB are loaded.
3. Explain how boot arguments are generated.
4. Identify boot-time costs in U-Boot: delays, storage scan, network fallback, splash, verification.

## Optimization discussion

- Can autoboot delay be removed?
- Is network boot fallback required in production?
- Is boot image verification part of the security requirement?
- Can repeated partition scanning be avoided?

## Deliverable

A U-Boot boot-time risk list.
