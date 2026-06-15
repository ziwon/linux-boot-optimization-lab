# Lab 3-5 - Runtime PM Sensor Power Lab

## Objective

Review sensor runtime PM behavior and wakeup-source correctness.

## Tasks

1. Read `modules/15-runtime-pm-and-wakeup-sources/README.md`.
2. Inspect runtime PM state for one sensor.
3. Check wakeup source registration.
4. Identify resume-latency risk.

## Sample-data mode

Use the synthetic runtime PM and wakeup-source state:

```bash
cat sample-data/day3/runtime-status.txt
cat sample-data/day3/wakeup_sources.txt
```

Identify which devices are suspended, active, wake-capable, or at risk of slow resume.

## Hardware mode

```bash
cat /sys/kernel/debug/wakeup_sources
find /sys/devices -name runtime_status -print
```

## Deliverable

A runtime PM review table for one sensor or sensor hub.
