#!/bin/bash

$HPCTOOLKIT_PELEC_MODULES_BUILD

date > .build_begin

# Tested for GCC >= 6.4.0, cmake >= 3.3

# PeleC
git clone --recursive https://github.com/AMReX-Combustion/PeleC.git
cd PeleC/Exec/RegTests/PMF
make USE_CUDA=TRUE -j 16
cd -

touch log.build.done

date > .build_end
