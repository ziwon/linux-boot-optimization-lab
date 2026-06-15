# Linux Boot Optimization Lab

A self-study lab for Linux boot flow, BSP bring-up, kernel initialization, driver probe, tracing, and boot-time optimization on embedded systems.

The repository includes short modules, guided labs, sample logs, small analysis scripts, and report templates. You can work through it with the included sample data, then apply the same workflow to your own board logs under `local-artifacts/`.

## Scope

This lab focuses on practical boot analysis:

- boot chain from firmware to user space
- U-Boot handoff, symbols, sections, and board initialization
- Device Tree, platform devices, driver matching, and probe ordering
- `initcall_debug`, ftrace, boot logs, and trace-based bottleneck analysis
- deferred probe, async probe, and dependency debugging
- boot optimization review, validation, and regression guards
- optional wearable/smart-glasses readiness and latency analysis

## Repository structure

```text
.
├── docs/                 # Conceptual explanations and study notes
├── modules/              # Structured learning modules, from foundations to advanced optimization
├── labs/                 # Day-by-day guided exercises
├── exercises/            # Standalone deep-dive assignments
├── scripts/              # Small analysis tools for logs, DTB, and boot metrics
├── sample-data/          # Synthetic sample logs for local practice
├── local-artifacts/      # Place your own board logs, dumps, and binaries here
├── case-studies/         # Boot-time optimization case studies
├── checklists/           # Bring-up and optimization checklists
└── templates/            # Report templates
```

## Quick start

### Option A: Use your host machine

Install the common embedded Linux tools:

```bash
sudo apt-get update
sudo apt-get install -y \
  build-essential git make bc bison flex libssl-dev libelf-dev \
  device-tree-compiler qemu-system-arm qemu-system-aarch64 \
  u-boot-tools binutils gcc-aarch64-linux-gnu python3 python3-pip \
  trace-cmd
```

Run the sample analyzers:

```bash
make analyze-initcall
make analyze-ftrace
make summarize-samples
```

### Option B: Use Docker

```bash
make docker-build
make docker-shell
```

Inside the container:

```bash
make analyze-initcall
make analyze-ftrace
```

## Learning path

### Day 0 — Preparation

Read these first:

1. `docs/self-study-overview.md`
2. `docs/self-study-design.md`
3. `docs/learning-path.md`
4. `modules/00-foundations/README.md`
5. `modules/01-boot-chain/README.md`

### Day 1 — Bring-up fundamentals

Follow:

1. `labs/day1/01-bsp-boot-process/README.md`
2. `labs/day1/02-bringup-debugging-methods/README.md`
3. `labs/day1/03-uboot-structure/README.md`
4. `labs/day1/04-uboot-core-features/README.md`
5. `labs/day1/05-kernel-boot-flow/README.md`
6. `labs/day1/06-bringup-issues-debugging/README.md`

### Day 2 — Debugging and optimization

Follow:

1. `labs/day2/01-kernel-boot-debugging/README.md`
2. `labs/day2/02-driver-init-debugging/README.md`
3. `labs/day2/03-boot-time-optimization-techniques/README.md`
4. `labs/day2/04-boot-time-optimization-case-study/README.md`

### Optional Day 3 extension — Wearable and physical AI systems

Each Day 3 lab supports a `Sample-data mode` for individual self-study without wearable hardware, plus a `Hardware mode` for applying the same workflow to a real board. The synthetic inputs are under `sample-data/day3/`.

Follow:

1. `labs/day3/01-wearable-boot-requirements/README.md`
2. `labs/day3/02-iio-imu-driver-lab/README.md`
3. `labs/day3/03-sensor-event-pipeline/README.md`
4. `labs/day3/04-i2s-microphone-asoc-lab/README.md`
5. `labs/day3/05-runtime-pm-sensor-power-lab/README.md`
6. `labs/day3/06-imu-timestamp-and-fifo-analysis/README.md`
7. `labs/day3/07-proximity-gesture-input-lab/README.md`
8. `labs/day3/08-camera-imu-latency-budget/README.md`
9. `labs/day3/09-deferred-probe-debugging-for-sensors/README.md`
10. `labs/day3/10-irq-workqueue-latency-tracing/README.md`
11. `labs/day3/11-product-ready-time-analysis/README.md`
12. `labs/day3/12-sensor-hub-event-routing/README.md`

### Advanced modules

Use these modules when you want more depth or need the Day 3 wearable extension:

- `modules/07-kernel-internals/README.md`
- `modules/08-ftrace-and-tracing/README.md`
- `modules/09-boot-time-optimization/README.md`
- `modules/10-production-debugging/README.md`
- `modules/11-kernel-engineer-mindset/README.md`
- `modules/12-smart-glasses-linux-architecture/README.md`
- `modules/13-linux-sensor-subsystems/README.md`
- `modules/14-linux-audio-asoc-for-wearables/README.md`
- `modules/15-runtime-pm-and-wakeup-sources/README.md`
- `modules/16-sensor-fusion-kernel-interface/README.md`
- `modules/17-tof-proximity-gesture-input/README.md`
- `modules/18-camera-display-latency-for-ar/README.md`
- `modules/19-device-tree-dependency-and-deferred-probe/README.md`
- `modules/20-kernel-latency-for-physical-ai/README.md`
- `modules/21-product-boot-kpi-tracing/README.md`
- `modules/22-sensor-hub-and-edge-ai-kernel-interface/README.md`

## Local artifacts

Board-specific files are not included. Put your own logs, dumps, traces, and U-Boot ELF files here:

```text
local-artifacts/
├── uboot-elf/
├── kernel-dump/
└── ftrace-log/
```

Synthetic practice data is available under `sample-data/`.

## Working rule

Before changing code or configuration, answer:

1. What is the measured boot-time budget?
2. Which stage owns the delay?
3. Is the delay required for hardware correctness?
4. Can initialization be moved later, parallelized, deferred, cached, or removed?
5. What evidence proves the improvement and protects against regression?

Optimize from evidence, not guesses.
