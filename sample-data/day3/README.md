# Day 3 Sample Data

This directory contains synthetic wearable and sensor logs for the optional Day 3 labs.

Use these files when you do not have a smart-glasses board, IMU, microphone, proximity sensor, or sensor hub available. The data is intentionally small and readable so you can practice the analysis workflow before applying the same method to real hardware.

## Files

| File | Use |
|---|---|
| `wearable-boot-requirements.csv` | product-ready and subsystem-ready budget definition |
| `iio-devices.txt` | simulated `/sys/bus/iio/devices` listing |
| `proc-interrupts.txt` | simulated `/proc/interrupts` excerpt |
| `sensor-event-pipeline.log` | timestamped sensor event path |
| `asoc-components.txt` | simulated ASoC card, DAI, and route data |
| `wakeup_sources.txt` | simulated wakeup source state |
| `runtime-status.txt` | simulated runtime PM state |
| `imu-fifo-samples.csv` | IMU FIFO samples with kernel and user timestamps |
| `gesture-events.log` | proximity and gesture events |
| `camera-imu-latency-budget.csv` | motion-to-photon latency segments |
| `sensor-deferred-dmesg.log` | sensor deferred-probe messages |
| `devices_deferred.txt` | simulated deferred-device list |
| `trace-cmd-report.txt` | simulated IRQ, scheduler, and workqueue trace excerpt |
| `product-ready.log` | boot KPI readiness markers |
| `sensor-hub-events.csv` | synthetic sensor hub event routing table |
