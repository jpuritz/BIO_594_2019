#!/bin/bash

#This script takes bam files from HISAT (processed by SAMtools) and performs StringTie assembly and quantification and converts
# data into a format that is readable as count tables for DESeq2 usage

F=/home/stan/FinalProject/genome
array1=($(ls $F/*.bam))

#Re-estimate transcript abundance after merge step
    for i in ${array1[@]}; do
        stringtie -e -G $F/stringtie_merged.gtf -o $(echo ${i}|sed "s/\..*//").merge.gtf ${i}
        echo "${i}"
    done 
    # input here is the original set of alignment files
    # here -G refers to the merged GTF files
    # -e creates more accurate abundance estimations with input transcripts, needed when converting to DESeq2 tables

echo "DONE" $(date)
