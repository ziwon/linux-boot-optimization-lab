# Lab 3-2 - IIO IMU Driver Lab

## Objective

Understand how an IMU appears through the Linux IIO subsystem and how to inspect sampling behavior.

## Tasks

1. Read `modules/13-linux-sensor-subsystems/README.md`.
2. Find the IMU IIO device path.
3. Inspect channels, sampling frequency, buffer state, and timestamps.
4. Explain how IRQs and FIFO settings affect latency.

## Sample-data mode

Use the synthetic IIO and interrupt data:

```bash
cat sample-data/day3/iio-devices.txt
cat sample-data/day3/proc-interrupts.txt
```

Identify the IMU device name, channels, sampling frequency, buffer state, trigger, and IRQ.

## Hardware mode

```bash
find /sys/bus/iio/devices -maxdepth 2 -type f | sort
cat /proc/interrupts
```

## Deliverable

An IMU driver observation sheet covering channels, buffer behavior, IRQ source, and timestamp semantics.
