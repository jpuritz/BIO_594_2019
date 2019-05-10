#!/bin/bash

#This script takes bam files from HISAT (processed by SAMtools) and performs StringTie assembly and quantification and converts
# data into a format that is readable as count tables for DESeq2 usage

F=/home/stan/FinalProject/genome

# StringTie to assemble transcripts for each sample with the GFF3 annotation file
array1=($(ls $F/*.bam))

for i in ${array1[@]}; do
    stringtie -G $F/human_hg19.gff3 -o ${i}.gtf -l $(echo ${i}|sed "s/\..*//") ${i}
    echo "${i}"
done
    # command structure: $ stringtie <options> -G <reference.gtf or .gff> -o outputname.gtf -l prefix_for_transcripts input_filename.bam
    # -o specifies the output name
    # -G specifies you are aligning with an option GFF or GTF file as well to perform novel transcript discovery
    # -l Sets <label> as the prefix for the name of the output transcripts. Default: STRG
    # don't use -e here if you want it to assemble any novel transcripts
    
#StringTie Merge, will merge all GFF files and assemble transcripts into a non-redundant set of transcripts, after which re-run StringTie with -e
    
    #create mergelist.txt in nano, names of all the GTF files created in the last step with each on its own line
    #ls *.gtf > mergelist.txt

    #check to sure one file per line
    #cat mergelist.txt | grep ".gtf" -c

#Run StringTie merge, merge transcripts from all samples (across all experiments, not just for a single experiment)

    stringtie --merge -A -G $F/human_hg19.gff3 -o stringtie_merged.gtf mergelist.txt
    #-A here creates a gene table output with genomic locations and compiled information that I will need later to fetch gene sequences
        #FROM MANUAL: "If StringTie is run with the -A <gene_abund.tab> option, it returns a file containing gene abundances. "
    #-G is a flag saying to use the .gff annotation file

#gffcompare to compare how transcripts compare to reference annotation

    gffcompare -r $F/human_hg19.gff3 -G -o merged stringtie_merged.gtf
    # -o specifies prefix to use for output files
    # -r followed by the annotation file to use as a reference
    # merged.annotation.gtf tells you how well the predicted transcripts track to the reference annotation file
    # merged.stats file shows the sensitivity and precision statistics and total number for different features (genes, exons, transcripts)

#Re-estimate transcript abundance after merge step
    for i in ${array1[@]}; do
        stringtie -e -G $F/stringtie_merged.gtf -o $(echo ${i}|sed "s/\..*//").merge.gtf ${i}
        echo "${i}"
    done 
    # input here is the original set of alignment files
    # here -G refers to the merged GTF files
    # -e creates more accurate abundance estimations with input transcripts, needed when converting to DESeq2 tables

echo "DONE" $(date)
