### Data download
data was downloaded from bluewaves cluster.

```
mkdir BIO594
[evelyn-takyi@n007 BIO594]$ module load Anaconda3/4.2.0
[evelyn-takyi@n007 BIO594]$ conda create -n BIO594
To activate this environment, use:
# > source activate BIO594
# To deactivate an active environment, use:
# > source deactivate
[evelyn-takyi@n007 BIO594]$ source activate BIO594_env
```
#### Load all modules necessary to perform the analysis
```
[evelyn-takyi@n007 BIO594]$ module load SRA-Toolkit/2.9.0-centos_linux64
[evelyn-takyi@n007 BIO594]$ module load BEDTools/2.26.0-foss-2016b
[evelyn-takyi@n007 BIO594]$ module load SAMtools/1.3.1-foss-2016b
[evelyn-takyi@n007 BIO594]$ module load HISAT2/2.0.4-foss-2016b
[evelyn-takyi@n007 BIO594]$ module load StringTie/1.3.3b-foss-2016b
```
#### Processing raw reads, quality control and trimming adapters
#####  Download the script bbduk.sh(This script i used for searching for adapters, quality trimming the adapters, and read with a quality score of less than 20 and discarded reads with an overall quality of less than 10)
```
[evelyn-takyi@n007 BIO594]$ curl -O https://raw.githubusercontent.com/BioInfoTools/BBMap/master/sh/bbduk.sh
(BIO594) [evelyn-takyi@n007 BIO594]$ chmod a+x bbduk.sh
```
#### Make a var variable to iterate through them as index during the Analysis
```
(BIO594) [evelyn-takyi@n007 BIO594]$ F=/home/evelyn-takyi/BIO594
(BIO594) [evelyn-takyi@n007 BIO594]$ var1=($(ls $F/*_1.fastq)
(BIO594) [evelyn-takyi@n007 BIO594]$ var2=($(ls $F/*_2.fastq))
```
#### Using  a for loop to search for adapters if they are present
```
(BIO594) [evelyn-takyi@n007 BIO594]$ for i in ${var1[@]}
> do
> bbduk.sh in1=${i} in2=$(echo ${i} | sed s/_1/_2/) k-23 ref=/opt/software/BBMap/37.36-foss-2016b-Java-1.8.0_131/resources/adapters.fa stats=${i}.stat out=${i}.out
> done
```
#### Trim adaptors found in the previous command
```
(BIO594) [evelyn-takyi@n007 BIO594]$ for i in ${var1[@]}
> do
> bbduk.sh in1=${i}.clean out1=${i}.clean.trim in2=$(echo ${i}|sed s/_1/_2/).clean out2=$(echo ${i}|sed s/_1/_2/).clean.trim qtrim=rl trimq=20
>     echo "quality trimming ${i}" $(date)
> done
```
#### Quality filtering to remove low quality  reads
```
(BIO594) [evelyn-takyi@n007 BIO594]$ for i in ${var1[@]}
> do
> bbduk.sh in1=${i}.clean.trim out1=${i}.clean.trim.filter in2=$(echo ${i}|sed s/_1/_2/).clean.trim out2=$(echo ${i}|sed s/_1/_2/).clean.trim.filter maq=10
>     echo "STOP" $(date)
>     echo "quality filtering ${i}" $(date)
> done
```

