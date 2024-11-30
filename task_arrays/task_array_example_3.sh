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

# Example 3: Use a file listing as the target for your task array. In this
# example, we will use the output of the 'find' command to build the list of
# objects that will be subset by the array.
BAM_DIR="/path/to/bams"
CURRENT_BAM=$(find "${BAM_DIR}" -mindepth 1 -maxdepth 1 -type f -name '*.bam' \
    | sort -V \
    | sed -n "${SLURM_ARRAY_TASK_ID}p")
OUTPUT_BAM=${CURRENT_BAM/.bam/.processed.bam}
samtools view -hbu -q 10 -F 4 "${CURRENT_BAM}" \
    samtools sort -o "${OUTPUT_BAM}" -
samtools index "${OUTPUT_BAM}"
