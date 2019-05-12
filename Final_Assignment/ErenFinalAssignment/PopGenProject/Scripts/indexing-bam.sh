#!/bin/bash
#SBATCH --job-name="indexing_bam"
#SBATCH --time=99:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu"
#SBATCH --mail-type=END,FAIL
#SBATCH --output="out_indexing_bam"
#SBATCH --error="out_indexing_bam"
# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

cd /home/erenada/POPGEN/Data/bamfiles

for file in $(ls)

do

/home/erenada/samtools/src/samtools/samtools index -@20 $file

done
