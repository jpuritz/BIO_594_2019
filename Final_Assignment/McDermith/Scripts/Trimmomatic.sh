#!/bin/bash
#SBATCH --job-name=Trimmomatic
#SBATCH --mem=6000
#SBATCH --nodes=1
#SBATCH --partition=general
#SBATCH --tasks-per-node=1
#SBATCH --time=24:00:00


echo “START”
date

module load Trimmomatic/0.36-Java-1.8.0_92

cd /data3/jenkinslab/emcdermith/McDermithFinalAssignment/RawData/

java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.36.jar PE -phred33 BJ1_S5_L001_R1_001.fastq.gz BJ1_S5_L001_R2_001.fastq.gz output_R1_paired.fq.gz output_R1_unpaired.fq.gz output_R2_paired.fq.gz output_R2_unpaired.fq.gz ILLUMINACLIP:NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

echo "DONE"
date