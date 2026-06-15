# Lab 2-3 — Boot-Time Optimization Techniques

## Objective

Apply safe optimization strategies using measured evidence.

## Tasks

1. Read `modules/09-boot-time-optimization/README.md`.
2. Pick three candidate optimizations.
3. Estimate gain, risk, and validation method.
4. Write before/after measurement plan.

## Candidate techniques

- remove bootloader countdown
- reduce U-Boot storage scan
- trim kernel config
- build critical drivers into kernel
- move optional drivers later
- fix deferred probe storm
- reduce initramfs size
- disable production-unnecessary debug options
- defer user-space services

## Deliverable

An optimization plan that a reviewer could approve.
