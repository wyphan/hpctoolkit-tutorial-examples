if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to the apppropriate repository:"
  echo "    'ntrain' for training accounts"
  echo "    'default' to run with your default repository, which won't let you use the reservation"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
  echo "    'default' to run without the reservation"
else
  if test "$HPCTOOLKIT_TUTORIAL_PROJECTID" != "default"
  then
    export HPCTOOLKIT_PROJECTID="-A $HPCTOOLKIT_TUTORIAL_PROJECTID"
  else
    unset HPCTOOLKIT_PROJECTID
  fi
  if test "$HPCTOOLKIT_TUTORIAL_RESERVATION" != "default"
  then
    export HPCTOOLKIT_RESERVATION="--reservation=$HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    unset HPCTOOLKIT_RESERVATION
  fi

  # cleanse environment
  module reset

  # load modules needed to build and run quicksilver
  module load gpu PrgEnv-gnu gcc/11.2.0 cudatoolkit/11.7 cmake craype-x86-milan craype-accel-nvidia80

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_USE="module use /global/common/software/m3977/modulefiles/perlmutter"
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_USE
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_MPI_CXX=CC
  export HPCTOOLKIT_CUDA_ARCH=80
  export HPCTOOLKIT_BEFORE_RUN_PC="srun --ntasks-per-node 1 dcgmi profile --pause"
  export HPCTOOLKIT_AFTER_RUN_PC="srun --ntasks-per-node 1 dcgmi profile --resume"
  export HPCTOOLKIT_QS_ROOT="$(pwd)"
  export HPCTOOLKIT_QS_MODULES_BUILD=""
  export HPCTOOLKIT_QS_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -N 1 -t 10 -C gpu -q debug"
  export HPCTOOLKIT_QS_RUN="$HPCTOOLKIT_QS_SUBMIT -J qs-run -o log.run.out -e log.run.stderr -G 1"
  export HPCTOOLKIT_QS_RUN_PC="$HPCTOOLKIT_QS_SUBMIT -J qs-run-pc -o log.run-pc.out -e log.run-pc.stderr -G 1"
  export HPCTOOLKIT_QS_BUILD="sh"
  export HPCTOOLKIT_QS_LAUNCH="srun -n 4 -c 32 -G 4 --gpus-per-task=1 --gpu-bind=map_gpu:0,1,2,3"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=quicksilver
fi
