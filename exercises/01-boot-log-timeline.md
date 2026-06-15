# Exercise — Build a Boot Timeline

Given a boot log, create a table:

| Time | Stage | Component | Evidence | Notes |
|---:|---|---|---|---|

Rules:

- Do not assume Linux `dmesg` includes bootloader time.
- Mark unknown time explicitly.
- Separate kernel core, driver init, rootfs, and user space.
