# Module 08 — ftrace and Boot Tracing

## Why ftrace

ftrace lets you move from “I think this is slow” to “this function or initcall took this much time.”

## Common tools

- `tracefs` under `/sys/kernel/tracing` or `/sys/kernel/debug/tracing`
- `function` tracer
- `function_graph` tracer
- trace events
- `trace-cmd`
- boot-time tracing through kernel command line

## Example runtime tracing

```bash
cd /sys/kernel/tracing
echo 0 > tracing_on
echo function_graph > current_tracer
echo '*probe*' > set_ftrace_filter
echo 1 > tracing_on
sleep 5
echo 0 > tracing_on
cat trace > /tmp/probe.trace
```

## Boot-time tracing idea

Enable trace events related to initcalls and driver probe, then export the trace after boot.

Possible events vary by kernel version. Inspect with:

```bash
find /sys/kernel/tracing/events -maxdepth 2 -type d | sort
```

## Analysis workflow

1. Capture boot log with timestamps.
2. Capture initcall timing.
3. Capture ftrace around slow areas.
4. Group delays by owner: firmware, bootloader, kernel core, driver, rootfs, user space.
5. Rank by impact and risk.
6. Optimize one item at a time.
