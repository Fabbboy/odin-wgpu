# =============================================================================
# Odin WGPU Bindings Generator Makefile
# =============================================================================

# External Tools
ODIN   ?= $(shell which odin)
SED    := $(shell which sed)
GIT    := $(shell which git)
CARGO  := $(shell which cargo)

# Verify required tools are available
ifeq ($(ODIN),)
$(error "odin not found in PATH")
endif
ifeq ($(SED),)
$(error "sed not found in PATH")
endif
ifeq ($(GIT),)
$(error "git not found in PATH")
endif
ifeq ($(CARGO),)
$(error "cargo not found in PATH")
endif

# =============================================================================
# Directory Structure
# =============================================================================
WORK_DIR      := $(shell pwd)
OCBINDGEN_DIR := $(WORK_DIR)/odin-c-bindgen
WGPU_DIR      := $(WORK_DIR)/wgpu-native
WGPU_FFI_DIR  := $(WGPU_DIR)/ffi
WEBGPU_DIR    := $(WGPU_FFI_DIR)/webgpu-headers
WGPU_ODIN_DIR := $(WGPU_FFI_DIR)/wgpu
TEMPLATES_DIR := $(WORK_DIR)/templates

# =============================================================================
# Header Files
# =============================================================================
WGPU_HEADER   := $(WGPU_FFI_DIR)/wgpu.h
WEBGPU_HEADER := $(WEBGPU_DIR)/webgpu.h

# =============================================================================
# Platform-specific Library Configuration
# =============================================================================
WGPU_TARGET_DIR := $(WGPU_DIR)/target/release

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    WGPU_LIB_NAME := libwgpu_native.a
    WGPU_LIB_PATH := $(WGPU_TARGET_DIR)/$(WGPU_LIB_NAME)
else ifeq ($(UNAME_S),Darwin)
    WGPU_LIB_NAME := libwgpu_native.a
    WGPU_LIB_PATH := $(WGPU_TARGET_DIR)/$(WGPU_LIB_NAME)
else ifeq ($(OS),Windows_NT)
    WGPU_LIB_NAME := wgpu_native.lib
    WGPU_LIB_PATH := $(WGPU_TARGET_DIR)/$(WGPU_LIB_NAME)
else
$(error "Unsupported platform: $(UNAME_S)")
endif

# =============================================================================
# Generator Configuration
# =============================================================================
ODINGEN         := $(WORK_DIR)/odin-gen.exe
ODIN_BUILD_FLAGS := $(OCBINDGEN_DIR)/src -out:$(ODINGEN)

# =============================================================================
# Template Files and Outputs
# =============================================================================
TEMPL_FILE        := $(TEMPLATES_DIR)/bindgen.sjson.templ
BINDINGS_OUT      := $(WORK_DIR)/bindgen.sjson
ODIN_TEMPL_FILE   := $(TEMPLATES_DIR)/foreign.odin.templ
ODIN_FOREIGN_OUT  := $(WORK_DIR)/foreign.odin

# =============================================================================
# Phony Targets
# =============================================================================
.PHONY: all help submodule wgpu-lib generator templates bindgen clean

# =============================================================================
# Default Target
# =============================================================================
all: submodule wgpu-lib generator templates bindgen

# =============================================================================
# Help Target
# =============================================================================
help: ## Show this help message
	@echo "Available targets:"
	@echo "  all        - Build everything (default)"
	@echo "  submodule  - Initialize and update git submodules"
	@echo "  wgpu-lib   - Build the WGPU native library"
	@echo "  generator  - Build the Odin binding generator"
	@echo "  templates  - Generate templates from template files"
	@echo "  bindgen    - Run the binding generator"
	@echo "  clean      - Clean build artifacts"
	@echo "  help       - Show this help message"

# =============================================================================
# Build Targets
# =============================================================================

# Initialize and update git submodules
submodule:
	@echo "Updating git submodules..."
	$(GIT) submodule update --init --recursive

# Build the WGPU native library
wgpu-lib: $(WGPU_LIB_PATH)

$(WGPU_LIB_PATH): $(WGPU_DIR)/Cargo.toml
	@echo "Building WGPU native library..."
	$(CARGO) build --release --manifest-path $(WGPU_DIR)/Cargo.toml

# Build the Odin binding generator
generator: $(ODINGEN)

$(ODINGEN): $(OCBINDGEN_DIR)
	@echo "Building Odin binding generator..."
	$(ODIN) build $(ODIN_BUILD_FLAGS)

# Generate all template files
templates: $(ODIN_FOREIGN_OUT) $(BINDINGS_OUT)

# Generate Odin foreign file from template
$(ODIN_FOREIGN_OUT): $(ODIN_TEMPL_FILE) $(WGPU_LIB_PATH)
	@echo "Generating Odin foreign bindings template..."
	$(SED) 's|@LIB_FILE@|$(WGPU_LIB_PATH)|g' $(ODIN_TEMPL_FILE) > $(ODIN_FOREIGN_OUT)

# Generate JSON bindings configuration from template
$(BINDINGS_OUT): $(TEMPL_FILE) $(WGPU_HEADER) $(WEBGPU_HEADER)
	@echo "Generating JSON bindings configuration..."
	$(SED) \
		-e 's|@WGPU_HEADER@|$(WGPU_HEADER)|g' \
		-e 's|@WEBGPU_HEADER@|$(WEBGPU_HEADER)|g' \
		-e 's|@WGPU_FFI_DIR@|$(WGPU_FFI_DIR)|g' \
		-e 's|@WEBPU_DIR@|$(WEBGPU_DIR)|g' \
		-e 's|@ODIN_FORGEIN_OUT@|$(ODIN_FOREIGN_OUT)|g' \
		$(TEMPL_FILE) > $(BINDINGS_OUT)

# Run the binding generator
bindgen: $(ODINGEN) $(BINDINGS_OUT)
	@echo "Running binding generator..."
	$(ODINGEN) $(WORK_DIR)

# =============================================================================
# Cleanup Target
# =============================================================================
clean: ## Clean all build artifacts
	@echo "Cleaning build artifacts..."
	rm -f $(ODINGEN)
	rm -f $(BINDINGS_OUT)
	rm -f $(ODIN_FOREIGN_OUT)
	rm -rf $(WGPU_ODIN_DIR)
	$(CARGO) clean --manifest-path $(WGPU_DIR)/Cargo.toml