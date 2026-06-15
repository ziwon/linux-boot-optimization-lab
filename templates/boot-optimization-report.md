# Boot Optimization Report

## Summary

- Product/board:
- Software version:
- Kernel version:
- Boot complete definition:
- Baseline boot time:
- Optimized boot time:
- Improvement:

## Evidence

Attach or reference:

- bootloader log
- kernel dmesg
- initcall_debug output
- ftrace output
- user-space service timing

## Bottleneck

| Rank | Stage | Owner | Time | Evidence | Risk |
|---:|---|---|---:|---|---|
| 1 | | | | | |

## Root cause

Explain why the delay happens.

## Fix

Explain the change and why it is safe.

## Before/after

| Metric | Before | After | Delta |
|---|---:|---:|---:|
| total boot | | | |
| kernel init | | | |
| slowest initcall | | | |

## Regression guard

Describe how future regressions will be detected.

## Rollback plan

Describe how to revert if hardware instability appears.
