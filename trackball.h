#ifndef TRACKBALL_H
#define TRACKBALL_H

#include "devterm.h"

#include "keys_io_map.h"

/*
#define BOUNCE_INTERVAL       30 
#define BASE_MOVE_PIXELS      5  
#define EXPONENTIAL_BOUND     15
#define EXPONENTIAL_BASE      1.2
*/

#define RIGHT_PIN             HO2
#define LEFT_PIN              HO4
#define DOWN_PIN              HO3
#define UP_PIN                HO1


// Trackball tuning constants (single discoverable location)
// Tweak these to match desired feel (values chosen to match QMK fork)
// Preset tuned values (QMK-like feel)
// - Slightly boost X sensitivity to match handheld feel
// - Small deadzone to remove tick/jitter
static constexpr float TB_SENS_X = 1.2f;    // multiply X velocity
static constexpr float TB_SENS_Y = 1.1f;    // multiply Y velocity
static constexpr int8_t TB_DEADZONE = 1;    // movement below this is ignored
static constexpr float TB_ACCEL_DIV = 30.0f; // divisor used in accel curve (QMK uses ~30)
static constexpr int8_t TB_WHEEL_DENOM = 2; // wheel accumulation denom
static constexpr int8_t TB_SCROLL_SCALE_V = 1; // vertical scroll scale (integer)
static constexpr int8_t TB_SCROLL_SCALE_H = 1; // horizontal scroll scale (integer)

// Enable runtime debug printing via DEVTERM->_Serial when set to 1
// Keep disabled for normal builds.
#ifndef TB_DEBUG
#define TB_DEBUG 0
#endif

void trackball_init(DEVTERM*);
void trackball_task(DEVTERM*);


#endif
