# Module 11 — Kernel Engineer Mindset

## Think in contracts

Hardware, firmware, bootloader, device tree, kernel, driver, and user space all form contracts. A reliable kernel engineer identifies the broken contract instead of patching symptoms.

## Prefer boring correctness

Fast boot is worthless if the device sometimes fails after cold boot, brown-out, or temperature change.

## Read code with a timeline

When reading kernel code, always ask:

- When does this run?
- What must already be initialized?
- What can sleep?
- What lock can it take?
- What hardware state does it assume?
- What happens if the supplier is missing?

## Optimization taste

Good optimization removes accidental work. Bad optimization removes necessary waiting.

## The senior engineer standard

A senior boot engineer can explain:

- why the delay exists
- why the proposed fix is safe
- how it was measured
- how it will be prevented from regressing
