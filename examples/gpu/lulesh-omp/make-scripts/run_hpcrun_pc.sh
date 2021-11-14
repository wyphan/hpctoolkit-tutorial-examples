#!/bin/bash

$HPCTOOLKIT_LULESH_OMP_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=lulesh2.0
EXEC=LULESH/omp_4.0/${BINARY}
OUT=hpctoolkit-${BINARY}-omp-pc

CMD="rm -rf ${OUT}.m ${OUT}.d"
echo $CMD
$CMD

# measure an execution of lulesh-omp
CMD="time ${HPCTOOLKIT_LULESH_OMP_LAUNCH} hpcrun -t -o $OUT.m -e gpu=nvidia,pc ${EXEC} -i 100"
echo $CMD
$CMD

# compute program structure information for lulesh-omp cpu and gpu binaries 
CMD="hpcstruct --gpucfg yes $OUT.m" 
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run-pc.done
