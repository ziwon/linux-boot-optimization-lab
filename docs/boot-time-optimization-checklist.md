# Boot Time Optimization Checklist

## 1. Build a Measurement Baseline

- Measure at least five times on the same board, power condition, and storage device.
- Enable UART timestamps.
- Enable `initcall_debug`.
- Capture an ftrace boot trace.
- If the system uses systemd, inspect `systemd-analyze blame` and `systemd-analyze critical-chain`.

## 2. Kernel Command Line

```text
console=ttyAMA0 earlycon initcall_debug ignore_loglevel
```

Example ftrace boot tracing parameters:

```text
trace_event=initcall:initcall_start,initcall:initcall_finish
ftrace=function_graph
```

## 3. Bottleneck Candidates

- regulator, clock, or reset dependency delay
- storage initialization delay: eMMC, UFS, SD, NVMe
- network PHY link-up wait
- camera or sensor probe timeout
- firmware loading timeout
- repeated deferred probe
- unnecessary bus scan
- excessive debug options

## 4. Optimization Techniques

- Review built-in versus module strategy.
- Move drivers outside the critical path to modules when safe.
- Evaluate whether async probe is safe for independent devices.
- Remove unnecessary kernel configuration options.
- Adjust console log level for production measurements.
- Optimize firmware loading paths.
- Clean up Device Tree dependencies.
- Shorten probe timeout only when correctness is proven, or make initialization conditional.

## 5. Validation

- Confirm boot success across at least 30 repeated runs.
- Measure cold boot and warm reboot separately.
- Run peripheral regression tests.
- Compare before and after boot timelines.
