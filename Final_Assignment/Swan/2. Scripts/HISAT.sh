#!/bin/bash

#Specify working directory 
F=/home/stan/FinalProject/genome

#Indexing a reference genome and no annotation file (allowing for novel transcript discovery)
#Build HISAT index with human genome file (make sure beforehand to remove extra spaces in header so that genome and annotation don't conflict, the header names are important)

hisat2-build -f $F/genome.fa genome_hg19 # -f indicates that the reference input files are FASTA files

#Aligning paired end reads
array1=($(ls $F/*_1.fastq.gz.out)) 

for i in ${array1[@]}; do
    hisat2 --dta -x $F/genome_hg19  -1 ${i} -2 $(echo ${i}|sed s/_1/_2/) -S ${i}.sam
    echo "HISAT2 PE ${i}" $(date)
done
    #don't need -f because the reads are fastq
    # put -x before the index
    # --dta : Report alignments tailored for transcript assemblers including StringTie.
    #With this option, HISAT2 requires longer anchor lengths for de novo discovery of splice sites. 
    #This leads to fewer alignments with short-anchors, which helps transcript assemblers improve significantly in computation and memory usage.
