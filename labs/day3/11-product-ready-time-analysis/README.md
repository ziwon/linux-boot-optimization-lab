# Lab 3-11 - Product Ready Time Analysis

## Objective

Measure product-ready time using kernel and user-space evidence.

## Tasks

1. Read `modules/21-product-boot-kpi-tracing/README.md`.
2. Define product-ready and subsystem-ready markers.
3. Compare kernel boot time with product-ready time.
4. Identify ownership for each gap.

## Sample-data mode

Use the synthetic product readiness markers:

```bash
cat sample-data/day3/product-ready.log
column -s, -t sample-data/day3/wearable-boot-requirements.csv
```

Compare actual marker times with the KPI budgets.

## Hardware mode

Use real boot logs, service logs, and application readiness markers from the product.

## Deliverable

A product-ready KPI report with baseline, gaps, owners, and regression thresholds.
