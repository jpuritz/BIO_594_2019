
# CASE RNASeq Analysis  
Author: Maggie Schedl


Larval populations of the Eastern Oyster (Crassostrea virginica) were put in a short 24 hour stressor exposure in a multi-part experiment that I will only be analyzing a part of. The stressors used were Coastal Acidification (CA), Sewage Effluent (SE), or both (CASE). Larvae retained in seawater were used as a control. The larvae were then filtered out of their experimental bottle and flash frozen to preserve the DNA and RNA. RNA extracted from 1 replicate block of CA, CON, SE, and CASE were sequenced with RNASeq for this analysis.

General Statement: Did I fulfill my goals for this analysis? Not even close. Did I learn a lot and do I accept the amount of progress I have made so far? Yes.

Steps of Analysis:
- Looking at read counts
- QC, visualization, and trimming of reads  
- Using [HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml) to align reads to the Eastern Oyster genome
- Using [StringTie](https://ccb.jhu.edu/software/stringtie/index.shtml) to assemble alignments to transcripts with the Eastern Oyster annotation file
- Converting [StringTie](https://ccb.jhu.edu/software/stringtie/index.shtml) output into a transcript count matrix for [DESeq2](http://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html#contrasts)
- Using [DESeq2](http://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html#contrasts) to visualize data and look at log2 fold changes in expression levels between the treatments and control

_All analysis was done on our shared server, KITT, made by [J. Puritz](https://github.com/jpuritz)_  

Lines of code with this symbol `¯\_(ツ)_/¯` are used in my personal computer terminal window

Programs Installed/Needed for this Project:  
- HISAT2 `conda install hisat2`
- StringTie `conda install stringtie`
- gffcomare `conda install gffcompare`
- fastp, fastQC, multiqc
- samtools

File Naming and Information:
- **cvir_edited.fa**: Eastern Oyster genome, I received this from [Erin Roberts](https://github.com/erinroberts) and it has a space in the header line of each chromosome removed
- **ref_C_virginica-3.0_top_level.gff3**: annotation file for the Eastern Oyster, I also got this from Erin, it has the matching header line convention to work with the above genome
- **prepDE.py**: python script for converting read count information from StringTie into a matrix fo DESeq2, full code [here](http://ccb.jhu.edu/software/stringtie/dl/prepDE.py)
- **CA_J06**: this is an example of the naming convention of the samples, CA refers to the treatment (coastal acidification), and the J number refers to the replicate jar

Much of the scripts/analysis in the project was gleaned from Erin Robert's [RNASeq pipeline](https://github.com/erinroberts/apoptosis_data_pipeline/blob/master/Streamlined%20Pipeline%20Tutorial/Apoptosis_Pipeline_Tutorial_with_Reduced_Dataset.md) or Kevin Wong's [final project last year](https://github.com/jpuritz/BIO_594_2018/blob/master/FinalAssignment/KevinWong_FinalAssignment/P.dam_DE_Analysis.md), if other resources were used they should be linked in this markdown (ex. manuals for each program).

-------

#### Quality Control and Read Trimming

Reads were already de-multiplexed and assigned to each individual sample by [J. Puritz](https://github.com/jpuritz), and linked to a directory called CASE_RNA.

Because I was paranoid, I made a second directory to work in, and then linked in the files again.
```
mkdir Working-CASE-RNA
cd Working-CASE-RNA

ln -s /home/mschedl/CASE_RNA/* .
```

The first thing I did was look at the read counts for each file. I used a code from [this website](http://www.sixthresearcher.com/list-of-helpful-linux-commands-to-process-fastq-files-from-ngs-experiments/) and made it into a for-loop that went through all the files.

```
for fq in *.fq.gz
> do
>	echo $fq
> zcat $fq | echo $((`wc -l`/4))
> done
```
**Output:**  
CA_J06.F.fq.gz  
20445176  
CA_J06.R.fq.gz  
20445176  
CA_J08.F.fq.gz  
21746189  
CA_J08.R.fq.gz  
21746189  
CA_J11.F.fq.gz  
25550864  
CA_J11.R.fq.gz  
25550864  
CA_J18.F.fq.gz  
37263541  
CA_J18.R.fq.gz  
37263541  
CASE_J03.F.fq.gz  
26925142  
CASE_J03.R.fq.gz  
26925142  
CASE_J09.F.fq.gz  
31720810  
CASE_J09.R.fq.gz  
31720810  
CASE_J12.F.fq.gz  
24582739  
CASE_J12.R.fq.gz  
24582739  
CASE_J13.F.fq.gz  
36132924  
CASE_J13.R.fq.gz  
36132924  
CON_J02.F.fq.gz  
28850301  
CON_J02.R.fq.gz  
28850301  
CON_J05.F.fq.gz  
27446573  
CON_J05.R.fq.gz  
27446573  
CON_J10.F.fq.gz  
35291136  
CON_J10.R.fq.gz  
35291136  
SE_J01.F.fq.gz  
28376966  
SE_J01.R.fq.gz  
28376966  
SE_J04.F.fq.gz  
24827716  
SE_J04.R.fq.gz  
24827716  
SE_J07.F.fq.gz  
30894132  
SE_J07.R.fq.gz  
30894132  

Then I looked at the quality of the reads in each file. I like the look of the reports that [MultiQC](https://multiqc.info/) makes, and to make a MulitQC report, you need to use [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/).

```
mkdir fastqc-before

cd fastqc-before/

fastqc ../*fq.gz

mv *fastqc.* fastqc-before/

cd fastq-before/

multiqc .

```
Then the report.html can be copied from KITT to my computer, so I can then look at it in a web browser.

In a terminal window:  
```
¯\_(ツ)_/¯ scp -P zzzz mschedl@KITT.uri.edu:/home/mschedl/Working-CASE-RNA/fastqc-before/multiqc_report.html /Users/maggieschedl/Desktop/URI/Classes/Puritz/CASE-RNA/outputs
```

![image1](before-qual.png)  
These are the mean quality scores across all reads, they look really good (all above 30). There is a little dip in the beginning of some though.

![image2](before-per-seq-qual.png)  
These are the per-sequence quality scores. Again, most look pretty good, where a lot of them are above 30 or at 40. But there is a tail that goes low, so I would like to shrink that tail.

![image3](GC.png)  
This is an image of the GC content of all the reads. In theory it should look like a normal distribution. This is not very normally distributed, indicating some sort of bias or contamination.

**Results Specific to RNASeq Data**

![image4](seq-counts.png)  
This shows the number of unique and duplicate reads for each sample. Because this is RNASeq data, there should be a lot of duplicate reads.

![image5](over-rep-seq.png)  
Same with the over-represented sequences. This is to be expected with RNASeq data, but not good with other types of data.

----

I used [fastp](https://github.com/OpenGene/fastp) to trim the reads some, especially to get that per-sequance quality score up. The -F and -f flags trim the front of both reads. The -q flag is for the phred quality value that a base is qualified. The -u flag is how many percents of bases are allowed to be unqualified. To be completely honest, I am no longer very confident in how I did this.

```
fastp --in1 CA_J06.F.fq.gz --in2 CA_J06.R.fq.gz --out1 CA_J06.F.trim.fq.gz --out2 CA_J06.R.trim.fq.gz  -f 5 -F 5 -q 15 -u 50 -j CA_J06.json -h CA_J06.html
```

The same parameters were applied to each sample. At the time I did not feel like I could make a loop to do them all, so each code was run separately. Afterwards, another MultiQC report was generated.

![image6](after-qual.png)  
Importantly, the quality scores are still high.

![image7](after-pre-seq-qual)  
And the tail of that distribution scooted up a little.

----
#### Alignment to the Eastern Oyster Genome


The new fasta files generated with fastp can now be mapped to the Eastern Oyster genome with [HISAT2](https://ccb.jhu.edu/software/hisat2/manual.shtml), that link is to the manual, which I found most informative.

First I made a new directory to work in (yes, I spelled hisat wrong) as to not get confused by my files. Then I linked the trimmed fq.gz files into that directory, then I linked in the genome which lives in storage.

```
mkdir histat
cd histat   

ln -s /home/mschedl/Working-CASE-RNA/histat/*.trim.fq.gz .
ln -s /RAID_STORAGE2/mschedl/RNA-CASE/cvir_edited.fa .
```

Then I used a script to first use the genome to make an index for hisat, then align each .trim.fq.gz file to the genome. This takes both the forward and reverse reads and makes a sam file of the alignment. Then, because sam files are HUGE, and StringTie needs a sorted bam file anyways, the script sorts the sam file into a bam file, and then removes the sam file. The --dta flag is very important, the StringTie website legit has this phrase "NOTE: be sure to run HISAT2 with the --dta option for alignment, or your results will suffer." That flag makes the bam files configured in a way that works well with the next program, StringTie.


`nano CASE-HISAT2.sh`

```
##!/bin/bash

#Specify working directory
F=/home/mschedl/Working-CASE-RNA/histat/

#Indexing a reference genome and no annotation file (allowing for novel transcript discovery)
#Build HISAT index with Cvirginica genome file, this file is from Erin Roberts, it has the extra space in the headers of each chromosome removed

hisat2-build -f $F/cvir_edited.fa $F/cvirginica_hisat_edited
#-f indicates that the reference input files are FASTA files

#Aligning paired end reads
#Has the F in here because the sed in the for loop changes it to a R. SAM files are of both forward and reverse reads
array1=($(ls $F/*F.t.fq.gz))

# This then makes it into a bam file
# And then also sorts the bam file because Stringtie takes a sorted file for input
# And then removes the sam file because we don't need it anymore

for i in ${array1[@]}; do
        hisat2 --dta -x $F/cvirginica_hisat_edited -1 ${i} -2 $(echo ${i}|sed s/F.t/R.t/) -S ${i}.sam
        samtools sort ${i}.sam > ${i}.s.bam
    		echo "${i}_bam"
        rm ${i}.sam
        echo "HISAT2 PE ${i}" $(date)
done
```

The output of this step is a sorted bam file, that has been aligned to the _C. virginica_ genome. These files are then used with StringTie to generate annotation files with transcript abundances.  
Alignment rates were between 80-85%. The entire output from HISAT2 can be found in the outputs folder.

----
#### Transcript Assembly

I moved into a new directory stringtie to make things clearer, and then linked in the annotation file which lives in storage. And I linked the bam files from the directory above to this one.

```
mkdir stringtie
cd stringtie
ln -s /RAID_STORAGE2/mschedl/RNA-CASE/ref_C_virginica-3.0_top_level.gff3 .
ln -s /home/mschedl/Working-CASE-RNA/histat/*.s.bam .

```
Originally, I had tried to run StringTie with the annotation file downloaded from [NCBI](https://www.ncbi.nlm.nih.gov/genome/?term=Crassostrea%20virginica), which did not work, but that may have been for a variety of reasons at the time.


Note that I did not do all of StringTie in one script because of some problems with the merge step.

Via the [StringTie manual](https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual):
 - Run each sample with the -G flag if a reference annotation is available
 - Run StringTie with --merge in order to generate a non-redundant set of transcripts observed in all the samples assembled previously
 - For each sample, run StringTie using the -B/-b and -e options in order to estimate transcript abundances. The -e option is not required but recommended for this run in order to produce more accurate abundance estimations of the input transcripts. Each StringTie run in this step will take as input the sorted read alignments (BAM file) obtained in step 1 for the corresponding sample and the -G option with the merged transcripts (GTF file) generated by stringtie --merge in step 3. Please note that this is the only case where the -G option is not used with a reference annotation, but with the global, merged set of transcripts as observed across all samples. _Note that I did not use the -B or -b flags because those are for if you plan on using the program ballgown_



First StringTie uses the annotation file to make a .gtf file containing transcript abundances for each sample. It uses the sorted bam file from the previous step as the input, and then with the -G flag, uses the Eastern Oyster annotation file as a reference.

`nano CASE-Stringtie-1.sh`

```
#!/bin/bash
# In the same directory now with the BAM files and the annotation file link
F=/home/mschedl/Working-CASE-RNA/Clean-Files/sortedbam

# StringTie to assemble transcripts for each sample with the annotation file
array1=($(ls $F/*.bam))
for i in ${array1[@]}; do
	stringtie -G $F/ref_C_virginica-3.0_top_level.gff3 -o ${i}.gtf ${i}
	echo "${i}"
done
```
Some notes about the above script, I didn't use the -l flag here. You use it to specify the name of output transcripts in each individual .gtf file. Not only was I worried that having the label be sample-specific was causing problems with the merge step, it ends up not mattering because the merged .gtf file uses the default labels (STRG) and adds an M to it whether you label or not. Also, **not** including the -e flag allows for novel transcript discovery because it "Limits the processing of read alignments to only estimate and output the assembled transcripts matching the reference transcripts given with the -G option."

That created .gtf files for each sample, these will be merged into a single .gtf file that is non-redundant, and contains the transcripts from ALL of the files.

If you write out each file as input to be put in the merged .gtf file when using the --merge option of stringtie, then it will run with the -A flag. If you are not using the -A flag, you can make a .txt file of a list of all the sample names with the full path to each file on each line. Even though these files are in the directory you are running this in, it would only work with the pull path. This is different than what it says on the StringTie [manual](https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual). The -A flag is for: "Gene abundances will be reported (tab delimited format) in the output file with the given name."

```
stringtie --merge -A -G ref_C_virginica-3.0_top_level.gff3 -o C_Vir_ST_merged.gtf CA_J06.F.trim.fq.gz.s.bam.gtf CA_J08.F.trim.fq.gz.s.bam.gtf  CA_J11.F.trim.fq.gz.s.bam.gtf CA_J18.F.trim.fq.gz.s.bam.gtf CASE_J03.F.trim.fq.gz.s.bam.gtf CASE_J09.F.trim.fq.gz.s.bam.gtf CASE_J12.F.trim.fq.gz.s.bam.gtf CASE_J13.F.trim.fq.gz.s.bam.gtf CON_J02.F.trim.fq.gz.s.bam.gtf CON_J05.F.trim.fq.gz.s.bam.gtf CON_J10.F.trim.fq.gz.s.bam.gtf SE_J01.F.trim.fq.gz.s.bam.gtf SE_J04.F.trim.fq.gz.s.bam.gtf SE_J07.F.trim.fq.gz.s.bam.gtf
```
This made one merged .gtf file, C_Vir_ST_merged.gtf.

Then, I made a second script that uses the function gffcomare to give me some stats on how the reference annotation file and the merged annotation file compare. And it re-runs StringTie with the -e option and used the merged annotation file as the reference for assembly to the original bam files.

`nano CASE-Stringtie-2.sh`

```

#!/bin/bash
# In the same directory now with the BAM files and the annotation file link
F=/home/mschedl/Working-CASE-RNA/histat/stringtie

# Want to use those bam files again to RE-estimate the transcript abundances
array1=($(ls $F/*.bam))

# gffcompare to compare how transcripts compare to reference annotation
gffcompare -r $F/ref_C_virginica-3.0_top_level.gff3 -G -o c_vir_merged_compare C_Vir_ST_merged.gtf
	# -o specifies prefix to use for output files
	# -r followed by the annotation file to use as a reference
 	# merged.annotation.gtf tells you how well the predicted transcripts track to the reference annotation file
 	# merged.stats file shows the sensitivity and precision statistics and total number for different features (genes, exons, transcripts)

#Re-estimate transcript abundance after merge step
	for i in ${array1[@]}; do
		stringtie -e -G $F/C_Vir_ST_merged.gtf -o $(echo ${i}|sed "s/\..*//").merge.gtf ${i}
		echo "${i}"
	done
	# input here is the original set of alignment bam files
	# here -G refers to the merged GTF files
	# -e creates more accurate abundance estimations with input transcripts, needed when converting to DESeq2 tables, says in the manual that this is recommended
echo "DONE" $(date)
```

The comparison stats are in the outputs folder. The re-estimating with StringTie made a .merge.gtf file for each sample.

Those files are then the input for the script prepDE.py. It's a really long script so I'm not going to write it out here but I just nano-d a file called prepDE.py and pasted [this code](https://ccb.jhu.edu/software/stringtie/dl/prepDE.py) into it.  
Then I used `chmod u+x prepDE.py` to activate it.

**Important** this script requires version 2.7 of python to run (it will not be able to read your list of files if you try using a different one). To check your version of python type `python --version`  
KITT uses version 3.6.8 by default, but you can create an environment to run a different version

```
conda create -n python27 python=2.7 anaconda

conda activate python27

python --version

```
**Python 2.7.15**

The script needs a text file with the path to the merged.gtf files and the name of the samples as the input. A simple script can do that for you.

`nano prepDEtest.sh`
```
#!/bin/bash

F=/home/mschedl/Working-CASE-RNA/histat/stringtie


array2=($(ls *merge.gtf))

for i in ${array2[@]}; do
    echo "$(echo ${i}|sed "s/\..*//") $F/${i}" >> sample_list.txt
done
```
The sample_list.txt now has all the names and file paths. Then I ran the prepDE script.

```
python prepDE.py -i sample_lst.txt
```

This outputs a transcript_count_matrix.csv and a gene_count_matrix.csv

----

### DESeq2 and Differential Expression Analysis

I heavily used the DESeq2 [maual](http://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html) for this part.  
**This is still a work in progress** The code/figures included in this part of the markdown is not everything I have tried so far. I have included the full knitted html of my Rmarkdown file so far with this project.


First I made a .csv file with the metadata/treatment information for each sample. It looks basically like this:

| sample   | treatment | library | extraction |
|----------|-----------|---------|------------|
| CASE_J03 | CASE      | three   | two        |
| CASE_J09 | CASE      | four    | two        |
| CASE_J12 | CASE      | two     | three      |
| CASE_J13 | CASE      | two     | three      |
| CA_J06   | CA        | three   | two        |
| CA_J08   | CA        | one     | two        |
| CA_J11   | CA        | four    | three      |
| CA_J18   | CA        | two     | three      |
| CON_J02  | CON       | three   | one        |
| CON_J05  | CON       | one     | two        |
| CON_J10  | CON       | four    | two        |
| SE_J01   | SE        | one     | one        |
| SE_J04   | SE        | four    | three      |
| SE_J07   | SE        | three   | two        |

Then I uploaded it to KITT so I could use it in the same directory as the count matrixes.

```
¯\_(ツ)_/¯ scp -P zzzz /Users/maggieschedl/Desktop/treatment_data.csv mschedl@KITT.uri.edu:/home/mschedl/Working-CASE-RNA/histat/stringtie
```

I can access R through KITT via this link and my login information http://kitt.uri.edu:8787

Everything from now on is R code.

The first thing to do was download and bring in packages
```
source("http://bioconductor.org/biocLite.R")
biocLite(c("DESeq2"))
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("apeglm")
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("vsn")
library(DESeq2)
library(data.table)
library(dplyr)
library(tidyr)
library(reshape2)
library(apeglm)
library(ggplot2)
library(vsn)
library(pheatmap)
library(RColorBrewer)
```

Then I loaded in that csv file I just made, as well as the transcripts count file.
```
CASE_treatment_data <- read.csv("treatment_data.csv", header=TRUE, sep=",")
print(CASE_treatment_data)

CASE_TranscriptCountData <- as.data.frame(read.csv("transcript_count_matrix.csv", row.names="transcript_id"))
head(CASE_TranscriptCountData)
```
I did not do anything with the gene_count_matrix.csv so I am wondering if I should be using that.

Then I had to make sure that the columns in the transcript counts matrix and the treatment data matrix rows matched exactly.

```
#set row names for the treatment data to be the sample names
#set column names for the transcript counts to be the sample names
#I am pretty sure I already set them up to be correct
rownames(CASE_treatment_data) <- CASE_treatment_data$sample
colnames(CASE_TranscriptCountData) <- CASE_treatment_data$sample
CASE_treatment_data$sample <- NULL #get rid of the sample column in the treatment data
head(CASE_treatment_data)
head(CASE_TranscriptCountData)

#The row and column names for th two data frames need to be exactly the same for the rest of the analysis, so it is good to check
all(rownames(CASE_treatment_data) %in% colnames(CASE_TranscriptCountData))  #Should return TRUE

all(rownames(CASE_treatment_data) == colnames(CASE_TranscriptCountData))    # should return TRUE
```
The output was TRUE for both.

Then I made a DESeq2 matrx from those data frames
```
CASE_dd_Matrix <- DESeqDataSetFromMatrix(countData = CASE_TranscriptCountData,
                              colData = CASE_treatment_data,
                              design = ~ treatment) # column name of the treatment information
CASE_dd_Matrix
```
**Output:**   
class: DESeqDataSet  
dim: 79635 14   
metadata(1): version  
assays(1): counts  
rownames(79635): MSTRG.36809.1 MSTRG.34511.1 ... MSTRG.21894.4 MSTRG.21894.5  
rowData names(0):  
colnames(14): CASE_J03 CASE_J09 ... SE_J04 SE_J07  
colData names(3): treatment library extraction  

Then I did some pre-filtering of the Matrix for low count genes, I noticed when looking at the transcript csv that for some of the transcripts there were all 0s, so I can take those out. This does a sum, so this filters out any row that has less than 10 reads total.
```
keep <- rowSums(counts(CASE_dd_Matrix)) >= 10
CASE_dd_Matrix <- CASE_dd_Matrix[keep,]
CASE_dd_Matrix
```
This brought down the matrix from 79635 to 68253 rows.

I need to tell DESeq2 what the treatment levels are, if I don't, it will go alphabetically (aka make coastal acidification the control). Because there are 4 different "treatment levels" in this experiment, I think this is the way to do it.

```
CASE_dd_Matrix$treatment <- factor(CASE_dd_Matrix$treatment, levels = c("CON","CA", "SE", "CASE"))

levels(CASE_dd_Matrix$treatment)
```
**Output:**  
"CON"  "CA"   "SE"   "CASE"

Then the function DESeq does all of the differential expression analysis, and then I can specify results to be different comparisons.
```
CASE_dds <- DESeq(CASE_dd_Matrix)  
results_CON_CA <- results(CASE_dds, contrast=c("treatment","CON","CA"))
results_CON_SE <- results(CASE_dds, contrast=c("treatment","CON","SE"))
results_CON_CASE <- results(CASE_dds, contrast=c("treatment","CON","CASE"))
```
I checked to see if this looked right with this code
```
resultsNames(CASE_dds)
```
**Output:**  
[1] "Intercept"             "treatment_CA_vs_CON"   "treatment_SE_vs_CON"   "treatment_CASE_vs_CON"


Then I used Log fold shrinkage: Shrinkage of effect size (LFC estimates) is useful for visualization and ranking of genes.
I'm assumed that I do this for each one
```
CAresLFC <- lfcShrink(CASE_dds, coef="treatment_CA_vs_CON", type="apeglm") #the type is just the shrinkage method, which is chosen on the DESeq2 site
CAresLFC

SEresLFC <- lfcShrink(CASE_dds, coef = "treatment_SE_vs_CON", type = "apeglm")
SEresLFC

CASEresLFC <- lfcShrink(CASE_dds, coef = "treatment_CASE_vs_CON", type = "apeglm")
CASEresLFC
```

Then I used PlotMA to look at the log2 fold changes for each comparison. "plotMA shows the log2 fold changes attributable to a given variable over the mean of normalized counts for all the samples in the DESeqDataSet. Points will be colored red if the adjusted p value is less than 0.1"

```
plotMA(CAresLFC, ylim=c(-10,15))
plotMA(SEresLFC, ylim=c(-10,15))
plotMA(CASEresLFC, ylim=c(-10,15))
```
Coastal Acidification compared to Control  
![image8](CAresLFC.png)

Sewage Effluent compared to  Control  
![image9](SEresLFC.png)

Coastal Acidification + Sewage Effluent Double Stress compared to Control  
![image10](CASEresLFC.png)

Then I looked at which transcripts had the lowest adjusted pvalue. Interestingly, SE and CASE had the same transcript for this.

```
#Coastal Acidifcation lowest adjusted pvalue
minadjpCA <- plotCounts(CASE_dds, gene=which.min(CAresLFC$padj), intgroup="treatment",
                returnData=TRUE)

ggplot(minadjpCA, aes(x=treatment, y=count)) +
  geom_point(position=position_jitter(w=0.1,h=0), colour="#9e7bc6") +
  scale_y_log10(breaks=c(25,100,400)) + ggtitle("MSTRG.25584.1") + ylab("Normalize Read Counts") + xlab("Treatment")
  ```
  ![image11](MSTRG.25584.1.png)

  ```
  #Sewage Effluent/Both lowest adjusted pvalue
minadjpSE <- plotCounts(CASE_dds, gene=which.min(SEresLFC$padj), intgroup="treatment",
                returnData=TRUE)

ggplot(minadjpSE, aes(x=treatment, y=count)) +
  geom_point(position=position_jitter(w=0.1,h=0), colour="#f2a7ed") +
  scale_y_log10(breaks=c(25,100,400)) + ggtitle("MSTRG.23078.1") + ylab("Normalize Read Counts") + xlab("Treatment")
  ```
  ![image12](MSTRG.23078.1.png)

  I looked at some heat maps, did various transformations, and some other things I'm not sure about yet. Here I'm just going to show the variance stabilizing transformation and some preliminary PCAs.

  ```
  vsd_CASE_dds <- vst(CASE_dds, blind=FALSE) #variance stabilizing transformation
  ```
  Then I made a PCA with groups based on treatment or library

  ```
  plotPCA(vsd_CASE_dds, intgroup=c("treatment"))
  ```
  ![image13](treatmentPCA.png)

  ```
  plotPCA(vsd_CASE_dds, intgroup=c("library")
  ```
  ![image14](libraryPCA.png)

  Moving Forward: It kind of looks like things cluster better by library. So that is something I need to remove from the data. I also am not sure if I used the right transformation, if I am using the right DESeq2 object, maybe I should be using the multi-factorial one for analysis. Or I should have made it from the gene_count_matrix and not the transcript_count_matrix in the first place. These are all things I will try next! 
