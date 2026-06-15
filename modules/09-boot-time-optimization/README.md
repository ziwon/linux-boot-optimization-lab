# Module 09 — Boot-Time Optimization Strategy

## Optimization layers

### Firmware and bootloader

- remove network fallback when not needed
- reduce autoboot delay
- avoid repeated storage scan
- avoid unnecessary peripheral init
- optimize image loading path
- validate secure boot overhead separately from Linux time

### Kernel configuration

- remove unused drivers
- build boot-critical drivers into kernel, not modules
- move non-critical drivers to modules or late loading
- disable debug options in production profile
- choose appropriate compression
- reduce initramfs size

### Device initialization

- fix deferred probe storms
- remove unnecessary fixed sleeps
- use hardware-ready polling with bounded timeout
- enable async probe for independent devices
- split mandatory and optional initialization

### User space

- reduce service fan-out
- avoid blocking network wait unless required
- use lazy service start
- parallelize independent services
- profile init system with systemd-analyze or equivalent

## Optimization decision matrix

| Technique | Boot gain | Risk | Notes |
|---|---:|---:|---|
| remove autoboot delay | high | low | easy win if allowed |
| trim unused drivers | medium | medium | requires product variant discipline |
| async probe | medium | medium/high | safe only for independent devices |
| remove fixed sleep | high | high | must replace with correct readiness check |
| reduce logging | low/medium | low | production profile only |
| shrink initramfs | medium | low/medium | verify recovery workflows |
| defer optional services | high | medium | product UX must accept it |

## Golden rule

An optimization is not complete until it has a regression guard.
