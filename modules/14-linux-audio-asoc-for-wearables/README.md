# Module 14 — Linux Audio and ASoC for Wearables

## Goal

Understand microphone, speaker, codec, DSP, and low-power wake paths in Linux ASoC.

## ASoC Model

```text
CPU DAI
  -> audio interface such as I2S, TDM, PDM
  -> codec DAI
  -> widgets, routes, controls
  -> ALSA PCM / controls
```

Wearables often need always-on voice or acoustic event detection. The product architecture must separate high-power capture from low-power wake.

## Kernel Areas

- machine driver
- codec driver
- CPU DAI driver
- DAPM widgets and routes
- clock and regulator sequencing
- wake-capable IRQs or DSP notifications

## Questions

- Which audio path is required at boot?
- Which path must remain wake-capable in suspend?
- Does the microphone need a DSP or sensor hub before Linux audio is fully ready?
