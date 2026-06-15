# Module 20 — Kernel Latency for Physical AI

## Goal

Relate kernel latency to physical AI loops such as sensing, inference, actuation, and display feedback.

## Latency Sources

- IRQ handling
- threaded IRQ scheduling
- workqueue backlog
- mutex contention
- runtime PM resume
- I2C/SPI transfer time
- DMA and buffer queueing
- CPU frequency and thermal policy

## Tracing Targets

```bash
trace-cmd record -e irq -e sched -e workqueue
```

Use ftrace to measure from hardware interrupt to user-space event, not only from driver entry to return.

## Questions

- What is the event start point?
- What is the product-visible completion point?
- Which queue adds the most latency?
- Is the latency average acceptable but tail latency bad?
