#!/bin/bash
F=/home/echille/finalproject/mapping
array1=($(ls *pass_1.fastq.gz_paired_qtrim.fq.gz | sed 's/pass_1.fastq.gz_paired_qtrim.fq.gz//g'))

bwa index GCF_000222465.1_Adig_1.1_genomic.fna
echo "done index $(date)"

for i in ${array1[@]}; do
  bwa mem $F/GCF_000222465.1_Adig_1.1_genomic.fna ${i}pass_1.fastq.gz_paired_qtrim.fq.gz ${i}pass_2_paired_qtrim.fq.gz -t 8 -a -M -B 3 -O 5 -R "@RG\tID:${i}\tSM:${i}\tPL:Illumina" 2> bwa.${i}.log | samblaster -M --removeDups | samtools view -@4 -q 1 -SbT $F/GCF_000222465.1_Adig_1.1_genomic.fna - > ${i}.bam
  echo "done ${i}"
done

array2=($(ls *.bam | sed 's/.bam//g'))

#now sort the bam files with samtools sort
for i in ${array2[@]}; do
  samtools sort -@8 ${i}.bam -o ${i}.bam && samtools index ${i}.bam
done