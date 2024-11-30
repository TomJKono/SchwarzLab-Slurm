# SchwarzLab-Slurm -- Job Dependencies
Demo scripts for Slurm job dependncies.

## Pipeline Description
This is a fictional pipeline that standardizes some set of user-specified
input parameters, generates several input datasets, generates a file with
analysis parameters, processes the input datasets, makes plots, then makes a
report of the run. None of the commands are expected to actually work, but
hopefully the structure of the dependencies is clear. Each pipeline job script
has an illustration of a simple checkpointing mechanism to show how you can
avoid rerunning costly analyses if you must resubmit a pipeline that aborted
partway through a run. The submission of the pipeline is controlled by an
external script called `run_pipeline.sh`

### Job Script Descriptions
1. `step_00.sh`: Standarizes the user input file.
2. `step_01.sh`: Generates input datasets. Uses job arrays to make multiple
                 independent datasets.
3. `step_02.sh`: Generates analysis paramters file.
4. `step_03.sh`: Processes input datasets with the analysis parameters. Uses
                 job arrays to process each input dataset independently.
5. `step_04.sh`: Plots the results of all of the independent simulation runs.
6. `step_05.sh`: Generates a report that summarizes the input parameters, the
                 input datasets, plots, and final outputs.
7. `run_pipeline.sh`: Sets the dependency structure and submits jobs.

## Dependency Structure
- `step_00` is the first job. It has no dependencies.
- `step_01` depends on `step_00` having no errors.
- `step_02` depends on `step_00` having no errors. It can run at the same time
  as the array jobs in `step_01`.
- `step_03` depends on `step_01` and `step_02` both being completed without
  errors.
- `step_04` depends on `step_03` having no errors.
- `step_05` depends on `step_04` having no errors.

See the job submissions in `run_pipeline.sh` to see how these dependencies are
implemented.
