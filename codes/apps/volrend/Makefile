
# this Makefile expects TOOLCHAIN_PREFIX and TOOLCHAIN to be set for a cross-compiler

TARGET = VOLREND
LIBTIFF_DIR = libtiff-4.3.0
LIBTIFF = $(LIBTIFF_DIR)/libtiff.a
OBJS = $(LIBTIFF) adaptive.o file.o main.o map.o normal.o octree.o opacity.o option.o raytrace.o render.o view.o

include ../../Makefile.config

CFLAGS := $(CFLAGS) -I./libtiff
LDFLAGS := -L./libtiff $(LDFLAGS) -ltiff

main.c:	main.c.in incl.h anl.h
file.c:	file.c.in incl.h
option.c: option.c.in incl.h
map.c: map.c.in incl.h
normal.c: normal.c.in incl.h anl.h address.h
opacity.c: opacity.c.in incl.h anl.h
octree.c: octree.c.in incl.h anl.h
view.c:	view.c.in incl.h
render.c: render.c.in incl.h
adaptive.c: adaptive.c.in incl.h anl.h
raytrace.c: raytrace.c.in incl.h address.h

incl.h:	user_options.h const.h my_types.h global.h macros.h address.h

TOOLCHAIN_PATH = $(dir $(TOOLCHAIN_PREFIX))
ifdef TOOLCHAIN_PREFIX
	NEWPATH=$(TOOLCHAIN_PATH):$$PATH
endif

$(LIBTIFF):
	export PATH=$(NEWPATH)
	ln -s $(LIBTIFF_DIR) libtiff
	cd $(LIBTIFF_DIR) && ./configure --disable-shared --host=$(TOOLCHAIN) prefix="${PWD}" exec_prefix="${PWD}" \
		&& make prefix="${PWD}" exec_prefix="${PWD}" && make install prefix="${PWD}" exec_prefix="${PWD}"

clean:
	$(MAKE) -C $(LIBTIFF_DIR) clean
	$(RM) $(OBJS) VOLREND

