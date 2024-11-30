#!/bin/bash
# Example control script for a pipeline that uses Slurm job dependencies.

# Submit the first job. You can specify resources for the job on the commmand
# line! Use the --parsable option to make it easier to capture the job ID for
# use as the argument to the --dependency option later.
#   In this example, it just renames a file with simulation parameters to a
#   standard filename.
STEP_00=$(sbatch --parsable -N 1 -n 1 -c 1 -t 1:00:00 -p smp step_00.sh)
# The next step...
#   This one is an array! In this example, it generates an input simulation
#   dataset. The array index is used to make unique independent datasets.
STEP_01=$(sbatch --parsable --dependency=afterok:${STEP_00} --array=0-100 -N 1 \
    -n 1 -c 8 -t 4:00:00 -p smp step_01.sh)
#   In this example, this job only depends on step_00.sh because it reads the
#   renamed file.
STEP_02=$(sbatch --parsable --dependency=afterok:${STEP_00} -N 1 -n 1 -c 1 \
    -t 1:00:00 -p smp step_02.sh)
#   In this example, we process the simulated dataset with some standard
#   analysis parameters. Use an array again. It depends on the generation of
#   the simulated data (step_01) and the parameters being made (step_02)
STEP_03=$(sbatch --parsable --dependency=afterok:${STEP_00},afterok:${STEP_01} \
    --array=0-100 -N 1 -n 1 -c 8 -t 2:00:00 -p smp step_03.sh)
#   Next, for example, we can generate plots of all of the analyses, once each
#   job in the step_03 arrah has finished.
STEP_04=$(sbatch --parsable --dependency=afterok:${STEP_03} -N 1 -n 1 -c 1 \
    --mem=16gb -t 2:00:00 -p smp step_04.sh)
#   And finally, we can make a report of everything
STEP_05=$(sbatch --parsable --dependency=afterok:${STEP_04} -N 1 -n 1 -c 1 \
    --mem=16gb -t 1:00:00 -p smp step_05.sh)

# And we can print a nice log file to report who ran this pipeline and when
# it was run.
echo "$(date): Starting pipeline"
echo "Executing as $(id -un)"
echo "Executing in this directory: $(pwd -P)"
echo "Step_00 has job ID ${STEP_00}"
echo "Step_01 has job ID ${STEP_01}"
echo "Step_02 has job ID ${STEP_02}"
echo "Step_03 has job ID ${STEP_03}"
echo "Step_04 has job ID ${STEP_04}"
echo "Step_05 has job ID ${STEP_05}"
