# Lab 3-1 - Wearable Boot Requirements

## Objective

Define boot and readiness requirements for a smart-glasses or wearable Linux product.

## Tasks

1. Read `modules/12-smart-glasses-linux-architecture/README.md`.
2. Define product-ready time separately from kernel boot time.
3. List mandatory and optional devices for first interaction.
4. Create a boot KPI table with owners and evidence.

## Sample-data mode

Use the synthetic KPI table when you do not have hardware:

```bash
column -s, -t sample-data/day3/wearable-boot-requirements.csv
cat sample-data/day3/product-ready.log
```

Decide which KPIs are required for launch and which can complete later.

## Hardware mode

Use real boot logs, service logs, and application readiness markers from `local-artifacts/`.

## Deliverable

A wearable boot requirement table with readiness definitions, timing budgets, and validation evidence.
