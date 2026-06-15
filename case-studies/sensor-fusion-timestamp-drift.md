# Case Study — Sensor Fusion Timestamp Drift

## Symptom

Pose estimation gradually drifts during long sessions even when sensor samples arrive at the expected rate.

## Investigation

Check:

- hardware timestamp availability
- kernel timestamp location
- FIFO batching interval
- clock domain conversion
- user-space monotonic clock use
- dropped or reordered samples

## Evidence

- raw IIO samples with timestamps
- FIFO watermark configuration
- IRQ timing trace
- user-space receive timing
- fusion output error over time

## Lesson

Sampling rate alone is not enough. Sensor fusion needs consistent timestamp semantics across kernel and user space.
