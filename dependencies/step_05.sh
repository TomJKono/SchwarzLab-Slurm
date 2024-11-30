#!/bin/bash
# The final step of an example pipeline for job dependencies in Slurm.

if [ -f "step_05.done" ]
then
    echo "Step 05 completed. Exiting."
    exit 0
fi

mkdir /path/to/final/output
cp /path/to/plots/*.pdf /path/to/final/output
make_report input.*.dat user_params.txt /path/to/plots /path/to/final/output

touch step_05.done
