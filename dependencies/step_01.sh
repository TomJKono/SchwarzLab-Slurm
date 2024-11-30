#!/bin/bash
# The second step of an example pipeline for job dependencies in Slurm.

if [ -f "step_01.done" ]
then
    echo "Step 01 completed. Exiting."
    exit 0
fi

head -c 1000 /dev/urandom > input.${SLURM_ARRAY_TASK_ID}.dat

touch step_01.done
