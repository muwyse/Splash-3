
TOOLCHAIN_PREFIX ?= riscv64-unknown-linux-gnu-

.PHONY: all clean
.DEFAULT: all

all:
	$(MAKE) -C codes TOOLCHAIN_PREFIX=$(TOOLCHAIN_PREFIX)

clean:
	$(MAKE) -C codes clean
