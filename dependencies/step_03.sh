#!/bin/bash
# The fourth step of an example pipeline for job dependencies in Slurm.

if [ -f "step_03.done" ]
then
    echo "Step 03 completed. Exiting."
    exit 0
fi

simulate simparams.dat input.${SLURM_ARRAY_TASK_ID}.dat > results.${SLURM_ARRAY_TASK_ID}.dat

touch step_03.done
