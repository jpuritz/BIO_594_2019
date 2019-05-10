## Documentation of Overall Workflow </br> 
> This documentation of workflow is based on the analysis steps in project plan </br>
> Most of the analysis steps were adapted from [Erin Robert's tutorial](https://github.com/erinroberts/apoptosis_data_pipeline/blob/master/Streamlined%20Pipeline%20Tutorial/Apoptosis_Pipeline_Tutorial_with_Reduced_Dataset.md)

### Aim: To quantify differential expression of human NK cells in HIV, HCV and HBV patients
### Approach: RNA-seq Analysis Pipeline

### Step 1: Data acquisition
- Select a subset of sample for analysis based on metadata (refer to *SRR_id.txt*) </br>
- A total of 40 selected samples among 8 groups, 5 samples per each group (healthy_asian, healthy_caucasian, HIV, HCV, HBV Immune Tolerant (IT), HBV Immune Active (IA), HBV Inactive Carrier (IC), HBV Negative (ENEG)) </br>
- Find the data on NCBI according to the sample IDs selected earlier: [SRA sites](https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=517165)
- Obtain Accession file and save it as *SraAccList.txt* </br>
![Accessions List](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Swan/1.%20Data_Acquisition/AccessionList.png)

##### Log onto kitt.uri.edu and prepare working environment
```
conda create -n finalproject
conda activate finalproject
mkdir FinalProject
cd FinalProject/
```

##### Note: There are paired-end reads (PE) and single-end reads (SE) in the total dataset. Hence, in the subsequent data processing steps, PE and SE will be dealt separately
- Create PE and SE accession based on *SraAccList.txt* 

PE list
```
for i in SRR8489620 SRR8489619 SRR8489618 SRR8489617 SRR8489614 SRR8489627 SRR8489626 SRR8489628 SRR8489629 SRR8489630; do echo $i > $i\_paired.txt; done
```
SE list
```
for i in SRR8489621 SRR8489622 SRR8489623 SRR8489624 SRR8489625 SRR8489603 SRR8489604 SRR8489605 SRR8489606 SRR8489608 SRR8489648 SRR8489649 SRR8489650 SRR8489651 SRR8489652 SRR8489632 SRR8489633 SRR8489634 SRR8489635 SRR8489636 SRR8489640 SRR8489641 SRR8489642 SRR8489643 SRR8489644 SRR8489594 SRR8489595 SRR8489596 SRR8489597 SRR8489598; do echo $i > $i\_single.txt; done
```

##### Download data via SRA toolkit
> Remember to check and install SRA toolkit, if it is not installed yet </br>
> TO NOTE: Storage policy to avoid jam up the hard disk, hence, to switch working directory to `/RAID_STORAGE2/stan/`
```
conda install -c bioconda sra-tools
sra-tools-2.9.1_1 
```
With release 2.9.1 of `sra-tools` we have finally made available the tool `fasterq-dump`, a replacement for the much older `fastq-dump` tool. As its name implies, it runs faster, and is better suited for large-scale conversion of SRA objects into FASTQ files that are common on sites with enough disk space for temporary files.

You can get more information about `fasterq-dump` in our Wiki at [https://github.com/ncbi/sra-tools/wiki/HowTo:-fasterq-dump](https://github.com/ncbi/sra-tools/wiki/HowTo:-fasterq-dump).

##### Use script to download SRA reads (40 at the same time)
> Note: script can be found in folder of respective step </br>
> This downloading process may take long
```
nano dlSRAscript.sh 
chmod a+x dlSRAscript.sh
./dlSRAscript.sh 
```

> If the below situation occur, go to the respective folder and rm lock files
```
2019-04-30T00:44:22 prefetch.2.9.1: 1) Downloading 'SRR8489641'...
2019-04-30T00:44:22 prefetch.2.9.1 warn: lock exists while copying file - Lock file /home/stan/ncbi/public/sra/SRR8489641.sra.lock exists: download canceled
```
##### After done with downloading SRA reads, symlink all the fastq.gz files to original working directory
```
cd /home/stan/FinalProject
mkdir PE_fastq
mkdir SE_fastq
ln -s /RAID_STORAGE2/stan/FinalProject/PE/*.gz PE_fastq/
ln -s /RAID_STORAGE2/stan/FinalProject/SE/*.gz SE_fastq/
```

### Step 2: Quality check and sequence reads pre-processing

##### Quality check
```
#Check quality score

mkdir fastqc
cd fastqc/
ln -s ../PE_fastq/*.fastq.gz ./
ln -s ../E_fastq/*.fastq.gz ./

for i in *.fastq.gz; do fastqc $i; done &

# use MultiQC to put together all Files
conda install -c bioconda multiqc
multiqc .

# Export file to local folder
scp -r -P 2292 stan@kitt.uri.edu:/home/stan/FinalProject/fastqc/multiqc_report.html ./Downloads/
```

##### Use fastp to preprocess and trim data
> In this step, adapters were trimmed as well as low quality score sequences 

for PE
```
#create loop to run through PE fq.gz
nano fastp_PE.sh
chmod a+x fastp_PE.sh

#1st run:
#fastp -i rna1.F.fq.gz -I rna1.R.fq.gz -o out.rna1.F.fq.gz -O out.rna1.R.fq.gz -q 20 -P 100 -y 50 --detect_adapter_for_pe

#2nd run:
#fastp -i ${i} -I $(echo ${i}|sed s/_1/_2/) -o ${i}.out -O $(echo ${i}|sed s/_1/_2/).out -h ${i}.html -j ${i}.json -f 10 -q 20 -P 100 -y #50 --detect_adapter_for_pe

3rd run (TAKE THIS):
fastp -i ${i} -I $(echo ${i}|sed s/_1/_2/) -o ${i}.out -O $(echo ${i}|sed s/_1/_2/).out -h ${i}.html -j ${i}.json -f 15 -q 20 -P 100 -y 50 --detect_adapter_for_pe
```
for SE
```
nano fastp_SE.sh
chmod a+x fastp_SE.sh
#1st run:
#fastp -i ${i} -o ${i}.out -h ${i}.html -j ${i}.json -q 20 -P 100 -y 50

#2nd run:
#fastp -i ${i} -o ${i}.out -h ${i}.html -j ${i}.json -f 10 -q 20 -P 100 -y 50

3rd run(TAKE THIS):
fastp -i ${i} -o ${i}.out -h ${i}.html -j ${i}.json -f 15 -q 20 -P 100 -y 50
```
> An example of fastp html reports are located in the folder of this step

### Step 3: Reads alignment

##### First of all, to download human genome [hg19](http://hgdownload.cse.ucsc.edu/goldenpath/hg19/chromosomes/) </br>
> Again, be aware of storage policy, perform this step in the designated directory, i.e. `/RAID_STORAGE2/stan/` </br>
> Multiple files have to be concatenated into a single huge file
```
wget --timestamping 'ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/*'
cat *fa.gz > genome.fa.gz
zcat genome.fa.gz | grep -c ">"
93
zcat genome.fa.gz | grep ">"
gunzip genome.fa.gz
less genome.fa

#back to original working directory and do symlink
ln -s /RAID_STORAGE2/stan/FinalProject/genome.fa ./
```

##### Read alignment to human genome
> Perform in original working directory </br>
> In this step, HISAT2 and SAM Tool will be used, hence, make sure to do installation
```
conda install -c bioconda hisat2
mkdir genome
cp genome.fa ./genome
cp PE_fastq/*.out genome/ &
mkdir SE
cp SE_fastq/*.out genome/SE/ &
```

##### HISAT2 - This tool is to build an index of the reference genome and align reads to it
For PE
```
nano HISAT.sh
chmod a+x HISAT.sh 
./HISAT.sh
```

```
#expected output
Settings:
  Output files: "genome_hg19.*.ht2"
  Line rate: 6 (line is 64 bytes)
  Lines per side: 1 (side is 64 bytes)
  Offset rate: 4 (one in 16)
  FTable chars: 10
  Strings: unpacked
  Local offset rate: 3 (one in 8)
  Local fTable chars: 6
  Local sequence length: 57344
  Local sequence overlap between two consecutive indexes: 1024
  Endianness: little
  Actual local endianness: little
  Sanity checking: disabled
  Assertions: disabled
  Random seed: 0
  Sizeofs: void*:8, int:4, long:8, size_t:8
Input files DNA, FASTA:
  /home/stan/FinalProject/genome/genome.fa
Reading reference sizes
```

For SE, remember to modify HISAT.sh script to accomodate single end reads
```
hisat2 --dta -x $F/genome_hg19  -U ${i}  -S ${i}.sam
```

> Check for .sam output for PE and SE
> Move `*.sam` files in SE to `genome/` folder

##### Convert SAM to BAM with SAMTools
Create script to automate
```
nano SAMtoBAM.sh
chmod a+x SAMtoBAM.sh
```

### Step 4: Assembly and quantify reads using StringTie
> A genome annotation file will be needed in StringTie, make sure to get this file prior running StringTie

##### To get genome annotation file - BED to gff3 conversion
```
# gene annotation file from http://genome.ucsc.edu/cgi-bin/hgTables?command=start
wget 'http://genome.ucsc.edu/cgi-bin/hgTables?hgsid=724701577_xgSdmCwom3vIkGlRCA8JsVN5Cxow&boolshad.hgta_printCustomTrackHeaders=0&hgta_ctName=tb_knownGene&hgta_ctDesc=table+browser+query+on+knownGene&hgta_ctVis=pack&hgta_ctUrl=&fbQual=whole&fbUpBases=200&fbExonBases=0&fbIntronBases=0&fbDownBases=200&hgta_doGetBed=get+BED' -O "gene_anno_hg19.bed"

#bed to gff3 conversion
wget 'https://raw.githubusercontent.com/vipints/converters/master/gfftools/codebase/bed_to_gff3_converter.py'
python bed_to_gff3_converter.py -q gene_anno_hg19.bed -o human_hg19.gff3
```

##### Assemble reads to the reference annotation
```
#Start with installation
conda install -c bioconda stringtie

#create script to automate
nano stringtie_assembly.sh
./stringtie_assembly.sh &

#StringTie Merge, will merge all GFF files and assemble transcripts into a non-redundant set of transcripts, after which re-run #StringTie with -e
#create mergelist.txt in nano, names of all the GTF files created in the last step with each on its own line

ls *.gtf > mergelist.txt

#check to sure one file per line

cat mergelist.txt | grep ".gtf" -c
```

##### Run StringTie merge, merge transcripts from all samples (across all experiments, not just for a single experiment)
```
stringtie --merge -G human_hg19.gff3 -o stringtie_merged.gtf mergelist.txt
#FROM MANUAL: "If StringTie is run with the -A <gene_abund.tab> option, it returns a file containing gene abundances. "
#-G is a flag saying to use the .gff annotation file
```

##### gffcompare to compare how transcripts compare to reference annotation
```
conda install gffcompare
gffcompare -r human_hg19.gff3 -G -o merged stringtie_merged.gtf
# -o specifies prefix to use for output files
# -r followed by the annotation file to use as a reference
# merged.annotation.gtf tells you how well the predicted transcripts track to the reference annotation file
# merged.stats file shows the sensitivity and precision statistics and total number for different features (genes, exons, transcripts)
```

```
#expected output
(finalproject) [stan@KITT genome]$ gffcompare -r human_hg19.gff3 -G -o merged stringtie_merged.gtf
  82960 reference transcripts loaded.
  101 duplicate reference transcripts discarded.
  148668 query transfrags loaded.
```

##### Create a script to run re-estimation
```
nano re_estimate.sh 
chmod a+x re_estimate.sh
./re_estimate.sh
```

##### Prepare StringTie output for use in DESeq2
```
nano prep_stringtieoutput.sh
chmod a+x prep_stringtieoutput.sh
./prep_stringtieoutput.sh

wget 'https://ccb.jhu.edu/software/stringtie/dl/prepDE.py'
python prepDE.py -i C_vir_sample_list.txt
```

> Expected output - a csv file named `transcript_count_matrix.csv`

### Step 5: Differential gene expression analysis in R
> Perform differential expression of transcripts using DESeq2
> Refer to Rmd for subsequenct analysis steps
