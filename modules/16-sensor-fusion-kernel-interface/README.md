# Module 16 — Sensor Fusion Kernel Interface

## Goal

Understand the kernel/user-space boundary for IMU and sensor fusion pipelines.

## Data Path

```text
IMU IRQ
  -> driver FIFO read
  -> kernel timestamp
  -> IIO buffer
  -> user-space fusion service
  -> pose / gesture / tracking output
```

Sensor fusion depends on consistent timestamps more than raw throughput. Drift, batching delay, and FIFO overflow can break AR alignment even when the driver appears functional.

## Key Design Choices

- kernel timestamp source
- hardware timestamp support
- FIFO watermark
- batch interval
- user-space poll strategy
- calibration data ownership

## Review Questions

- Is timestamping done at IRQ, FIFO read, or user-space receive?
- What happens when user space is late?
- How is calibration applied and versioned?
