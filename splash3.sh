#!/bin/bash

#./BARNES.riscv < inputs/n16384-p4
#./FMM.riscv < inputs/input.4.16384
#./OCEAN.riscv -p4 -n258
#./RADIOSITY.riscv -p 4 -ae 5000 -bf 0.1 -en 0.05 -room -batch
#./RAYTRACE.riscv -p4 -m64 inputs/car.env
#./WATER-NSQUARED.riscv < inputs/n512-p4
#./WATER-SPATIAL.riscv < inputs/n512-p4
splash3/CHOLESKY.riscv -p4 < splash3/inputs/tk15.O
splash3/FFT.riscv -p4 -m16
splash3/LU.riscv -p4 -n512
splash3/RADIX.riscv -p4 -n1048576
poweroff
