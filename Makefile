ODIN ?= $(shell which odin)
ODIN_FLAGS := 

SED := $(shell which sed)

WORK_DIR := $(shell pwd)
OCBINDGEN_DIR := $(WORK_DIR)/odin-c-bindgen
WGPU_DIR := $(WORK_DIR)/wgpu-native

ODINGEN := $(WORK_DIR)/odin-gen.exe
ODIN_FLAGS += $(OCBINDGEN_DIR)/src -out:$(ODINGEN)

TEMPL_FILE := $(WORK_DIR)/bindings.sjson.templ 
BINDINGS_OUT := $(WORK_DIR)/bindings.sjson

WGPU_HEADER := $(WGPU_DIR)/ffi/wgpu.h
WEBGPU_HEADER := $(WGPU_DIR)/ffi/webgpu-headers/webgpu.h

.PHONY: all template bindgen clean

all: $(ODINGEN) template bindgen

$(ODINGEN): $(OCBINDGEN_DIR)
	$(ODIN) build $(ODIN_FLAGS)

template: $(TEMPL_FILE) $(WGPU_HEADER) $(WEBGPU_HEADER)
	$(SED) -e 's|@WGPU_HEADER@|$(WGPU_HEADER)|g' \
		-e 's|@WEBGPU_HEADER@|$(WEBGPU_HEADER)|g' \
		$(TEMPL_FILE) > $(BINDINGS_OUT)

bindgen: $(ODINGEN) $(BINDINGS_OUT)
	$(ODINGEN) $(WORK_DIR)