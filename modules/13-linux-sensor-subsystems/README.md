# Module 13 — Linux Sensor Subsystems

## Goal

Understand where wearable sensors fit in Linux and how sensor data reaches user space.

## Common Interfaces

| Sensor Type | Kernel Interface | Typical User |
|---|---|---|
| IMU, accelerometer, gyro | IIO | sensor fusion, motion detection |
| Proximity, gesture | IIO or input | wake, gesture UX |
| Touch button | input | UI event |
| Camera sensor | V4L2/media | camera, AR tracking |
| Sensor hub | IIO, input, char, RPMsg | always-on sensing |

## IIO Concepts

- channels
- buffered capture
- triggers
- FIFO watermark
- timestamp source
- scale, offset, sampling frequency

## Debugging Checklist

- confirm the device probes
- inspect `/sys/bus/iio/devices/`
- check sampling frequency and buffer state
- verify IRQ count increases
- compare kernel timestamps with user-space receive time
