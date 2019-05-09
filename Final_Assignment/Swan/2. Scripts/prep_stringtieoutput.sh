#!/bin/bash

F=/home/stan/FinalProject/genome

array2=($(ls *.merge.gtf))

for i in ${array2[@]}; do
    echo "$(echo ${i}|sed "s/\..*//") $F/${i}" >> hg19_sample_list.txt
done

echo "STOP" $(date)
