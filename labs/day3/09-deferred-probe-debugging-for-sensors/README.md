# Lab 3-9 - Deferred Probe Debugging for Sensors

## Objective

Debug deferred probe in a sensor dependency chain.

## Tasks

1. Read `modules/19-device-tree-dependency-and-deferred-probe/README.md`.
2. Inspect deferred devices.
3. Map each deferred consumer to suppliers.
4. Propose a fix that avoids fixed sleeps.

## Sample-data mode

Use the synthetic deferred-probe logs:

```bash
cat sample-data/day3/sensor-deferred-dmesg.log
cat sample-data/day3/devices_deferred.txt
```

Map each consumer to its missing supplier and propose a fix that avoids fixed sleeps.

## Hardware mode

```bash
dmesg | grep -i defer
cat /sys/kernel/debug/devices_deferred
```

## Deliverable

A supplier/consumer dependency map with a safe fix plan.
