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

WGPU_HEADER := $(WGPU_FFI_DIR)/wgpu.h
WEBGPU_HEADER := $(WEBGPU_DIR)/webgpu.h

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    WGPU_LIB_NAME := libwgpu_native.a
    WGPU_DYN_LIB_NAME := libwgpu_native.so
endif
ifeq ($(UNAME_S),Darwin)
    WGPU_LIB_NAME := libwgpu_native.a
    WGPU_DYN_LIB_NAME := libwgpu_native.dylib
endif
ifeq ($(OS),Windows_NT)
    WGPU_LIB_NAME := wgpu_native.lib
    WGPU_DYN_LIB_NAME := wgpu_native.dll
endif

WGPU_TARGET_DIR := $(WGPU_DIR)/target/release
WGPU_LIB_PATH := $(WGPU_TARGET_DIR)/$(WGPU_LIB_NAME)

ODINGEN := $(WORK_DIR)/odin-gen.exe
ODIN_FLAGS += $(OCBINDGEN_DIR)/src -out:$(ODINGEN)

TEMPL_FILE := $(WORK_DIR)/bindgen.sjson.templ 
BINDINGS_OUT := $(WORK_DIR)/bindgen.sjson

.PHONY: all submodule template bindgen wgpu-lib clean

all: submodule wgpu-lib $(ODINGEN) template bindgen

$(ODINGEN): $(OCBINDGEN_DIR)
	$(ODIN) build $(ODIN_FLAGS)

wgpu-lib: $(WGPU_LIB_PATH)

$(WGPU_LIB_PATH): $(WGPU_DIR)/Cargo.toml
	$(CARGO) build --release --manifest-path $(WGPU_DIR)/Cargo.toml

template: $(TEMPL_FILE) $(WGPU_HEADER) $(WEBGPU_HEADER)
	$(SED) -e 's|@WGPU_HEADER@|$(WGPU_HEADER)|g' \
		-e 's|@WEBGPU_HEADER@|$(WEBGPU_HEADER)|g' \
		-e 's|@WGPU_FFI_DIR@|$(WGPU_FFI_DIR)|g' \
		-e 's|@WEBPU_DIR@|$(WEBGPU_DIR)|g' \
		$(TEMPL_FILE) > $(BINDINGS_OUT)

bindgen: $(ODINGEN) $(BINDINGS_OUT)
	$(ODINGEN) $(WORK_DIR)

submodule:
	$(GIT) submodule update --init --recursive
	
clean:
	rm -f $(ODINGEN)
	rm -f $(BINDINGS_OUT)
	rm -rf $(WORK_DIR)/wgpu
	$(CARGO) clean --manifest-path $(WGPU_DIR)/Cargo.toml