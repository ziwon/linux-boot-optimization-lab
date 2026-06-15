# Module 21 — Product Boot KPI Tracing

## Goal

Define product boot KPIs for smart glasses and connect them to kernel evidence.

## Example KPIs

| KPI | Definition |
|---|---|
| kernel_ready_time | kernel has mounted rootfs and started init |
| sensor_ready_time | IMU/proximity/audio wake path usable |
| camera_ready_time | camera pipeline can stream first frame |
| display_ready_time | display can scan out first UI frame |
| product_ready_time | user-visible feature set meets launch criteria |

## Evidence Sources

- bootloader timestamps
- `dmesg` timestamps
- initcall timing
- ftrace events
- service logs
- application readiness marker

## Rule

A KPI must have a clear start point, stop point, owner, measurement method, and regression threshold.
