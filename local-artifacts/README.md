# Local Artifacts

Use this directory for board-specific logs, dumps, and binaries that you provide locally.

This repository does not include private vendor binaries or board-specific files for copyright and security reasons. Place your own local artifacts in the directories below, then use them with the relevant labs.

```text
local-artifacts/
├── uboot-elf/      # U-Boot ELF, map, and symbol files
├── kernel-dump/    # kernel memory dumps, dmesg, and boot logs
└── ftrace-log/     # function_graph, initcall, and boot-time ftrace logs
```

## Recommended File Names

```text
local-artifacts/uboot-elf/u-boot.elf
local-artifacts/uboot-elf/u-boot.map
local-artifacts/kernel-dump/boot.log
local-artifacts/kernel-dump/dmesg.log
local-artifacts/ftrace-log/trace.txt
local-artifacts/ftrace-log/initcall_debug.log
```
