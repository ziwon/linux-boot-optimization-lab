# Boot Optimization Checklist

## Measurement

- [ ] Define boot complete condition.
- [ ] Capture at least three boot samples.
- [ ] Separate firmware, bootloader, kernel, driver, rootfs, and user-space time.
- [ ] Keep raw logs.

## Candidate selection

- [ ] Rank by total impact.
- [ ] Identify owner.
- [ ] Identify correctness risk.
- [ ] Prefer removing accidental work over shortening required waits.

## Validation

- [ ] Cold boot tested.
- [ ] Warm reboot tested.
- [ ] Failure path tested.
- [ ] Product variants tested.
- [ ] Regression guard added.
