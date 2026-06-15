# Module 06 — Linux Driver Core and Probe Ordering

## Driver binding

A driver binds to a device when a bus-specific matching rule succeeds.

For platform devices from Device Tree, matching commonly uses:

```c
static const struct of_device_id my_of_match[] = {
    { .compatible = "vendor,my-device" },
    { }
};
MODULE_DEVICE_TABLE(of, my_of_match);
```

## Probe function responsibilities

A good `probe()` function should:

- acquire resources
- validate dependencies
- configure hardware
- register child objects or subsystem interfaces
- fail clearly and safely when dependencies are missing

## Probe anti-patterns

- sleeping for a fixed delay instead of waiting for a hardware-ready bit
- retry loops without timeout
- ignoring `-EPROBE_DEFER`
- enabling hardware before clocks or regulators are ready
- doing heavy optional initialization during boot-critical path
- mixing board policy into generic driver code

## Optimization ideas

- move optional work out of boot-critical probe
- use async probe for safe independent devices
- fix supplier/consumer ordering instead of adding sleeps
- compile unused drivers out of the product kernel
- split mandatory boot devices from late product features
