#!/bin/bash

# Loop for downloading PE sequences from Accessions in my .txt file

for f in $F*paired.txt
do
  prefetch --option-file $f
  while read -r LINE; do
    fastq-dump --split-files --gzip --readids $LINE
  done < $f
done

echo "STOP $date"
