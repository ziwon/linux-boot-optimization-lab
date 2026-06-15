# Module 04 — Device Tree, Platform Devices, and Probe

## Device Tree is not code, but it controls code

A device tree describes hardware that the kernel cannot discover automatically. The kernel reads the tree, creates device objects, and matches drivers using compatible strings.

## Minimal platform device flow

```text
DTS node
  -> flattened DTB
  -> unflattened kernel tree
  -> platform_device created
  -> driver compatible match
  -> probe() called
```

## Important properties

- `compatible`
- `reg`
- `interrupts`
- `clocks`
- `resets`
- `pinctrl-*`
- `gpios`
- `power-domains`
- `iommus`
- `status`

## Deferred probe

Deferred probe is not a bug by itself. It means a dependency was not available yet.

Common causes:

- regulator driver not ready
- clock provider not ready
- GPIO controller not ready
- PHY not ready
- pinctrl missing
- device link supplier not available
- wrong device tree phandle

## Practical debugging

```bash
dmesg | grep -i deferred
cat /sys/kernel/debug/devices_deferred
cat /sys/kernel/debug/clk/clk_summary
cat /sys/kernel/debug/regulator/regulator_summary
```
