# Module 15 — Runtime PM and Wakeup Sources

## Goal

Use runtime PM and wakeup sources without breaking sensor readiness or suspend/resume correctness.

## Runtime PM Model

Runtime PM lets a device suspend while the system is still running. A driver must balance:

- `pm_runtime_get*()` before hardware access
- `pm_runtime_put*()` after work completes
- autosuspend delay
- IRQ and wakeup state
- supplier device dependencies

## Wearable Risks

- sensor loses FIFO data during autosuspend
- wake IRQ is disabled accidentally
- clocks or regulators are dropped while a child device still needs them
- resume latency exceeds gesture or audio wake budget

## Debugging

```bash
cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
cat /sys/kernel/debug/wakeup_sources
find /sys/devices -name runtime_status -print
```

## Questions

- Which devices may autosuspend?
- Which devices must stay wake-capable?
- What is the maximum acceptable resume latency?
