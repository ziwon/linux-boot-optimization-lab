# Case Study — Camera Stack Delayed by Deferred Probe

## Symptom

The product reaches the shell, but the camera application starts late. Kernel logs show repeated deferred probe messages for camera-related devices.

## Investigation

Possible dependency chain:

```text
camera sensor
  -> regulator
  -> GPIO reset
  -> MIPI CSI receiver
  -> IOMMU
  -> clock provider
  -> media controller
```

## Evidence to collect

- `dmesg` with timestamps
- `/sys/kernel/debug/devices_deferred`
- clock summary
- regulator summary
- ftrace around probe functions
- device tree phandle correctness

Synthetic practice data is available under `sample-data/camera-deferred-probe/`.

## Bad fix

Adding a fixed delay to the sensor driver.

## Better fix

Fix supplier readiness and dependency description so the driver probes once when dependencies are ready. Consider async initialization only after dependency correctness is proven.

## Optimization lesson

A deferred probe storm is often a correctness signal, not merely a performance issue.
