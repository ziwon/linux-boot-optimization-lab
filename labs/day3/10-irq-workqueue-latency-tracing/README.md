# Lab 3-10 - IRQ Workqueue Latency Tracing

## Objective

Trace latency from IRQ to deferred kernel work and user-visible event.

## Tasks

1. Read `modules/20-kernel-latency-for-physical-ai/README.md`.
2. Choose an IRQ-driven sensor event.
3. Trace IRQ, sched, and workqueue events.
4. Identify average and tail latency.

## Sample-data mode

Use the synthetic trace-cmd excerpt:

```bash
cat sample-data/day3/trace-cmd-report.txt
```

Calculate IRQ-to-workqueue and workqueue-to-user-space latency from the timestamps.

## Hardware mode

```bash
trace-cmd record -e irq -e sched -e workqueue sleep 5
trace-cmd report
```

## Deliverable

An IRQ-to-workqueue latency summary with top delay sources.
