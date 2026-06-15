# Lab 2-1 — Kernel Boot Debugging with Logs, initcall_debug, and ftrace

## Objective

Use kernel instrumentation to locate boot bottlenecks.

## Tasks

1. Compare `dmesg` timestamps and initcall timing.
2. Parse sample initcall data.
3. Parse sample ftrace data.
4. Identify bottleneck candidates.

## Commands

```bash
make analyze-initcall
make analyze-ftrace
```

## Discussion

- Why is the slowest function not always the best optimization target?
- What boot time is invisible from kernel logs?
- What is the difference between a blocking dependency and normal initialization cost?

## Deliverable

A boot bottleneck table with owner, evidence, and next action.
