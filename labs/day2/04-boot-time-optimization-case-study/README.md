# Lab 2-4 — Boot-Time Optimization Case Study

## Objective

Produce a professional optimization report from raw evidence.

## Tasks

1. Read `case-studies/camera-device-deferred-probe.md`.
2. Parse the sample logs.
3. Fill out `templates/boot-optimization-report.md`.
4. Propose a safe fix and a regression guard.

## Commands

```bash
python3 scripts/parse-initcall-debug.py sample-data/camera-deferred-probe/initcall-debug.log
python3 scripts/parse-ftrace-function-graph.py sample-data/camera-deferred-probe/function-graph.trace
cat sample-data/camera-deferred-probe/devices_deferred.txt
```

## Deliverable

A final report with root cause, patch idea, risk, test plan, and before/after table.
