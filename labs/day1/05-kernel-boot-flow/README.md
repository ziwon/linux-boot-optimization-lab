# Lab 1-5 — Linux Kernel Boot Flow

## Objective

Trace the kernel path from entry to initcalls and user space.

## Tasks

1. Read `modules/05-kernel-boot-flow/README.md`.
2. Enable or analyze logs with `printk.time=1` and `initcall_debug`.
3. Use `scripts/parse-initcall-debug.py` on sample data.
4. Identify the top slow initcalls.

## Command

```bash
python3 scripts/parse-initcall-debug.py sample-data/initcall/initcall-debug-sample.log
```

## Deliverable

A ranked list of kernel initialization delays.
