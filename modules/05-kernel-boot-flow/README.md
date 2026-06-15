# Module 05 — Linux Kernel Boot Flow

## High-level kernel sequence

```text
arch entry
  -> decompress kernel if needed
  -> setup architecture
  -> start_kernel()
  -> setup scheduler, IRQ, timers, memory, RCU
  -> rest_init()
  -> kernel_init()
  -> do_basic_setup()
  -> initcalls
  -> mount rootfs
  -> run /sbin/init or configured init
```

## Why `start_kernel()` matters

`start_kernel()` is the center of early kernel initialization. It sets up the minimum operating environment before normal kernel threads and driver initialization can proceed.

## initcall levels

Common levels include:

- early
- core
- postcore
- arch
- subsys
- fs
- device
- late

A slow initcall may represent real hardware initialization. Or it may represent avoidable waiting.

## Kernel command line parameters for analysis

```text
initcall_debug
ignore_loglevel
loglevel=8
printk.time=1
earlycon
ftrace=function_graph
trace_event=initcall:initcall_start,initcall:initcall_finish
```

Use only what your kernel supports.
