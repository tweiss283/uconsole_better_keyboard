# CHANGELOG

## 2026-01-08  — Trackball QMK-feel port
- Added trackball tuning constants in `trackball.h` (sensitivity, deadzone, accel divisor, wheel denom, scroll scale, debug).
- Updated `trackball.ino` to use tuning constants: time-based accel curve, sensitivity scaling, deadzone filtering, and per-axis wheel buffering.
- Ensured scrolling is triggered by Select (`Keyboard_state.select_on`) only. Fn no longer enables wheel mode.
- Added `TB_DEBUG` compile-time flag (default 0) to enable runtime serial debug output for deltas/mode.

Notes: constants to tune for feel: `TB_SENS_X`, `TB_SENS_Y`, `TB_DEADZONE`, `TB_ACCEL_DIV`, `TB_WHEEL_DENOM`, `TB_SCROLL_SCALE_V`.
 
## 2026-01-08  — Tuning preset applied
- Applied conservative QMK-like tuning preset in `trackball.h`: `TB_SENS_X=1.2`, `TB_SENS_Y=1.1`, `TB_DEADZONE=1`, `TB_ACCEL_DIV=30`.
