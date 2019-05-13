## Final Assignment Project Documentation
Population Structure and Gene Flow in *Acropora cervicornis*  
Author: E. Chille  

### Step 1: Prepare Project Workspace
Create project directory
```
mkdir finalproject
cd finalproject
mkdir data
```
Create conda environment
```
conda create -n finalproject
conda activate finalproject
```

### Step 2: Download Data Using SRA-Toolkit
Download and Unpack SRA-Toolkit
```
cd ../../RAID_STORAGE2/echille
mkdir finalproject
wget "ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-centos_linux64.tar.gz"

tar -xzf sratoolkit.current-centos_linux64.tar.gz
```
Configure SRA-Toolkit
```
cd sratoolkit.2.9.6-centos_linux64/bin/
./vdb-config -i
```
Download data as fastq file  
*Followed [documentation](https://edwards.sdsu.edu/research/fastq-dump/) from Edwards Lab, San Diego State University.*

```
cat SraAccListp | parallel "./fastq-dump --outdir fastq --gzip --skip-technical  --readids --read-filter pass --dumpbase --split-3 --clip {}"

 # Run in background
 ^Z
 BG
 Disown -a
```
 - **parallel:** Runs all fastq dumps in parallel
 - **fastq-dump:** Downloads SRA data as a fastq file
 - **outdir fastq:** Puts output files into fastq directory
 - **gzip:** Compresses output files
 - **skip-technical:** Dumps only biological reads.
 - **readids:** Appends the ID# with .1 and .2 for split files. This is what programs for paired-end reads expects for input,
 - **read-filter pass:** Filters reads that do not pass filtering
 - **dumpbase:** Formats sequence using base space.
 - **split-3:** Separates the read into left and right ends. If there is a left end without a matching right end, or a right end without a matching left end, they will be put in a single file.
 - **clip:** Applies left and right clips to remove tags.
 
Make symbolic link to echille final project directory
```
cd ../../echille/finalproject/data
ln -s /RAID_STORAGE2/echille/finalproject
```

### Step 3: Initial Raw Data Assesment and Characterization  
*No checksum was provided for these samples on NCBI*

#### Check Read Counts
```
zcat SRR7235989_pass_1.fastq.gz | echo $((`wc -l`/4))
```
|Index|SRR Number|Expected Number of Reads|Reads Written Pass 1|Reads Written Pass 2|
|:-----:|:----------:|:----------:|:----------:|:--------:|
|1|SRR7235989|11,738,621|11738621|11738621|
|2|SRR7235990|10,218,844|10218844|10218844|
|3|SRR7235991|14,623,446|14623446|14623446|
|4|SRR7235992|11,529,163|11529163|11529163|
|5|SRR7235993|15,710,422|15710422|15710422|
|6|SRR7235994|13,661,163|13661163|13661163|
|7|SRR7235996|13,428,706|13428706|13428706|
|8|SRR7235998|16,010,284|16010284|16010284|
|9|SRR7235999|17,830,992|17830992|17830992|
|10|SRR7236021|14,846,260|14846260|14846260|
|11|SRR7236022|14,794,553|14794553|14794553|
|12|SRR7236028|17,339,044|17339044|17339044|
|13|SRR7236029|17,877,353|17877353|17877353|
|14|SRR7236030|13,739,115|13739115|13739115|
|15|SRR7236031|11,541,826|11541826|11541826|
|16|SRR7236032|12,659,512|12659512|12659512|
|17|SRR7236033|16,820,439|16820439|16820439|
|18|SRR7236034|11,054,898|11054898|11054898|
|19|SRR7236036|16,589,862|16589862|16589862|
|20|SRR7236037|14,925,154|14925154|14925154|


#### Check Read Quality Using FastQC and MultiQC

Install and Run FastQC
```
conda install -c bioconda fastqc
fastqc ../*fastq.gz .
```

Install and Run MultiQC  
*MultiQC parses bioinformatic analyses from FastQC and combines them into a single HTML report*
```
conda install -c bioconda multiqc
multiqc .
```
Save HTML file on local directory
```
scp -r -P xxxx echille@kitt.uri.edu:/home/echille/finalproject/data/finalproject/sratoolkit.2.9.6-centos_linux64/bin/fastq/fastqc ~/Documents/repos/BIO594_Puritz/Final_Assignment/Chille_Final_Assignment/MultiQC_results
```
##### MultiQC Results:  
![fastqc_sequence_counts](https://raw.githubusercontent.com/jpuritz/BIO_594_2019/master/Final_Assignment/Chille_Final_Assignment/MultiQC_results/Pre-Trimming/fastqc_sequence_counts_plot.png)  
![fastqc_mean_quality_scores](https://raw.githubusercontent.com/jpuritz/BIO_594_2019/master/Final_Assignment/Chille_Final_Assignment/MultiQC_results/Pre-Trimming/fastqc_per_base_sequence_quality_plot.png)  
![fastqc_per_sequence_quality_scores](https://raw.githubusercontent.com/jpuritz/BIO_594_2019/master/Final_Assignment/Chille_Final_Assignment/MultiQC_results/Pre-Trimming/fastqc_per_sequence_quality_scores_plot.png)  
![fastqc_per_sequence_gc_content](https://raw.githubusercontent.com/jpuritz/BIO_594_2019/master/Final_Assignment/Chille_Final_Assignment/MultiQC_results/fastqc_per_sequence_gc_content_plot.png)  


### Step 4: Quality Trimming and Adaptor Removal Using Trimmomatic  

Download [Trimmomatic](http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf)
```
curl -L -O http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip
unzip Trimmomatic-0.39.zip
rm Trimmomatic-0.39.zip
```
Link fastq files to Trimmomatic directory
```
cd Trimmomatic-0.39
ln -s ../*fastq.gz .
```
Run Trimmomatic with loop
```
for i in *pass_1.fastq.gz; do
    rsam=${i%pass*}
    java -jar trimmomatic-0.39.jar PE -phred33 $i ${rsam}pass_2.fastq.gz ${i}_paired_qtrim.fq.gz ${i}_unpaired_qtrim.fq.gz ${rsam}pass_2_paired_qtrim.fq.gz ${rsam}pass_2_unpaired_qtrim.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:5 TRAILING:3 SLIDINGWINDOW:4:25 MINLEN:50
    done
```
Quality-Check Trimmed Reads
```
mkdir qtrim
mv *qtrim.fastq.gz ./qtrim/
cd qtrim
fastqc *fq.gz
multiqc .
```
Save HTML file on local directory
```
scp -r -P 2292 echille@kitt.uri.edu:/home/echille/finalproject/data/finalproject/sratoolkit.2.9.6-centos_linux64/bin/fastq/trimmed_reads/Trimmomatic-0.39/qtrim/multiqc* ~/Documents/repos/BIO594_Puritz/Final_Assignment/Chille_Final_Assignment/MultiQC_results
```
##### MultiQC Results for Trimmed Files:  

![mean_sequence_quality](https://raw.githubusercontent.com/jpuritz/BIO_594_2019/master/Final_Assignment/Chille_Final_Assignment/MultiQC_results/Post-Trimming/fastqc_per_base_sequence_quality_plot.png)
![per_sequence_quality_scores](https://raw.githubusercontent.com/jpuritz/BIO_594_2019/master/Final_Assignment/Chille_Final_Assignment/MultiQC_results/Post-Trimming/fastqc_per_sequence_quality_scores_plot.png)
![sequence_length_distribution](https://raw.githubusercontent.com/jpuritz/BIO_594_2019/master/Final_Assignment/Chille_Final_Assignment/MultiQC_results/Post-Trimming/fastqc_sequence_length_distribution_plot.png)
![per_sequence_gc_content](https://raw.githubusercontent.com/jpuritz/BIO_594_2019/master/Final_Assignment/Chille_Final_Assignment/MultiQC_results/Post-Trimming/fastqc_per_sequence_gc_content_plot.png)

#### Step 6: Map Reads to Reference Genome  
Transfer reference [genome](https://www.ncbi.nlm.nih.gov/nuccore/1004128514?report=fasta) from local directory.
```
cd Downloads
scp -r -P xxxx Downloads/GCF_000222465.1_Adig_1.1_genomic.fna.gz echille@kitt.uri.edu:/RAID_STORAGE2/echille/finalproject/
```

Make directory for mapping
```
mkdir mapping
cd mapping
```
Link trimmed fastq files and reference.fasta file to mapping directory
```
ln -s ../data/finalproject/sratoolkit.2.9.6-centos_linux64/bin/reference/reference.fasta .
ln -s ../data/finalproject/sratoolkit.2.9.6-centos_linux64/bin/fastq/trimmed_reads/Trimmomatic-0.39/qtrim/*_qtrim.fq.gz .
```

Download [SAMBLASTER](https://github.com/GregoryFaust/samblaster) version 0.1.22 to flag and remove potential PCR duplicates  
```
git clone git://github.com/GregoryFaust/samblaster.git
cd samblaster
make
cp samblaster ../mapping/
```

Change headers in pass_2 FastQ files to match pass_1 files. Do this for each pass 2 file.
```
zcat SRR7235991_pass_2_paired_qtrim.fq.gz | sed 's/SRR7235991.2.2/SRR7235991.2.1/g' > SRR7235991_pass_2_paired_qtrim.fq
gzip SRR7235991_pass_2_paired_qtrim.fq
```

Set up an index for the reference genome 
```
samtools faidx GCF_000222465.1_Adig_1.1_genomic.fna.gz
```
Create and execute a bash [script](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Chille_Final_Assignment/Scripts/bwa.sh) to run bwa
```
nano bwa.sh

#!/bin/bash
F=/home/echille/finalproject/mapping
array1=($(ls *pass_1.fastq.gz_paired_qtrim.fq.gz | sed 's/pass_1.fastq.gz_paired_qtrim.fq.gz//g'))

bwa index GCF_000222465.1_Adig_1.1_genomic.fna
echo "done index $(date)"

for i in ${array1[@]}; do
  bwa mem $F/GCF_000222465.1_Adig_1.1_genomic.fna ${i}pass_1.fastq.gz_paired_qtrim.fq.gz ${i}pass_2_paired_qtrim.fq.gz -t 8 -a -M -B 3 -O 5 -R "@RG\tID:${i}\tSM:${i}\tPL:Illumina" 2> bwa.${i}.log | samblaster -M --removeDups | samtools view -@4 -q 1 -SbT $F/GCF_000222465.1_Adig_1.1_genomic.fna - > ${i}.bam
  echo "done ${i}"
done

array2=($(ls *.bam | sed 's/.bam//g'))

#now sort the bam files with samtools sort
for i in ${array2[@]}; do
  samtools sort -@8 ${i}.bam -o ${i}.bam && samtools index ${i}.bam
done

bash bwa.sh
```
**Ran into errors:**

> After replacing the headers I ran my bash script and all but 6 files went through without errors. Genomes SRR7235989_ SRR7235990_ SRR7235991_ SRR7235998_ SRR7236032_ SRR7236034_ had the error message: *[W::sam_read1] parse error at line 2424; [main_samview] truncated file*. These truncated files created empty bam files. The other files still only contain headers. 
> 
> 
> After that, I once again tried to run the command:  
> *bwa mem GCF_000222465.1_Adig_1.1_genomic.fna SRR7235992_pass_1.fastq.gz_paired_qtrim.fq.gz SRR72359992_pass_2_paired_qtrim.fq.gz  -t 8 -a -M -B 3 -O 5 -R "@RG\tID:${i}\tSM:${i}\tPL:Illumina" 2> bwa.SRR7235992.log*  
> on files that were "truncated" and files that went through without any error messages. 
> 
> However, when I tried to do the second part of the command *samtools view -@4 -q 1 -SbT $F/GCF_000222465.1_Adig_1.1_genomic.fna - > SRR7235992.bam*," I recieved the error *[samfaipath] fail to read file /GCF_000222465.1_Adig_1.1_genomic.fna.*
> 


**Because of extensive problems running BWA, the remainder of this file will document what I would have done if mapping had run smoothly:**


#### Step 7: Call SNPs with BCFtools 

Download BCFtools [Version 1.9](http://www.htslib.org/doc/bcftools.html)
```
git clone git://github.com/samtools/htslib.git
git clone git://github.com/samtools/bcftools.git
cd bcftools
autoheader && autoconf && ./configure --enable-libgsl --enable-perl-filters
make
```

Link _.bam files
```
ln -s ../*_.bam
```

Remove unmapped sequences and secondary alignments. Call SNPs and short INDELs. Mark low quality sites and generate VCF file.
```
bcftools mpileup -Ou -f --ff UNMAP GCF_000222465.1_Adig_1.1_genomic.fna.fa *_.bam | \
    bcftools call -Ou -mv | \
    bcftools filter -s LowQual -e '%QUAL<20 > total_snps.vcf
```

#### Step 8: Filter SNPs Using VCFtools

##### Prepare your workspace

Create directory for filtering. Copy total_snps.vcf.
```
cd ../
mkdir filtering
cd filtering
cp ../mapping/total_snps.vcf ./
```
Create popmap file
```
nano popmap

SRR7235990	FL
SRR7235991	FL
SRR7235992	FL
SRR7235993	FL
SRR7235994	FL
SRR7235989	VI
SRR7235998	VI
SRR7235999	VI
SRR7236021	VI
SRR7236022	VI
SRR7236028	BZ
SRR7236031	BZ
SRR7236032	BZ
SRR7236033	BZ
SRR7236034	BZ
SRR7235996	CC
SRR7236029	CC
SRR7236030	CC
SRR7236036	CC
SRR7236037	CC
```

Download filtering scripts
```
curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/ErrorCount.sh
chmod +x ErrorCount.sh 

curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/filter_hwe_by_pop.pl
chmod +x filter_hwe_by_pop.pl
```

##### Now we get to filtering

Remove INDELS
```
vcftools --vcf total_snps.vcf --remove-indels --recode --recode-INFO-all --out total_snps
```

Filter out genotypes found in fewer than 50% of individuals, minor allele count of 3, and lower quality scores
```
vcftools --vcf total_snps.recode.vcf --max-missing 0.5 --mac 3 --minQ 20 --recode --recode-INFO-all --out raw.g5mac3
```

Filter for a minimum mean depth and a minimum depth for a genotype call. Genotypes will be called if they have at least three reads.
```
vcftools --vcf raw.g5mac3.recode.vcf --minDP 3 --recode --recode-INFO-all --out raw.g5mac3dp3
```

Run a script to help evaluate sources of potential errors. This script counts the number of potential genotyping errors due to low read depth. It reports a low range, based on a 50% binomial probability of observing the second allele in a heterozygote and a high range based on a 25% probability.
```
./ErrorCount.sh raw.g5mac3dp3.recode.vcf
```

Filter out individuals with lots of missing data
```
vcftools --vcf raw.g5mac3dp3.recode.vcf --missing-indv
```

View histogram showing % Missing Data per individual  
```
mawk '!/IN/' out.imiss | cut -f5 > totalmissing
gnuplot << \EOF
set terminal dumb size 120, 30
set autoscale
unset label
set title "Histogram of % missing data per individual"
set ylabel "Number of Occurrences"
set xlabel "% of missing data"
#set yr [0:100000]
binwidth=0.01
bin(x,width)=width*floor(x/width) + binwidth/2.0
plot 'totalmissing' using (bin($1,binwidth)):(1.0) smooth freq with boxes
pause -1
EOF
```

Filter out individuals with more than 50% missing data. 

1. First create a file containing individuals with more than 50% missing data. This gives us a list of individuals to remove. We can feed it directly into VCFtools for filtering.
2. Determine population-specific call rate so we can filter for variants called in a high percentage of individuals and filter by mean depth of genotypes
3. Create two lists that have just the individual names for each population
4. Use VCFtools to estimate missing data for loci in each population. 
5. Use head to look at the last column with the % missing data for that locus
6. Combine the two files and make a list of loci above the threshold of 10% missing data to remove.
7. Feed this file back into VCFtools to remove any of the loci.
8. Check how many loci were removed
```
mawk '$5 > 0.5' out.imiss | cut -f1 > lowDP.indv
vcftools --vcf raw.g5mac3dp3.recode.vcf --remove lowDP.indv --recode --recode-INFO-all --out raw.g5mac3dplm

cat popmap

mawk '$2 == "FL"' popmap > 1.keep && mawk '$2 == "VI"' popmap > 2.keep && mawk '$2 == "BZ"' popmap > 3.keep && mawk '$2 == "CC"' popmap > 4.keep

vcftools --vcf DP3g95maf05.recode.vcf --keep 1.keep --missing-site --out 1
vcftools --vcf DP3g95maf05.recode.vcf --keep 2.keep --missing-site --out 2
vcftools --vcf DP3g95maf05.recode.vcf --keep 3.keep --missing-site --out 3 
vcftools --vcf DP3g95maf05.recode.vcf --keep 4.keep --missing-site --out 4 

head -3 1.lmiss

cat 1.lmiss 2.lmiss | mawk '!/CHR/' | mawk '$6 > 0.1' | cut -f1,2 >> badloci

vcftools --vcf DP3g95maf05.recode.vcf --exclude-positions badloci --recode --recode-INFO-all --out DP3g95p5maf05

mawk '/#/' DP3g95maf05.recode.vcf | wc -l
```

Remove any locus that has a quality score below 1/4 of the depth. High coverage can lead to inflated locus quality scores.
```
vcffilter -f "QUAL / DP > 0.25" raw.DP3g95p5maf05.fil1.vcf > raw.DP3g95p5maf05.fil2.vcf

# Check how many loci were removed
mawk '!/#/' DP3g95p5maf05.recode.vcf | wc -l
mawk '!/#/' DP3g95p5maf05.fil1.vcf | wc -l
```

Filter out sites that have reads from both strands. A SNP should be covered only by forward or only reverse reads.
```
vcffilter -f "SAF / SAR > 100 & SRF / SRR > 100 | SAR / SAF > 100 & SRR / SRF > 100" -s DP3g95p5maf05.fil1.vcf > DP3g95p5maf05.fil2.vcf

# Again check how many loci are still in the VCF file
mawk '!/#/' DP3g95p5maf05.fil2.vcf | wc -l
```

Filter by HWE
```
./filter_hwe_by_pop.pl
vcfallelicprimitives DP3g95p5maf05.FIL.recode.vcf --keep-info --keep-geno > DP3g95p5maf05.prim.vcf
vcftools --vcf DP3g95p5maf05.prim.vcf --remove-indels --recode --recode-INFO-all --out SNP.DP3g95p5maf05
perl filter_hwe_by_pop.pl -v SNP.DP3g95p5maf05.recode.vcf -p popmap -o SNP.DP3g95p5maf05.HWE -h 0.01
```

#### Step 9: Scan VCF for Neutral Loci and Loci Under Selection Using BayeScan v.2.1 and PCAdapt

##### Prepare workspace

Create directory. 
```
cd ../
mkdir outlier_detection
cd outlier_detection
```
Copy final filtered VCF file, popmap file, BSsnp.spid configuration file, and plot_R.r file.
```
cp ../filtering/SNP.DP3g95p5maf05.HWE.recode.vcf ./
cp ../filtering/popmap ./
cp ../../../../home/BIO594/DATA/Week7/example/BSsnp.spid ./
cp ../../week07and8/Filter/plot_R.r ./
```
Convert VCF files to run outlier detection
```
# For BayeScan: Run PGDspider to convert VCF into a format Bayscan can read
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.DP3g95p5maf05.HWE.recode.vcf -outputfile SNP.DP3g95p5maf05.HWEBS -spid BSsnp.spid

# For PCAdapt: Create VCF containing only bi-allelic SNPs
vcftools --vcf SNP.DP3g95p5maf05.HWE.recode.vcf --max-alleles 2 --recode --recode-INFO-all --out SNP.DP3g95p5maf05.HWE2A
```

##### Outlier detection using BayeScan
Run Bayescan
```
BayeScan2.1_linux64bits SNP.DP3g95p5maf05.HWEBS -nbp 30 -thin 20
```

Visualize results in R
```
source("plot_R.r")
plot_bayescan("SNP.TRSdp5p05FH_fst.txt")
```

##### Outlier detection using PCAdapt (in R)

https://cran.r-project.org/web/packages/pcadapt/vignettes/pcadapt.html

Load library and VCF file
```
library(pcadapt)
filename <- read.pcadapt("SNP.DP3g95p5maf05.HWE2A.recode.vcf", type = "vcf" )
```

Perform PCA to determine the number of principle components (K).
```
x <- pcadapt(input = filename, K = 20)
plot(x, option = "screeplot")
```

Look for inflection point in scree plot and make another PCA with K=inflection point *(I)*
```
x <- pcadapt(input = filename, K = I)
plot(x, option = "screeplot")
```

Create score plot where K represents relevent population structure
```
# Check number of individuals in each population. Should be 5 individuals in each.
grep FL popmap | wc -l
grep VI popmap | wc -l
grep BZ popmap | wc -l
grep CC popmap | wc -l

# Create score plot
poplist.names <- c(rep("FL", 5),rep("VI", 5),rep("BZ", 5),rep("CC", 5))
print(poplist.names)
plot(x, option = "scores", pop = poplist.names)
```

Look for population structure beyond K=I to confirm results of the scree plot. Make score plot with third and fourth principal components and so on. 
```
plot(x, option = "scores", i = 3, j = 4, pop = poplist.names)
plot(x, option = "scores", i = 4, j = 5, pop = poplist.names)
plot(x, option = "scores", i = 5, j = 6, pop = poplist.names)
```

Use a Manhattan plot to display −log10 of the p-values.
```
plot(x , option = "manhattan")
```

Also, check the expected uniform distribution of the p-values using a Q-Q plot
```
plot(x, option = "qqplot")
```

Detect outliers by plotting a histogram of the test statistic Dj.
```
plot(x, option = "stat.distribution")
```

Provide a list of outliers and choose a cutoff for outlier detection. The R package qvalue, transforms p-values into q-values.
1. Load library
2. Detect outliers
3. Save outliers to file "outliers.txt"
```
library(qvalue)

qval <- qvalue(x$pvalues)$qvalues
alpha <- 0.05
outliers <-which(qval < alpha)

outliers <- which(qval < alpha)
write.csv(outliers, "outliers.txt", row.names = FALSE)
```

Remove outlier loci detected by PCAdapt from vcf
1. Split SNP.DP3g95p5maf05.HWE2A.recode.vcf into header and body lines
2. Remove outlier lines from vcf body, save as neutralvcf body
3. Remove header from outlier file
4. Add vcf header lines back, save as outlier_filtered, neutral vcf file
```
grep '^#' -v SNP.DP3g95p5maf05.HWE2A.recode.vcf > filtered_SNPs_body.vcf
grep '^#' SNP.DP3g95maf05.HWE.FINAL.vcf > filtered_SNPs_headers.vcf

sed "$(sed 's/$/d/' outliers.txt)" filtered_SNPs_body.vcf > neutralSNPs_body.vcf

sed -i '1d' outliers.txt

cat filtered_SNPs_headers.vcf neutralSNPs_body.vcf > neutralSNPs.vcf
```

#### Step 10: Population-Level Analyses of Neutral SNPs

##### Examine genomic structure using PCA analysis and pairwise Fst on neutral loci

Adegenet

##### Evaluate summary statistics in neutral loci using the basic.stats function in the R package hierfstat
- observed heterozygosity
- expected heterozygosity
- overall FST
- FIS 


##### Use Treemix and Admixture to evaluate population connectivity