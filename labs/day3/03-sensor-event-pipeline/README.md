# Lab 3-3 - Sensor Event Pipeline

## Objective

Trace a sensor event from hardware interrupt to user-space consumer.

## Tasks

1. Read `modules/16-sensor-fusion-kernel-interface/README.md`.
2. Pick one event such as IMU sample, near/far, or gesture.
3. Draw the kernel and user-space event path.
4. Identify where latency and timestamp error can enter.

## Sample-data mode

Use the synthetic event pipeline:

```bash
cat sample-data/day3/sensor-event-pipeline.log
```

Calculate the delay from IRQ entry to product action and mark each queue boundary.

## Hardware mode

Trace one sensor event with IRQ, driver, kernel interface, and user-space timestamps.

## Deliverable

A sensor event pipeline diagram with timing points and queue boundaries.
