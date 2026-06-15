#!/usr/bin/env python3
import re
import sys
from pathlib import Path

if len(sys.argv) != 2:
    print("usage: parse-initcall-debug.py <dmesg-or-initcall-log>", file=sys.stderr)
    sys.exit(2)

path = Path(sys.argv[1])
text = path.read_text(errors="replace")
pat = re.compile(r"initcall\s+([^\s]+).*?returned\s+(-?\d+)\s+after\s+(\d+)\s+usecs")
rows = []
for line in text.splitlines():
    m = pat.search(line)
    if m:
        rows.append((int(m.group(3))/1000.0, m.group(1), int(m.group(2)), line.strip()))

if not rows:
    print("No initcall_debug rows found.")
    sys.exit(1)

print("Top initcalls by duration")
print("=========================")
for ms, name, ret, line in sorted(rows, reverse=True)[:30]:
    print(f"{ms:10.3f} ms  ret={ret:>3}  {name}")

print("\nTotal measured initcall time: %.3f ms" % sum(r[0] for r in rows))
