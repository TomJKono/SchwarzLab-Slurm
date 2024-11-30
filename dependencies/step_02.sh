#!/bin/bash
# The third step of an example pipeline for job dependencies in Slurm.

if [ -f "step_02.done" ]
then
    echo "Step 02 completed. Exiting."
    exit 0
fi

make_paramers sim_params.txt > simparams.dat

touch step_02.done
