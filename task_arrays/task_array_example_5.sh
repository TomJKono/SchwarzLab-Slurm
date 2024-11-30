#!/bin/bash
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 8
#SBATCH --mem=16gb
#SBATCH -t 2:00:00
#SBATCH -p smp
#SBATCH --array=0-20
#SBATCH -e array_%A-%a.err
#SBATCH -o array_%A-%a.out

# Example 4: Really, a job array just exports a single integer into the job
# environment. How you use this integer is up to you!
NCLUST="${SLURM_ARRAY_TASK_ID}"
N_REPS=10
for ((i=1;i<="${N_REPS}";i++))
do
    k_means data.dat "${NCLUST}" > kmeans.result.rep"${i}".K"${NCLUST}"
done
