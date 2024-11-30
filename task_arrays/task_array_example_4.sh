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

# Example 4: Very similar to example 3, but we use a bash array instead of just
# a file listing.
BAM_DIR="/path/to/bams"
BAM_ARRAY=($(find "${BAM_DIR}" -mindepth 1 -maxdepth 1 -type f -name '*.bam' \
    | sort -V))
CURRENT_BAM=${BAM_ARRAY[${SLURM_ARRAY_TASK_ID}]}
OUTPUT_BAM=${CURRENT_BAM/.bam/.processed.bam}
samtools view -hbu -q 10 -F 4 "${CURRENT_BAM}" \
    samtools sort -o "${OUTPUT_BAM}" -
samtools index "${OUTPUT_BAM}"
