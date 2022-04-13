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
time ./bin/riscv/FFT.riscv -p8 -l6 -m22 -t
time ./bin/riscv/LU.riscv -p8 -n1024 -t
time ./bin/riscv/RADIX.riscv -p8 -n20000000 -t
time ./bin/riscv/CHOLESKY.riscv -p8 -C 32768 -t < ./inputs/cholesky/inputs/tk17.O

# apps
time ./bin/riscv/BARNES.riscv < ./inputs/barnes/inputs/parsec_native
time ./bin/riscv/FMM.riscv < ./inputs/fmm/inputs/parsec_native
time ./bin/riscv/OCEAN.riscv -p8 -n258
time ./bin/riscv/RADIOSITY -p 8 -ae 5000 -bf 0.1 -en 0.05 -room -batch
time ./bin/riscv/RAYTRACE -p8 -m64 ./inputs/raytrace/inputs/car.env
time ./bin/riscv/WATER-NSQUARED < ./inputs/water-nsquared/inputs/parsec_native
time ./bin/riscv/WATER-SPATIAL < ./inputs/water-spatial/inputs/parsec_native

# tests done, power down
#poweroff
