#!/bin/bash
F=/home/echille/finalproject/mapping/
array1=($(ls *qtrim.fq.gz | sed 's/qtrim.fq.gz//g'))

#bwa index reference.fasta
echo "done index $(date)"

for i in ${array1[@]}; do
  bwa mem $F/reference.fasta ${i}.pass_1* ${i}.pass_2* -t 8 -a -M -B 3 -O 5 -R -T 20 -A "@RG\tID:${i}\tSM:${i}\tPL:Illumina" 2> bwa.${i}.log | samtools view -@4 -q 1 -SbT $F/reference.fasta - > ${i}.bam
  																						    
        	else
  echo "done ${i}"
done

array2=($(ls *.bam | sed 's/.bam//g'))

#now sort the bam files with samtools sort
for i in ${array2[@]}; do
  samtools sort -@8 ${i}.bam -o ${i}.bam && samtools index ${i}.bam
done
