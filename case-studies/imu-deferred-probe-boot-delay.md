# Case Study — IMU Deferred Probe Boot Delay

## Symptom

The IMU driver repeatedly defers probe, and the product cannot enable motion gestures during early boot.

## Investigation

Check whether the IMU depends on:

- `vdd` or `vddio` regulators
- interrupt GPIO controller
- pinctrl state
- I2C/SPI controller
- sensor hub firmware

## Evidence

- `dmesg | grep -i defer`
- `/sys/kernel/debug/devices_deferred`
- Device Tree node and supplier phandles
- regulator and clock summaries

## Lesson

Deferred probe is a dependency signal. Fix the supplier description or availability before adding a fixed delay.
