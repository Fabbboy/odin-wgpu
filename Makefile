ODIN ?= $(shell which odin)
ODIN_FLAGS := 

SED := $(shell which sed)
GIT := $(shell which git)

WORK_DIR := $(shell pwd)
OCBINDGEN_DIR := $(WORK_DIR)/odin-c-bindgen
WGPU_DIR := $(WORK_DIR)/wgpu-native
WGPU_FFI_DIR := $(WGPU_DIR)/ffi
WEBGPU_DIR := $(WGPU_FFI_DIR)/webgpu-headers

WGPU_HEADER := $(WGPU_FFI_DIR)/wgpu.h
WEBGPU_HEADER := $(WEBGPU_DIR)/webgpu.h

ODINGEN := $(WORK_DIR)/odin-gen.exe
ODIN_FLAGS += $(OCBINDGEN_DIR)/src -out:$(ODINGEN)

TEMPL_FILE := $(WORK_DIR)/bindgen.sjson.templ 
BINDINGS_OUT := $(WORK_DIR)/bindgen.sjson

WGPU_HEADER := $(WGPU_DIR)/ffi/wgpu.h

.PHONY: all submodule template bindgen clean

all: submodule $(ODINGEN) template bindgen

$(ODINGEN): $(OCBINDGEN_DIR)
	$(ODIN) build $(ODIN_FLAGS)

template: $(TEMPL_FILE) $(WGPU_HEADER) $(WEBGPU_HEADER)
	$(SED) -e 's|@WGPU_HEADER@|$(WGPU_HEADER)|g' \
		-e 's|@WEBGPU_HEADER@|$(WEBGPU_HEADER)|g' \
		-e 's|@WEBPU_DIR@|$(WBGPU_DIR)|g' \
		$(TEMPL_FILE) > $(BINDINGS_OUT)

bindgen: $(ODINGEN) $(BINDINGS_OUT)
	$(ODINGEN) $(WORK_DIR)

submodule:
	$(GIT) submodule update --init --recursive
	
clean:
	rm -f $(ODINGEN)
	rm -f $(BINDINGS_OUT)
	rm -rf $(WORK_DIR)/wgpu