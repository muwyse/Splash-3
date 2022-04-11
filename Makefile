#
# Splash-3 Makefile
#
# This Makefile currently supports riscv and x86 compilation, and defaults to riscv
# cross-compilation.
#
# To compile and install:
# riscv: make all install
# x86: make all install EXT=x86
#
# To clean the build files:
# riscv: make clean
# x86: make clean.x86 or make clean EXT=x86
#
# To remove install files:
# riscv: make clean clean_install
# x86: make clean.x86 clean_install.x86
#
# To clean everything:
# make clean_all

EXT ?= riscv
ifeq ($(EXT),x86)
TOOLCHAIN_PREFIX=
else
TOOLCHAIN_PREFIX=riscv64-unknown-linux-gnu-
endif

INSTALL_DIR ?= $(abspath ./bin)
INSTALL_INPUTS_DIR = $(INSTALL_DIR)/inputs

.PHONY: all clean install clean_install clean_all
.DEFAULT: all

all:
	$(MAKE) -C codes TOOLCHAIN_PREFIX=$(TOOLCHAIN_PREFIX) EXT=$(EXT)

install_inputs: | $(INSTALL_INPUTS_DIR)
	cd codes/apps; find . -type d -name "inputs" -exec cp -R --parents {} $(INSTALL_INPUTS_DIR)/ \;
	cd codes/kernels; find . -type d -name "inputs" -exec cp -R --parents {} $(INSTALL_INPUTS_DIR)/ \;

install_bin: | $(INSTALL_DIR)/$(EXT)
	find codes -name "*.$(EXT)" -exec cp {} $(INSTALL_DIR)/$(EXT)/ \;

install: install_bin install_inputs

$(INSTALL_DIR)/$(EXT):
	mkdir -p $(INSTALL_DIR)/$(EXT)

$(INSTALL_INPUTS_DIR):
	mkdir -p $(INSTALL_INPUTS_DIR)

clean: clean.$(EXT)

clean.%:
	$(MAKE) -C codes clean EXT=$*

clean_all: clean.riscv clean.x86 clean_install.riscv clean_install.x86 clean_inputs

clean_install: clean_install.$(EXT)

clean_inputs:
	rm -rf $(INSTALL_INPUTS_DIR)

clean_install.%:
	rm -rf $(INSTALL_DIR)/$*
