# Case Study — Microphone AAD Low-power Wakeup

## Symptom

Always-on audio detection works while the system is active, but voice wake fails after suspend.

## Investigation

Possible root causes:

- codec wake IRQ is not enabled
- ASoC DAPM route powers down the required path
- DSP firmware is not loaded before suspend
- wakeup source is not registered
- regulator is disabled by runtime PM

## Evidence

- `/sys/kernel/debug/wakeup_sources`
- codec register dump
- ASoC DAPM state
- suspend/resume logs
- IRQ counters before and after suspend

## Lesson

Low-power wake is a system contract between audio routing, power management, firmware, and wake IRQ configuration.
