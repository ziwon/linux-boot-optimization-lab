# Lab 3-4 - I2S Microphone ASoC Lab

## Objective

Map an I2S or PDM microphone path through Linux ASoC.

## Tasks

1. Read `modules/14-linux-audio-asoc-for-wearables/README.md`.
2. Identify CPU DAI, codec DAI, machine driver, and DAPM routes.
3. Check which path is required for audio wake.
4. Record clocks, regulators, and wake IRQs.

## Sample-data mode

Use the synthetic ASoC component map:

```bash
cat sample-data/day3/asoc-components.txt
cat sample-data/day3/wakeup_sources.txt
```

Map the microphone path, wake IRQ, DAPM route, and required power resources.

## Hardware mode

```bash
aplay -l
arecord -l
find /sys/kernel/debug/asoc -maxdepth 3 -type f | sort
```

## Deliverable

An ASoC path map from microphone hardware to ALSA PCM or wake event.
