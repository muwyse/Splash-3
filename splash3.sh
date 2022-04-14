#!/bin/sh

#APPS:
#./BARNES < inputs/n16384-p#
#./FMM < inputs/input.#.16384
#./OCEAN -p# -n258
#./RADIOSITY -p # -ae 5000 -bf 0.1 -en 0.05 -room -batch
#./RAYTRACE -p# -m64 inputs/car.env
#./VOLREND # inputs/head 8
#./WATER-NSQUARED < inputs/n512-p#
#./WATER-SPATIAL < inputs/n512-p#
#KERNELS:
#./CHOLESKY -p# < inputs/tk15.O
#./FFT -p# -m16
#./LU -p# -n512
#./RADIX -p# -n1048576

# kernels
time ./FFT.riscv -p8 -l6 -m22 -t
time ./LU.riscv -p8 -n1024 -t
time ./RADIX.riscv -p8 -n20000000 -t
time ./CHOLESKY.riscv -p8 -C32768 -t < ./inputs/cholesky/inputs/tk17.O

# apps
time ./RADIOSITY -p 8 -ae 2000 -bf 0.015 -en 0.005 -largeroom -batch
time ./RAYTRACE -p8 -m64 ./inputs/car.env
time ./WATER-NSQUARED < ./inputs/water-nsquared/inputs/parsec_test
time ./WATER-SPATIAL < ./inputs/water-spatial/inputs/parsec_test
time ./FMM.riscv < ./inputs/fmm/inputs/parsec_test

# pthread_mutex_lock assertion failed
#time ./BARNES.riscv < ./inputs/barnes/inputs/parsec_native
# segfault
#time ./OCEAN.riscv -p8 -n258

# tests done, power down
#poweroff
