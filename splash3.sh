#!/bin/bash

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

iters=${1:-1}

tests=(\
  "./bin/riscv/BARNES.riscv < ./inputs/barnes/inputs/parsec_native"
  "./bin/riscv/FMM.riscv < ./inputs/fmm/inputs/parsec_native"
  "./bin/riscv/OCEAN.riscv -p8 -n258"
  "./bin/riscv/RADIOSITY -p 8 -ae 5000 -bf 0.1 -en 0.05 -room -batch"
  "./bin/riscv/RAYTRACE -p8 -m64 ./inputs/raytrace/inputs/car.env"
  "./bin/riscv/WATER-NSQUARED < ./inputs/water-nsquared/inputs/parsec_native"
  "./bin/riscv/WATER-SPATIAL < ./inputs/water-spatial/inputs/parsec_native"
  "./bin/riscv/CHOLESKY.riscv -p8 < ./inputs/cholesky/inputs/tk15.O"
  "./bin/riscv/FFT.riscv -p8 -m16"
  "./bin/riscv/LU.riscv -p8 -n512"
  "./bin/riscv/RADIX.riscv -p8 -n1048576"
)

echo "running tests"
echo $iters
for t in "${tests[@]}"
do
  for (( i=1; i<=$iters; i++))
  do
    time $t
  done
done

# tests done, power down
#poweroff
