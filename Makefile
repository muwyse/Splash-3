
export LINUX_TARGET ?= riscv64-unknown-linux-gnu

.PHONY: all clean
.DEFAULT: all

all:
	$(MAKE) -C codes TOOLCHAIN_PREFIX=$(LINUX_TARGET)-

clean:
	$(MAKE) -C codes clean