### Align reads to reference genome of the oyster
#### First, build and index for the reference genome
(BIO594) [evelyn-takyi@n007 BIO594]$ hisat2-build -f cvir_edited.fa  cvir_edited
#### second, align paired end reads to the reference genomic_nucleotide_accession
```
(BIO594) [evelyn-takyi@n007 BIO594]$ var3=($(ls $F/*_1.fastq.clean.trim.filter))
(BIO594) [evelyn-takyi@n007 BIO594]$ for i in ${var3[@]}
> do
> hisat2 --dta -x $F/cvir  -1 ${i} -2 $(echo ${i}|sed s/_1/_2/) -S ${i}.sam
> done
```
#### Statistics across all samples
```
14081972 reads; of these:
  14081972 (100.00%) were paired; of these:
    2116493 (15.03%) aligned concordantly 0 times
    8498157 (60.35%) aligned concordantly exactly 1 time
    3467322 (24.62%) aligned concordantly >1 times
    ----
    2116493 pairs aligned concordantly 0 times; of these:
      254223 (12.01%) aligned discordantly 1 time
    ----
    1862270 pairs aligned 0 times concordantly or discordantly; of these:
      3724540 mates make up the pairs; of these:
        3096166 (83.13%) aligned 0 times
        363018 (9.75%) aligned exactly 1 time
        265356 (7.12%) aligned >1 times
89.01% overall alignment rate
```
#### Convert files in sam format to bam format for use in stringtie mode
```
(BIO594) [evelyn-takyi@n007 BIO594]$ var4=($(ls $F/*.sam))
(BIO594) [evelyn-takyi@n007 BIO594]$ for i in ${var4[@]}
> do
> samtools sort ${i} > ${i}.bam
> echo "${i}_bam"
> done
```
#### Get statistics on alignment of the bam files
```
(BIO594) [evelyn-takyi@n007 BIO594]$ for i in ${var4[@]}; do samtools flagstat ${i} > ${i}.bam.stats #get % mapped; samtools stats {i} | grep ^SN | cut -f 2- > ${i}.bam.fullstat; echo "STATS DONE" $(date); done
> done
```
#### Assemble reads to the annotation file .gff in the folder and quantify using stringtie module
```
(BIO594) [evelyn-takyi@n007 BIO594]$ for i in ${var4[@]}
> do
> stringtie -G $F/GCF_002022765.2_C_virginica-3.0_genomic.gff -o ${i}.gtf -l $(echo ${i}|sed "s/\..*//") ${i}
> echo "${i}"
> done
```
#### Run StringTie merge to merge transcripts from all samples
#### first create mergelist.txt in nano with the names of all the GTF files created in the last step with each on its own line
```
(BIO594) [evelyn-takyi@n007 BIO594]$ ls *.gtf > C_Vir_mergelist.txt
[evelyn-takyi@bluewaves BIO594]$ cat  C_Vir_mergelist.txt
C_K_0_TACAGC_1.fastq.clean.trim.filter.sam.bam.gtf
C_M_0_CGGAAT_1.fastq.clean.trim.filter.sam.bam.gtf
C_V_0_CACGAT_1.fastq.clean.trim.filter.sam.bam.gtf
RE_K_6_TCCCGA_1.fastq.clean.trim.filter.sam.bam.gtf
RE_M_6_CTCAGA_1.fastq.clean.trim.filter.sam.bam.gtf
RE_V_6_CATGGC_1.fastq.clean.trim.filter.sam.bam.gtf
[evelyn-takyi@n006 BIO594]$ stringtie --merge -p 8 -o stringtie_merged.gtf -G GCF_002022765.2_C_virginica-3.0_genomic.gff C_Vir_mergelist.txt
```
#### check  how transcripts compare to reference annotation using gffcompare
```
[evelyn-takyi@n040 BIO594]$ module load gffcompare/0.10.1-foss-2016b
[evelyn-takyi@n006 BIO594]$ gffcompare -r GCF_002022765.2_C_virginica-3.0_genomic.gff -G -o C_Vir_merged stringtie_merged.gtf
print C_Vir_merged.stats
```
##### Estimate transcript abundance after merge step
```
[evelyn-takyi@n040 BIO594]$ stringtie --merge  -G $F/ref_C_virginica-3.0_top_level.gff3 -o C_Vir_stringtie_merged.gtf C_Vir_mergelist.tx
[evelyn-takyi@n040 BIO594]$ less C_Vir_stringtie_merged.gtf
```
#### Prepare transcript count to use in  Deseq2 analysis in R
### Download the script ./prepDE.py from https://ccb.jhu.edu/software/stringtie/dl/prepDE.py
```
[evelyn-takyi@n040 BIO594]$ for i in ${var2[@]}
> do
> echo "$(echo ${i}|sed "s/\..*//") $F/${i}" >> C_vir_sample_list.txt
> done
[evelyn-takyi@n040 BIO594]$ less C_vir_sample_list.txt
[evelyn-takyi@n040 BIO594]$  python2.7  ./prepDE.py -i C_vir_sample_list.txt
[evelyn-takyi@n040 BIO594]$ head transcript_count_matrix.csv
transcript_id,C_K_0_TACAGC_1,C_M_0_CGGAAT_1,C_V_0_CACGAT_1,RE_K_6_TCCCGA_1,RE_M_6_CTCAGA_1,RE_V_6_CATGGC_1
rna28678,0,0,0,0,0,0
rna2648,0,10,5,60,8,0
rna2649,0,0,0,0,0,0
rna2646,0,0,0,0,0,0
rna2647,55,372,349,260,35,26
rna2644,194,71,102,121,140,367
rna2645,193,0,333,0,409,1436
rna2642,0,0,22,0,13,26
rna2643,34,7,25,27,20,24
```

#### The differential gene expression is carried in R using Deseq.
File name BIO594:19.md  
