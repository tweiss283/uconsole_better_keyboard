# Makefile for uConsole Better Keyboard Firmware
# This Makefile automates the build and flashing process for the uConsole keyboard firmware

.PHONY: help build compile upload flash clean

# Arduino CLI configuration
ARDUINO_CLI ?= arduino-cli
FQBN ?= maple:STM32F1:maple
SKETCH_DIR := $(CURDIR)
SKETCH := $(SKETCH_DIR)/uconsole_keyboard.ino
BUILD_DIR := $(SKETCH_DIR)/build
BUILD_PATH := $(BUILD_DIR)/uconsole_keyboard.ino.bin

# Flashing configuration
MAPLE_UPLOAD ?= ./maple_upload
SERIAL_PORT ?= /dev/ttyACM0
MAPLE_RESET_ID ?= 2
MAPLE_DFU_ID ?= 1EAF:0003

# Output binary naming
OUTPUT_BIN = uconsole_keyboard.ino.bin
VERSION ?= $(shell date +%Y%m%d)
OUTPUT_VERSIONED = clockworkpi_uconsole_custom_$(VERSION).ino.bin

help:
	@echo "uConsole Better Keyboard - Build Automation"
	@echo ""
	@echo "Available targets:"
	@echo "  make build        - Compile the firmware (requires arduino-cli)"
	@echo "  make compile      - Alias for 'build'"
	@echo "  make upload       - Flash firmware to device (requires maple_upload)"
	@echo "  make flash        - Alias for 'upload'"
	@echo "  make install      - Build and flash to device"
	@echo "  make copy         - Copy built binary with version stamp"
	@echo "  make clean        - Remove build artifacts"
	@echo ""
	@echo "Configuration variables:"
	@echo "  ARDUINO_CLI       - Path to arduino-cli (default: arduino-cli)"
	@echo "  SERIAL_PORT       - Serial port for flashing (default: /dev/ttyACM0)"
	@echo "  VERSION           - Version stamp for output file (default: current date)"
	@echo ""
	@echo "Examples:"
	@echo "  make build"
	@echo "  make install SERIAL_PORT=/dev/ttyACM0"
	@echo "  make upload VERSION=20260108"

# Build target: Compile the sketch
build: $(BUILD_PATH)

$(BUILD_PATH):
	@echo "Building firmware..."
	@mkdir -p $(BUILD_DIR)
	$(ARDUINO_CLI) compile --fqbn $(FQBN) $(SKETCH) --output-dir $(BUILD_DIR)
	@echo "Build complete: $(BUILD_PATH)"

compile: build

# Flash target: Upload to device using maple_upload
upload: $(BUILD_PATH)
	@echo "Flashing firmware to device at $(SERIAL_PORT)..."
	@if [ ! -f "$(MAPLE_UPLOAD)" ]; then \
		echo "Error: maple_upload tool not found at $(MAPLE_UPLOAD)"; \
		echo "Please download it from https://github.com/clockworkpi/uConsole"; \
		exit 1; \
	fi
	@if [ ! -e "$(SERIAL_PORT)" ]; then \
		echo "Error: Serial port $(SERIAL_PORT) not found"; \
		echo "Make sure the device is connected and using the correct port"; \
		exit 1; \
	fi
	sudo $(MAPLE_UPLOAD) $(SERIAL_PORT) $(MAPLE_RESET_ID) $(MAPLE_DFU_ID) $(BUILD_PATH)
	@echo "Flashing complete!"

flash: upload

# Install target: Build and flash in one step
install: build upload
	@echo "Installation complete!"

# Copy target: Copy the built binary with version stamp
copy: $(BUILD_PATH)
	@echo "Copying binary with version stamp: $(OUTPUT_VERSIONED)"
	@cp $(BUILD_PATH) $(SKETCH_DIR)/$(OUTPUT_VERSIONED)
	@echo "Copied to: $(SKETCH_DIR)/$(OUTPUT_VERSIONED)"

# Clean target: Remove build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -rf $(BUILD_DIR)
	@echo "Clean complete"

# Setup target: Install dependencies
setup:
	@echo "Installing Arduino CLI..."
	@command -v $(ARDUINO_CLI) >/dev/null 2>&1 || { \
		echo "arduino-cli not found. Installing..."; \
		curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh; \
	}
	@echo "Run: make build"
