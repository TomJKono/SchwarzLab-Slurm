#!/bin/bash
# The fifth step of an example pipeline for job dependencies in Slurm.

if [ -f "step_04.done" ]
then
    echo "Step 04 completed. Exiting."
    exit 0
fi

generate_plots results.*.dat /path/to/plots

touch step_04.done
