#!/bin/bash
#SBATCH --job-name="snp_calling"
#SBATCH --time=999:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu"
#SBATCH --mail-type=END,FAIL
#SBATCH --output="out_snp_calling"
#SBATCH --error="out_snp_calling"

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

cd /home/erenada/POPGEN/Data/bamfiles

/home/erenada/samtools/src/bcftools-1.9/bcftools mpileup --threads 20 -Ou -f GRCh38_latest_genomic.fna /ho
me/erenada/POPGEN/Data/bamfiles/*.bam | /home/erenada/samtools/src/bcftools-1.9/bcftools call -mv -Ob -o c
alls.bcf
