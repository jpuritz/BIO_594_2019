#!/bin/bash

#Commands for Single End Read Preprocessing, all files are in the home directory and either have ending
# .fastq.gz            
# Specify current path (just for extra security)
F=/home/stan/FinalProject/SE_fastq

#going to make two array variables and then iterate through them as an index
array1=($(ls $F/*.fastq.gz))


for i in ${array1[@]}; do  # @ symbol tells it to go through each item in the array
   fastp -i ${i} -o ${i}.out -h ${i}.html -j ${i}.json -f 15 -q 20 -P 100 -y 50 --detect_adapter_for_pe
done
