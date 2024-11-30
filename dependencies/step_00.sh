#!/bin/bash
# The first step of an example pipeline for job dependencies in Slurm.

if [ -f "step_00.done" ]
then
    echo "Step 00 completed. Exiting."
    exit 0
fi

cp user_params.txt ./sim_params.txt

touch step_00.done
