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

# Example 1: Processing a given line from a text file with a job array. This
# file could contain a list of paths or a list of sample names, for example.
BAM_LIST="/path/to/list.txt"
# Use the "${SLURM_ARRAY_TASK_ID}" variable (automatically set by Slurm when
# you submit an array) to reference the task ID of the current job.
CURRENT_BAM=$(head -n "${SLURM_ARRAY_TASK_ID}" "${BAM_LIST}" | tail -n 1)

# Process the file as you would like, e.g., for a bam file...
OUTPUT_BAM=${CURRENT_BAM/.bam/.processed.bam}
samtools view -hbu -q 10 -F 4 "${CURRENT_BAM}" \
    samtools sort -o "${OUTPUT_BAM}" -
samtools index "${OUTPUT_BAM}"
