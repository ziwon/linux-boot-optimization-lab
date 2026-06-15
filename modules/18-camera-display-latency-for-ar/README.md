# Module 18 — Camera and Display Latency for AR

## Goal

Understand the camera-to-display path for AR and identify where Linux can add latency.

## Pipeline

```text
camera sensor
  -> CSI receiver
  -> ISP / memory
  -> V4L2/media pipeline
  -> perception or tracking
  -> compositor
  -> DRM display
```

Motion-to-photon latency is a system metric. Kernel drivers contribute through probe order, buffer queueing, IRQ latency, scheduling, power state transitions, and display refresh timing.

## Observability

- media graph
- V4L2 buffer timestamps
- DRM vblank events
- ftrace scheduling and IRQ events
- camera and display clocks

## Questions

- What timestamp marks camera exposure?
- What timestamp marks display scanout?
- How many buffers are queued between capture and display?
