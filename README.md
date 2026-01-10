# uconsole_better_keyboard

A modified version of the **ClockworkPi uConsole keyboard firmware** that improves trackball handling and restores preferred scrolling behavior.

## Overview

This project is based on the original Arduino-based uConsole keyboard firmware and introduces a few targeted quality-of-life improvements.  
The goal is to improve daily usability while keeping the stock firmware’s low power consumption and stability.

The changes are documented in this ClockworkPi forum thread:  
https://forum.clockworkpi.com/t/custom-keyboard-firmware/20971

## Flashing the firmware

Since it is still based on the stock firmware, it can be flashed using the standard ClockworkPi tools:

```bash
sudo ./maple_upload ttyACM0 2 1EAF:0003 clockworkpi_uconsole_custom_20260108.ino.bin
```

## Features

- Restores **Select + Trackball scrolling** instead of the default Fn-based scrolling
- Improved trackball responsiveness and smoothing
- Keeps the original Arduino firmware (no QMK, no additional power drain)
- Fully compatible with the standard uConsole keyboard flashing process

> ⚠️ **Warning:** This is unofficial firmware. Flashing is done at your own risk.

## Background

This project keeps the original firmware architecture while applying small, focused improvements where they matter most.
