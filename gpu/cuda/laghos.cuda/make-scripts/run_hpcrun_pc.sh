#!/bin/bash

$HPCTOOLKIT_LAGHOS_MODULES_BUILD
$HPCTOOLKIT_MODULES_USE
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd "$HPCTOOLKIT_LAGHOS_ROOT"

export CUPTI_DEVICE_NUM=1
export CUPTI_SAMPLING_PERIOD=5

BINARY=laghos
LAGHOS_DIR=laghos/Laghos
EXEC=${LAGHOS_DIR}/$BINARY
OUT=hpctoolkit-laghos-pc

CMD="rm -rf $OUT.m $OUT.d"
echo $CMD
$CMD

$HPCTOOLKIT_BEFORE_RUN_PC

# measure an execution of laghos
CMD="time ${HPCTOOLKIT_LAGHOS_LAUNCH} ${HPCTOOLKIT_LAGHOS_LAUNCH_ARGS} hpcrun -o $OUT.m -e gpu=nvidia,pc -t ${LAGHOS_DIR}/laghos -p 0 -dim 2 -rs 1 -tf 0.05 -pa -d cuda"
echo $CMD
eval $CMD

$HPCTOOLKIT_AFTER_RUN_PC

# compute program structure information for the laghos cpu and gpu binaries
CMD="hpcstruct --gpucfg yes $OUT.m"
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run-pc.done
