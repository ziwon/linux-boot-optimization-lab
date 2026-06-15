# Module 17 — ToF, Proximity, and Gesture Input

## Goal

Map ToF/proximity hardware into Linux input or IIO paths and reason about gesture latency.

## Common Events

- near/far detection
- tap or hover gesture
- hand wave
- wear detection
- display wake or dim trigger

## Kernel Interface Choices

| Interface | Use When |
|---|---|
| input | discrete user-visible events |
| IIO | sampled distance or light measurements |
| char device | vendor algorithm or firmware protocol |

## Debugging

```bash
cat /proc/interrupts
evtest
find /sys/bus/iio/devices -maxdepth 2 -type f
cat /sys/kernel/debug/wakeup_sources
```

## Questions

- Is the gesture interpreted in hardware, firmware, kernel, or user space?
- Is the device a wake source?
- What is the event latency budget?
