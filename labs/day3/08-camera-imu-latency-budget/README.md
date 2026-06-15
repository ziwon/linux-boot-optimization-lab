# Lab 3-8 - Camera IMU Latency Budget

## Objective

Build a latency budget across camera, IMU, fusion, compositor, and display.

## Tasks

1. Read `modules/18-camera-display-latency-for-ar/README.md`.
2. Define motion-to-photon start and stop points.
3. List timestamp sources for IMU, camera, and display.
4. Identify buffering and scheduling risks.

## Sample-data mode

Use the synthetic motion-to-photon budget:

```bash
column -s, -t sample-data/day3/camera-imu-latency-budget.csv
```

Compare each measured segment with its budget and identify the largest remaining risk.

## Hardware mode

Use IMU timestamps, camera buffer timestamps, compositor markers, and DRM vblank timestamps.

## Deliverable

A motion-to-photon latency budget table.
