# Module 22 — Sensor Hub and Edge AI Kernel Interface

## Goal

Understand how Linux interacts with sensor hubs, DSPs, MCUs, and edge AI accelerators in wearable products.

## Common Architecture

```text
sensors
  -> sensor hub MCU / DSP
  -> mailbox, RPMsg, SPI, I2C, or shared memory
  -> Linux kernel driver
  -> user-space sensor service / AI runtime
```

## Kernel Concerns

- firmware loading
- boot ordering
- mailbox or transport readiness
- event routing
- timestamp preservation
- power ownership
- crash recovery
- ABI stability

## Questions

- Who owns always-on sensing during suspend?
- How are sensor timestamps represented across processors?
- What happens if hub firmware is late or crashes?
- Which events must wake Linux?
