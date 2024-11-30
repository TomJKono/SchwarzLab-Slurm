# SchwarzLab-Slurm - Task Arrays
Demo scripts for Slurm task arrays.

## Examples
1. This example shows how to read a specific line out of a text file with the
   `SLURM_ARRAY_TASK_ID` variable. This script uses a combination of `head` and
   `tail` to isolate a line from a text file.
2. This example is very similar to the first, but uses `sed` instead of `head`
   and `tail`.
3. This example uses the output of the `find` command instead of a prebuilt
   text file. If you want to operate on a directory of files, this would be a
   useful template.
4. This example is similar to the third, but it uses a bash array to store the
   file listing. You can use this with any way that you would generate a bash
   array -- reading from a command output or manually defining an array by hand.
5. This example shows that you can use the integer set as `SLURM_ARRAY_TASK_ID`
   to do anything you would like to do with an array! This one uses it to set
   the number of clusters in a fictional K-means clustering program.

Note that examples 1 and 2 require **1-based** counting (i.e., the first lines
of the files are numbered 1). Examples 3 and 4 use **0-based** counting.
Example 5 is very flexible; it depends on what you want to do with the array
index.
