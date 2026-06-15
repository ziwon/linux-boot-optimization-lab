# Case Study — Motion-to-photon Latency Budget

## Symptom

AR overlay feels unstable even though camera, IMU, and display drivers all work individually.

## Budget Model

```text
IMU sample
  -> kernel timestamp
  -> fusion service
  -> camera/display alignment
  -> compositor
  -> display scanout
```

## Evidence

- IMU FIFO timestamps
- camera frame timestamps
- DRM vblank timestamps
- scheduler and IRQ ftrace
- user-space event receive time

## Lesson

The important metric is not one driver duration. It is end-to-end tail latency across sensing, scheduling, processing, and scanout.
