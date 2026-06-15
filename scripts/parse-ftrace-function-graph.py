#!/usr/bin/env python3
import re
import sys
from pathlib import Path

if len(sys.argv) != 2:
    print("usage: parse-ftrace-function-graph.py <trace>", file=sys.stderr)
    sys.exit(2)

path = Path(sys.argv[1])
rows = []
pat = re.compile(r"\)\s+(?:[+!#*@]\s*)?([0-9]+(?:\.[0-9]+)?)\s+(us|ms|s)\s+\|\s+(.*)")
for line in path.read_text(errors="replace").splitlines():
    m = pat.search(line)
    if not m:
        continue
    val = float(m.group(1))
    unit = m.group(2)
    fn = m.group(3).strip()
    ms = val / 1000 if unit == "us" else val * 1000 if unit == "s" else val
    rows.append((ms, fn))

if not rows:
    print("No function_graph duration rows found.", file=sys.stderr)
    sys.exit(1)

print("Top function_graph calls by duration")
print("====================================")
for ms, fn in sorted(rows, reverse=True)[:20]:
    print(f"{ms:10.3f} ms  {fn}")
