ODIN ?= $(shell which odin)
ODIN_FLAGS := 

SED := $(shell which sed)
GIT := $(shell which git)
CARGO := $(shell which cargo)

WORK_DIR := $(shell pwd)
OCBINDGEN_DIR := $(WORK_DIR)/odin-c-bindgen
WGPU_DIR := $(WORK_DIR)/wgpu-native
WGPU_FFI_DIR := $(WGPU_DIR)/ffi
WEBGPU_DIR := $(WGPU_FFI_DIR)/webgpu-headers
WGPU_ODIN_DIR := $(WGPU_FFI_DIR)/wgpu
TEMPLATES_DIR := $(WORK_DIR)/templates

WGPU_HEADER := $(WGPU_FFI_DIR)/wgpu.h
WEBGPU_HEADER := $(WEBGPU_DIR)/webgpu.h

WGPU_TARGET_DIR := $(WGPU_DIR)/target/release

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    WGPU_LIB_NAME := libwgpu_native.a
    WGPU_LIB_PATH := $(WGPU_TARGET_DIR)/libwgpu_native.a
endif
ifeq ($(UNAME_S),Darwin)
    WGPU_LIB_NAME := libwgpu_native.a
    WGPU_LIB_PATH := $(WGPU_TARGET_DIR)/libwgpu_native.a
endif
ifeq ($(OS),Windows_NT)
    WGPU_LIB_NAME := wgpu_native.lib
    WGPU_LIB_PATH := $(WGPU_TARGET_DIR)/wgpu_native.lib
endif

ODINGEN := $(WORK_DIR)/odin-gen.exe
ODIN_FLAGS += $(OCBINDGEN_DIR)/src -out:$(ODINGEN)

TEMPL_FILE := $(TEMPLATES_DIR)/bindgen.sjson.templ 
BINDINGS_OUT := $(WORK_DIR)/bindgen.sjson

ODIN_TEMPL_FILE := $(TEMPLATES_DIR)/foreign.odin.templ
ODIN_FOREIGN_OUT := $(WORK_DIR)/foreign.odin

.PHONY: all submodule odin-template json-template template bindgen wgpu-lib clean

all: submodule wgpu-lib $(ODINGEN) template bindgen

template: odin-template json-template

$(ODINGEN): $(OCBINDGEN_DIR)
	$(ODIN) build $(ODIN_FLAGS)

wgpu-lib: $(WGPU_LIB_PATH)

$(WGPU_LIB_PATH): $(WGPU_DIR)/Cargo.toml
	$(CARGO) build --release --manifest-path $(WGPU_DIR)/Cargo.toml

odin-template: $(ODIN_TEMPL_FILE)
	$(SED) -e 's|@LIB_FILE@|$(WGPU_LIB_PATH)|g' \
		$(ODIN_TEMPL_FILE) > $(ODIN_FOREIGN_OUT)

json-template: $(TEMPL_FILE) $(WGPU_HEADER) $(WEBGPU_HEADER)
	$(SED) -e 's|@WGPU_HEADER@|$(WGPU_HEADER)|g' \
		-e 's|@WEBGPU_HEADER@|$(WEBGPU_HEADER)|g' \
		-e 's|@WGPU_FFI_DIR@|$(WGPU_FFI_DIR)|g' \
		-e 's|@WEBPU_DIR@|$(WEBGPU_DIR)|g' \
		-e 's|@ODIN_FORGEIN_OUT@|$(ODIN_FOREIGN_OUT)|g' \
		$(TEMPL_FILE) > $(BINDINGS_OUT)


bindgen: $(ODINGEN) $(BINDINGS_OUT)
	$(ODINGEN) $(WORK_DIR)

submodule:
	$(GIT) submodule update --init --recursive
	
clean:
	rm -f $(ODINGEN)
	rm -f $(BINDINGS_OUT)
	rm -rf $(WGPU_ODIN_DIR)
	$(CARGO) clean --manifest-path $(WGPU_DIR)/Cargo.toml