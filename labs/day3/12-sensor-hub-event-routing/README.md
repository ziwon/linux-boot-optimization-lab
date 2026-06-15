# Lab 3-12 - Sensor Hub Event Routing

## Objective

Map sensor hub events into Linux and decide which events must wake or notify user space.

## Tasks

1. Read `modules/22-sensor-hub-and-edge-ai-kernel-interface/README.md`.
2. Identify transport between Linux and the sensor hub.
3. Map event IDs to Linux interfaces.
4. Review firmware loading and crash recovery behavior.

## Sample-data mode

Use the synthetic sensor hub routing table:

```bash
column -s, -t sample-data/day3/sensor-hub-events.csv
cat sample-data/day3/product-ready.log
```

Decide which events should wake Linux and which interface should expose each event.

## Hardware mode

Use real hub firmware logs, mailbox or RPMsg traces, wakeup sources, and user-space consumers.

## Deliverable

A sensor hub event routing table with wake, timestamp, and recovery requirements.
