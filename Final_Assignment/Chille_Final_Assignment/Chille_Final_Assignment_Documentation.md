## Final Assignment Project Documentation
Population Structure and Gene Flow in *Acropora cervicornis*  
Author: E. Chille  

#### Step 1: Create Project Directory and Conda Environment
```
mkdir finalproject
cd finalproject
conda create -n finalproject
conda activate finalproject
```

#### Step 2: Download Data Using SRA-Toolkit
Download and Unpack SRA-Toolkit
```
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

#### Step 3: Initial Raw Data Assesment and Characterization

Check Read Counts
```
zcat SRR7235989_pass_1.fastq.gz | echo $((`wc -l`/4))
```
|Index|SRR Number|Number of Reads |Reads Written Pass 1|Reads Written Pass 2|
|:---:|:---:|:---:|:---:|:---:|:---:|
|1|SRR7235989|11,738,621|11738621|11738621|
|2|SRR7235990|10,218,844|10218844|10218844|
|3|SRR7235991|14,623,446|14623446|14623446|
|4|SRR7235992|11,529,163|11529163|11529163|
|5|SRR7235993|15,710,422|15710422|15710422|
|6|SRR7235994|13,661,163|13661163|13661163|
|7|SRR7235996|13,428,706|13428706|13428706|
|8|SRR7235998|16,010,284|16010284|16010284|
|9|SRR7235999|17,830,992|||
|10|SRR7236021|14,846,260|||
|11|SRR7236022|14,794,553|||
|12|SRR7236028|17,339,044|||
|13|SRR7236029|17,877,353|||
|14|SRR7236030|13,739,115|||
|15|SRR7236031|11,541,826|||
|16|SRR7236032|12,659,512|||
|17|SRR7236033|16,820,439|||
|18|SRR7236034|11,054,898|||
|19|SRR7236036|16,589,862|||
|20|SRR7236037|14,925,154|||

Check Read Quality

### Plan for post-download
#### Step 4: Map to Reference Genome
Align fastq files to reference genome using BWA. Using [documentation](http://bioinformatics-core-shared-training.github.io/cruk-bioinf-sschool/Day1/Sequence%20Alignment_July2015_ShamithSamarajiwa.pdf) by Shamith Samarajiwa as guide.
1. Download and install BWA (May have already done this in class?)
2. Download reference genome as fasta file
    - [Assembly report](https://www.ncbi.nlm.nih.gov/assembly/GCA_000222465.2#/st)
    - [*A. digitifera* Whole Genome Shotgun Sequence](https://www.ncbi.nlm.nih.gov/nuccore/1004128514?report=fasta).
        - I think this is what I want to wget?
3. Unzip and concatenate chromosome and contig fasta files
4. Create Reference Index
```
bwa index [-a bwtsw|is] index_prefix reference.fasta
-p index name (change this to whatever you want)
-a index algorithm (bwtsw for long genomes and is for short genomes)
```
3. Align files to reference genome
4. Generate BAM files

#### Step 5: Quality Filter 
1. Call SNPs using dDocent
2. Filter genotypes with:
    - Calls below 40% across all individuals
    - Minor allele frequency less than 0.1%
    - Minor allele count less than 3
    - Quality score less than 20 
3. Filter out reads with a minimum depth coverage of 5 calls
4. Filter by a population specific call rate of 5%? 
5. Automate filtering using dDocent_filters
6. Create a prim file for further filtering
7. Filter out indels and filter by hwe
8. Filter by Minor Allele Frequency of 5%

#### Step 6: Outlier Detection