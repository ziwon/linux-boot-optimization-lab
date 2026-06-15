# Lab 3-7 - Proximity Gesture Input Lab

## Objective

Inspect proximity or gesture input from hardware event to Linux input or IIO interface.

## Tasks

1. Read `modules/17-tof-proximity-gesture-input/README.md`.
2. Identify whether the event uses input, IIO, or a vendor interface.
3. Check IRQ and wakeup behavior.
4. Estimate event latency risk.

## Sample-data mode

Use the synthetic proximity and gesture events:

```bash
cat sample-data/day3/gesture-events.log
cat sample-data/day3/proc-interrupts.txt
cat sample-data/day3/wakeup_sources.txt
```

Identify the interface, wake behavior, and latency from IRQ to product action.

## Hardware mode

```bash
cat /proc/interrupts
cat /sys/kernel/debug/wakeup_sources
```

## Deliverable

A proximity or gesture event map with interface choice and wake behavior.
