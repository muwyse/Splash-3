.PHONY: all run_all clean

all:
	$(MAKE) -C apps/barnes
	$(MAKE) -C apps/fmm
	$(MAKE) -C apps/ocean/contiguous_partitions
	$(MAKE) -C apps/ocean/non_contiguous_partitions
	$(MAKE) -C apps/radiosity
	$(MAKE) -C apps/raytrace
	$(MAKE) -C apps/volrend
	$(MAKE) -C apps/water-nsquared
	$(MAKE) -C apps/water-spatial
	$(MAKE) -C kernels/cholesky
	$(MAKE) -C kernels/fft
	$(MAKE) -C kernels/lu/contiguous_blocks
	$(MAKE) -C kernels/lu/non_contiguous_blocks
	$(MAKE) -C kernels/radix

# BASEDIR from the .config file
TOP := $(shell git rev-parse --show-toplevel)/../..
INSTALL_DIR ?= $(TOP)/install
LOG_DIR ?= $(TOP)/output-logs

EXT ?= riscv
ifeq ($(EXT),x86)
EMULATOR =
else
EMULATOR = $(INSTALL_DIR)/bin/qemu-riscv64 -L $(INSTALL_DIR)/sysroot
endif
THREADS ?= 8

.PHONY: APPS KERNELS 

run_all: APPS KERNELS
APPS: BARNES FMM OCEAN RADIOSITY RAYTRACE VOLREND WATER-NSQUARED WATER-SPATIAL 
KERNELS: CHOLESKY FFT LU RADIX

BARNES: 
	cd apps/barnes && $(EMULATOR) ./BARNES.$(EXT) < ./inputs/n16384-p$(THREADS) \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-barnes.log
FMM:
	cd apps/fmm && $(EMULATOR) ./FMM.$(EXT) < ./inputs/input.$(THREADS)\.16384 \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-fmm.log
OCEAN:
	cd apps/ocean/contiguous_partitions && $(EMULATOR) ./OCEAN.$(EXT) -p$(THREADS) -n258 \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-ocean-contiguous_partitions.log \
	&& cd ../non_contiguous_partitions && $(EMULATOR) ./OCEAN.$(EXT) -p$(THREADS) -n258 \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-ocean-non_contiguous_partitions.log
RADIOSITY:
	cd apps/radiosity && $(EMULATOR) ./RADIOSITY.$(EXT) -p $(THREADS) -ae 5000 -bf 0.1 -en 0.05 -room -batch \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-radiosity.log
RAYTRACE:
	cd apps/raytrace && $(EMULATOR) ./RAYTRACE.$(EXT) -p$(THREADS) -m64 ./inputs/car.env \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-raytrace.log
VOLREND:
	cd apps/volrend && $(EMULATOR) ./VOLREND.$(EXT) # ./inputs/head 8 \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-volrend.log
WATER-NSQUARED:
	cd apps/water-nsquared && $(EMULATOR) ./WATER-NSQUARED.$(EXT) < ./inputs/n512-p$(THREADS) \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-water-nsquared.log
WATER-SPATIAL:
	cd apps/water-spatial && $(EMULATOR) ./WATER-SPATIAL.$(EXT) < ./inputs/n512-p$(THREADS) \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-water-spatial.log
CHOLESKY:
	cd kernels/cholesky && $(EMULATOR) ./CHOLESKY.$(EXT) -p$(THREADS) < ./inputs/tk15.O \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-cholesky.log
FFT:
	cd kernels/fft && $(EMULATOR) ./FFT.$(EXT) -p$(THREADS) -m16 \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-fft.log
LU:
	cd kernels/lu/contiguous_blocks && $(EMULATOR) ./LU.$(EXT) -p$(THREADS) -n512 \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-lu-contiguous_blocks.log \
	&& cd ../non_contiguous_blocks && $(EMULATOR) ./LU.$(EXT) -p$(THREADS) -n512 \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-lu-non_contiguous_blocks.log
RADIX:
	cd kernels/radix && $(EMULATOR) ./RADIX.$(EXT) -p$(THREADS) -n51048576 \
	2>&1 | tee -i $(LOG_DIR)/splash3-$(EXT)-radix.log

clean:
	$(MAKE) -C apps/barnes clean
	$(MAKE) -C apps/fmm clean
	$(MAKE) -C apps/ocean/contiguous_partitions clean
	$(MAKE) -C apps/ocean/non_contiguous_partitions clean
	$(MAKE) -C apps/radiosity clean
	$(MAKE) -C apps/raytrace clean
	$(MAKE) -C apps/volrend clean
	$(MAKE) -C apps/water-nsquared clean
	$(MAKE) -C apps/water-spatial clean
	$(MAKE) -C kernels/cholesky clean
	$(MAKE) -C kernels/fft clean
	$(MAKE) -C kernels/lu/contiguous_blocks clean
	$(MAKE) -C kernels/lu/non_contiguous_blocks clean
	$(MAKE) -C kernels/radix clean
