#
# Splash-3 Makefile
#
# This Makefile currently supports riscv and x86 compilation, and defaults to riscv
# cross-compilation.
#
# To compile:
# riscv: make build
# x86: make build EXT=x86
#
# To clean the build files:
# riscv: make clean
# x86: make clean.x86 or make clean EXT=x86
#
# To install into ./bin
# riscv: make install
# x86: make install EXT=x86
#
# To remove install files:
# riscv: make clean clean_install
# x86: make clean.x86 clean_install.x86
#
# To clean everything:
# make clean_all
#
# To copy files to BP Linux build:
# find bin/inputs -type f -exec sed -i 's/NUMPROCS/#/g' {} \;
# cp -R bin/* sdk/linux/work/sysroot/splash3/
# cp splash3.sh sdk/linux/work/sysroot/

TOP = $(shell git rev-parse --show-toplevel)

EXT ?= riscv
ifeq ($(EXT),x86)
TOOLCHAIN_PREFIX=
else
TOOLCHAIN_PREFIX=riscv64-unknown-linux-gnu-
endif

.PHONY: help build install install_run install_inputs install_all clean_all clean_inputs clean_install
.DEFAULT: help

help:
	echo "see the Makefile for available targets"

# build executables
build:
	$(MAKE) -C codes TOOLCHAIN_PREFIX=$(TOOLCHAIN_PREFIX) EXT=$(EXT)

# install
INSTALL_DIR ?= $(TOP)/install
INSTALL_INPUTS_DIR := $(INSTALL_DIR)/inputs

install: | $(INSTALL_DIR)
	find codes -name "*.$(EXT)" -exec cp {} $(INSTALL_DIR)/ \;

install_run: | $(INSTALL_DIR)
	cp ./splash3.sh $(INSTALL_DIR)/

NUMPROCS ?= 8
install_inputs: | $(INSTALL_INPUTS_DIR)
	cd codes/apps; find . -type f -name "parsec_native" -exec cp -R --parents {} $(INSTALL_INPUTS_DIR)/ \;
	cd codes/apps; find . -type f -name "parsec_simlarge" -exec cp -R --parents {} $(INSTALL_INPUTS_DIR)/ \;
	cd codes/apps; find . -type f -name "parsec_test" -exec cp -R --parents {} $(INSTALL_INPUTS_DIR)/ \;
	cd codes/apps; cp raytrace/inputs/car.* $(INSTALL_INPUTS_DIR)
	cd codes/apps; cp water-nsquared/random.in $(INSTALL_DIR)/
	cd codes/kernels; cp --parents cholesky/inputs/tk17.O $(INSTALL_INPUTS_DIR)
	cd codes/kernels; cp --parents cholesky/inputs/tk29.O $(INSTALL_INPUTS_DIR)
	find $(INSTALL_INPUTS_DIR) -type f -exec sed -i 's/NUMPROCS/$(NUMPROCS)/g' {} \;

$(INSTALL_DIR):
	mkdir -p $(INSTALL_DIR)

$(INSTALL_INPUTS_DIR):
	mkdir -p $(INSTALL_INPUTS_DIR)

install_all: install install_inputs install_run

# clean

clean_all: clean_build.riscv clean_build.x86 clean_install

clean_build.%:
	$(MAKE) -C codes clean EXT=$*

clean_install.%:
	rm -rf $(INSTALL_DIR)/*.$*

clean_inputs:
	rm -rf $(INSTALL_INPUTS_DIR)

clean_install:
	rm -rf $(INSTALL_DIR)

# package for linux rootfs build
# this simply copies the install directory contents into some other directory
ROOTFS ?= ./root/bin
rootfs:
	mkdir -p $(ROOTFS)
	cp -R $(INSTALL_DIR)/* $(ROOTFS)
