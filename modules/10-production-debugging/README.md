# Module 10 — Production Debugging and Regression Control

## What production teams need

- boot-time baseline by product variant
- boot-time budget by stage
- CI test that parses logs and flags regressions
- per-release boot trend
- known-good boot artifacts
- rollback plan

## Boot-time metric model

```text
total_boot_time
  = firmware_time
  + bootloader_time
  + kernel_time
  + driver_init_time
  + rootfs_mount_time
  + user_space_ready_time
```

Do not optimize only the part you can easily see.

## Reporting format

Each issue should include:

- symptom
- affected hardware/software version
- evidence
- suspected owner
- root cause
- fix
- risk
- before/after timing
- regression test

See `templates/boot-optimization-report.md`.
