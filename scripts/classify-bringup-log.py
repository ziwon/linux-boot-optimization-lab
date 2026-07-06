#!/usr/bin/env python3
import sys
from pathlib import Path

if len(sys.argv) < 2:
    print("usage: classify-bringup-log.py <boot.log> [boot.log ...]", file=sys.stderr)
    sys.exit(1)

RULES = [
    ("user space reached", "User space", "qemu-init: user space reached"),
    ("no working init", "Rootfs / init", "No working init found"),
    ("unable to mount root fs", "Rootfs / storage", "Unable to mount root filesystem"),
    ("vfs: cannot open root device", "Rootfs / storage", "Cannot open root device"),
    ("run /init as init process", "Rootfs", "Kernel started init process"),
    ("linux version", "Kernel entry", "Linux kernel banner visible"),
    ("initcall", "Kernel / driver init", "initcall_debug evidence visible"),
]

print("| Log | Last known-good stage | Suspected owner | Evidence |")
print("|---|---|---|---|")
for arg in sys.argv[1:]:
    path = Path(arg)
    if not path.exists():
        print(f"warning: log not found: {path}", file=sys.stderr)
        continue

    text = path.read_text(errors="replace")
    low = text.lower()
    owner = "Unknown"
    evidence = "No known pattern matched"
    last = "Unknown"

    # Prefer failure classifications before success markers.
    if "requested init" in low and "failed" in low:
        owner = "Rootfs / init"
        evidence = "Requested init executable failed"
        last = "Rootfs selected init" if "run /init as init process" in low else "Kernel entry"
    else:
        for needle, rule_owner, rule_evidence in RULES[1:4]:
            if needle in low:
                owner = rule_owner
                evidence = rule_evidence
                if "linux version" in low:
                    last = "Kernel entry"
                if "run /init as init process" in low:
                    last = "Rootfs selected init"
                break
        else:
            if "qemu-init: user space reached" in low:
                owner = "None observed"
                evidence = "qemu-init reached user space"
                last = "User space"
            elif "run /init as init process" in low:
                owner = "Rootfs / init"
                evidence = "Kernel attempted to run init"
                last = "Rootfs"
            elif "initcall" in low:
                owner = "Kernel / driver init"
                evidence = "initcall_debug output visible"
                last = "Driver init"
            elif "linux version" in low:
                owner = "Kernel handoff"
                evidence = "Kernel banner visible"
                last = "Kernel entry"

    print(f"| `{path}` | {last} | {owner} | {evidence} |")
