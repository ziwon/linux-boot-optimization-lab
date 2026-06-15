# Lab 3-6 - IMU Timestamp and FIFO Analysis

## Objective

Analyze how IMU FIFO configuration and timestamp source affect sensor fusion quality.

## Tasks

1. Read `modules/16-sensor-fusion-kernel-interface/README.md`.
2. Identify timestamp source and FIFO watermark.
3. Compare sample interval with user-space receive interval.
4. Document drift or batching risk.

## Sample-data mode

Use the synthetic IMU FIFO sample table:

```bash
column -s, -t sample-data/day3/imu-fifo-samples.csv
```

Compare `kernel_timestamp_ns` with `user_receive_ns` and identify batching behavior.

## Hardware mode

Capture IIO buffer samples and compare kernel timestamps with user-space receive time.

## Deliverable

An IMU timestamp analysis with FIFO settings, observed interval, and fusion risk.
