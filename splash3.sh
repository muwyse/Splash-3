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
  "splash3/BARNES.riscv < splash3/inputs/barnes/inputs/parsec_native"
  "splash3/FMM.riscv < splash3/inputs/fmm/inputs/parsec_native"
  "splash3/OCEAN.riscv -p8 -n258"
  "splash3/RADIOSITY -p 8 -ae 5000 -bf 0.1 -en 0.05 -room -batch"
  "splash3/RAYTRACE -p8 -m64 inputs/car.env"
  "splash3/WATER-NSQUARED < splash3/inputs/water-nsquared/inputs/parsec_native"
  "splash3/WATER-SPATIAL < splash3/inputs/water-spatial/inputs/parsec_native"
  "splash3/CHOLESKY.riscv -p8 < splash3/inputs/cholesky/inputs/tk15.O"
  "splash3/FFT.riscv -p8 -m16"
  "splash3/LU.riscv -p8 -n512"
  "splash3/RADIX.riscv -p8 -n1048576"
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
poweroff
