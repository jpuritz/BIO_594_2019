#!/bin/bash
#SBATCH --job-name="eur-mapping"
#SBATCH --time=999:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu"
#SBATCH --mail-type=END,FAIL
#SBATCH --output="eur_out_map"
#SBATCH --error="eur_out_map"
# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

declare -a EURleftlist=(EUR*.Left.*)
declare -a EURrightlist=(EUR*.Right.*)
declare -a indexnamelist=(1 2 3 4 5)

for i in 0 1 2 3 4

do
bwa mem -t 20 GRCh38_latest_genomic.fna.gz ${EURleftlist[$i]} ${EURrightlist[$i]} -I 2$
done
