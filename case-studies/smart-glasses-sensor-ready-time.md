# Case Study — Smart Glasses Sensor Ready Time

## Symptom

The shell starts quickly, but the product UI waits several seconds before motion and wear-detection features become available.

## Likely Causes

- IMU driver probes late
- sensor hub firmware loads after user space starts
- proximity sensor waits for a regulator supplier
- sensor service waits for all devices instead of the minimum ready set

## Evidence to Collect

- `dmesg` with `printk.time=1`
- `/sys/bus/iio/devices/`
- `/proc/interrupts`
- sensor service readiness logs
- boot KPI marker for first usable motion event

## Better Fix

Define a minimum sensor-ready set and measure it separately from full feature readiness. Move optional calibration or non-critical sensors after product-ready time.
