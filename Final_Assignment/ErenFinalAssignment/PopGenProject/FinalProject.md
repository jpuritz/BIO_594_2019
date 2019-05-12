# Final Assignment for BIO594
## Eren Ada


#### 1. Data download:

I downloaded paired end sequence data for 25 individual from 5 different population from 1000 genome project:

  - 5 individual from Africa (AFR - Luhya, Kenya)
  - 5 individual from Europe (EUR - Finland)
  - 5 individual from America (AMR - Lima, Peru)
  - 5 individual from South Asia (SOA - Telugu, Indian)
  - 5 individual from East Asia (EAS - Tokyo, Japan)

Each individual has a paired end sequence data with 25-30x coverage.

Code (download.sh):

```
head -6 download.sh
```

```
## African Samples

# IND01; NA19027; Base Count: 120,366,211,800
wget -O AFR01.RawLeft.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR323/000/ERR3239690/ERR3239690_1.fastq.gz &
wget -O AFR01.RawRight.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR323/000/ERR3239690/ERR3239690_2.fastq.gz &

# IND02; NA19041; Base Count: 97,368,195,000
wget -O AFR02.RawLeft.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR323/008/ERR3239698/ERR3239698_1.fastq.gz &
wget -O AFR02.RawRight.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR323/008/ERR3239698/ERR3239698_2.fastq.gz &
```

#### 2. Quality Check

I use fastp to get quality reports for each read file (trimming.sh).  

```
cd Data/

fastp -i AFR01.RawLeft.fastq.gz -I AFR01.RawRight.fastq.gz -o AFR01.Left.fastq.gz -O AFR02.Right.fastq.gz

```

#### 3. Indexing & Mapping

To map the reads to reference genome, I used _bwa_ software.

Code:

```
bwa index GRCh38_latest_genomic.fna
```

Then I aligned reads to the reference.

(simple) Code:

```
bwa mem GRCh38_latest_genomic.fna.gz AFR01.RawRight.fastq.gz AFR01.RawLeft.fastq.gz > AFR01.sam
```

I wrote a bash script to stream .sam files to directly sorted .bam files:

I repeated this step for each population (only African example shown below - afr-mapping.sh).

```
#!/bin/bash

declare -a AFRleftlist=(AFR*.Left.*)
declare -a AFRrightlist=(AFR*.Right.*)
declare -a indexnamelist=(1 2 3 4 5)


for i in 0 1 2 3 4 5

do

bwa mem -t 20 GRCh38_latest_genomic.fna.gz ${AFRleftlist[$i]} ${AFRrightlist[$i]} -I 200,40 | samtools view -Su -@ 20 -F 4 - | samtools sort -@ 20 - -o AFR_"${indexnamelist[i]}".bam

done
```

After creating sorted .bam files, I indexed the sorted files to reference again.

```
for file in $(ls)

do

samtools index -@20 $file

done

```

To view the alignment:

```
samtools tview AFR_01.bam GRCh38_latest_genomic.fna.fai
```


#### 4. Variant Calling

As next step, I used bcftools to call variants.

```
bcftools mpileup -Ou -f $(ls *.bam) | bcftools call -vmO z -o calls.bcf

```

### 5. Variant Filtering

### 6. PCA and Population Structure Analyses
