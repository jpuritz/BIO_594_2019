x#!/bin/bash

#Commands for Paired End Read Preprocessing, all files are in the home directory and either have ending 
# _1.fastq.gz or _2.fastq.gz
# Specify current path (just for extra security)
F=/home/stan/FinalProject/PE_fastq

#going to make two array variables and then iterate through them as an index
array1=($(ls $F/*\_1.fastq.gz))
array2=($(ls $F/*\_2.fastq.gz))


for i in ${array1[@]}; do  # @ symbol tells it to go through each item in the array  
   fastp -i ${i} -I $(echo ${i}|sed s/_1/_2/) -o ${i}.out -O $(echo ${i}|sed s/_1/_2/).out -h ${i}.html -j ${i}.json -f 15 -q 20 -P 100 -y 50 --detect_adapter_for_pe
done
