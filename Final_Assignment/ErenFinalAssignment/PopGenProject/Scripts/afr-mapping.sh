#!/bin/bash
#SBATCH --job-name="afr_mapping"
#SBATCH --time=999:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu"
#SBATCH --mail-type=END,FAIL
#SBATCH --output="afr_out_map"
#SBATCH --error="afr_out_map"
# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

cd /home/erenada/POPGEN/Data

declare -a AFRleftlist=(AFR*.Left.*)
declare -a AFRrightlist=(AFR*.Right.*)

declare -a indexnamelist=(1 2 3 4 5)

for i in 0 1 2 3 4 

do
../../programs/bwa/bwa mem -t 20 GRCh38_latest_genomic.fna.gz ${AFRleftlist[$i]} ${AFRrightlist[$i]} -I 20
0,40 | /home/erenada/samtools/src/samtools/samtools view -Su -@ 20 -F 4 - | /home/erenada/samtools/src/sam
tools/samtools sort -@ 20 - -o AFR_"${indexnamelist[i]}".bam
done
