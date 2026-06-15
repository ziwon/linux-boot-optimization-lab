# Module 19 — Device Tree Dependency and Deferred Probe

## Goal

Debug deferred probe in sensor-heavy wearable systems.

## Common Suppliers

- regulators
- clocks
- reset controllers
- GPIO controllers
- pinctrl
- I2C/SPI controllers
- power domains
- IOMMU
- sensor hub firmware

## Debugging Flow

1. Read `dmesg` with timestamps.
2. Inspect `/sys/kernel/debug/devices_deferred`.
3. Map each consumer to Device Tree phandles.
4. Confirm supplier driver probe order and return codes.
5. Fix the dependency description before adding sleeps.

## Good Fixes

- correct missing phandles
- add required supplies/clocks/resets
- make supplier driver available earlier
- split optional features from mandatory probe path

## Bad Fixes

- fixed sleep in a consumer driver
- ignoring `-EPROBE_DEFER`
- forcing probe order without understanding supplier readiness
