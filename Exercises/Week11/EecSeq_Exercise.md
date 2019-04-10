# EecSeq Exercise
### BIO 594
### Designed by Jon Puritz

# GOALS
1.  To explore a small EecSeq data set
2.	To learn how to use bedtools and samtools to explore coverage across genomic intervals and annotations
3.	To plot the coverage of EecSeq pools across a gene of interest

----------

Let's find our way back to your original working directory and make a new EecSeq directory

```
cd ~/Week11
mkdir EecSeq
cd EecSeq
conda create -n EecSeq ddocent
source activate EecSeq
```
Now we can link to the data in our shared class directory

```
ln -s /home/BIO594/Exercises/Week_11/EecSeq/* .
```

We have three replicate capture pools, EC_2, EC_4, EC_7, as well as the reference sequence for chromosome 1 and a few other files

`ls *.fq.gz`

`ls ref_C_virginica.fasta`

Remember, exome capture reads are derived from genomic DNA.  The reads in the FASTQ files already have been trimmed 
and only contain reads that originally mapped to Chromosome 1 of the eastern oyster genome.
This means that we can proceed directly to mapping with BWA and sorting with samtools.  
```
bwa mem reference.fasta EC_2.F.fq.gz EC_2.R.fq.gz -t 8 -a -M -B 3 -O 5 -R "@RG\tID:EC_2\tSM:EC_2\tPL:Illumina" 2> bwa.EC_2.log | samtools view -@4 -q 1 -SbT reference.fasta - > EC_2.bam
bwa mem reference.fasta EC_4.F.fq.gz EC_4.R.fq.gz -t 8 -a -M -B 3 -O 5 -R "@RG\tID:EC_4\tSM:EC_4\tPL:Illumina" 2> bwa.EC_4.log | samtools view -@4 -q 1 -SbT reference.fasta - > EC_4.bam
bwa mem reference.fasta EC_7.F.fq.gz EC_7.R.fq.gz -t 8 -a -M -B 3 -O 5 -R "@RG\tID:EC_7\tSM:EC_7\tPL:Illumina" 2> bwa.EC_7.log | samtools view -@4 -q 1 -SbT reference.fasta - > EC_7.bam
samtools sort -@8 EC_2.bam -o EC_2.bam && samtools index EC_2.bam 
samtools sort -@8 EC_4.bam -o EC_4.bam && samtools index EC_4.bam 
samtools sort -@8 EC_7.bam -o EC_7.bam && samtools index EC_7.bam 
``` 
The next thing we want to do is to mark duplicate reads.  We will use Picard tools to do this (https://broadinstitute.github.io/picard/)
Picard is a java jar file, so we can download it directly here:
  
`wget https://github.com/broadinstitute/picard/releases/download/2.17.8/picard.jar`
 
Now we can use Picard to mark PCR duplicates in our files
``` 
java -Xms4g -jar picard.jar MarkDuplicatesWithMateCigar I=EC_2.bam O=EC_2md.bam M=EC_2_dup_metrics.txt MINIMUM_DISTANCE=300
``` 
The output should end with something like this:
```
INFO	2018-02-11 14:21:41	MarkDuplicatesWithMateCigar	Marking 250325 records as duplicates.
INFO	2018-02-11 14:21:41	MarkDuplicatesWithMateCigar	Found 14208 optical duplicate clusters.
``` 
```
java -Xms4g -jar picard.jar MarkDuplicatesWithMateCigar I=EC_4.bam O=EC_4md.bam M=EC_4_dup_metrics.txt MINIMUM_DISTANCE=300
```

The output should end with something like this:
```
INFO	2018-02-11 14:23:56	MarkDuplicatesWithMateCigar	Marking 215838 records as duplicates.
INFO	2018-02-11 14:23:56	MarkDuplicatesWithMateCigar	Found 11010 optical duplicate clusters.
``` 
```
java -Xms4g -jar picard.jar MarkDuplicatesWithMateCigar I=EC_7.bam O=EC_7md.bam M=EC_7_dup_metrics.txt MINIMUM_DISTANCE=300
```
The output should end with something like this:
```
INFO	2018-02-11 14:26:15	MarkDuplicatesWithMateCigar	Marking 196129 records as duplicates.
INFO	2018-02-11 14:26:15	MarkDuplicatesWithMateCigar	Found 9912 optical duplicate clusters.
```
 
Now that we have marked duplicates, we want to filter them out along with secondary alignments, 
mappings with a quality score less than ten, and reads with more than 80 bp clipped
```
samtools view -@8 -h -F 0x100 -q 10 -F 0x400 EC_2md.bam | mawk '$6 !~/[8-9].[SH]/ && $6 !~ /[1-9][0-9].[SH]/'| samtools view -@8 -b > EC_2.F.bam 
samtools view -@8 -h -F 0x100 -q 10 -F 0x400 EC_4md.bam | mawk '$6 !~/[8-9].[SH]/ && $6 !~ /[1-9][0-9].[SH]/'| samtools view -@8 -b > EC_4.F.bam 
samtools view -@8 -h -F 0x100 -q 10 -F 0x400 EC_7md.bam | mawk '$6 !~/[8-9].[SH]/ && $6 !~ /[1-9][0-9].[SH]/'| samtools view -@8 -b > EC_7.F.bam
 ```
Now we can check to make sure we have filtered out reads
The command below takes advantage of subshells to run two instances of samtools at once
`paste <(samtools view -c EC_2md.bam) <(samtools view -c EC_2.F.bam )`
```
4452457	4046543
```
`paste <(samtools view -c EC_4md.bam) <(samtools view -c EC_4.F.bam )`
```
3640292	3287939
```

`paste <(samtools view -c EC_7md.bam) <(samtools view -c EC_7.F.bam )`
```
3642623	3316236
```
 	
Now, we have our final, filtered bam files.  The next step in our exploratory analysis is to calculate the depth per bp along the reference.
We will use samtools to do this

```
samtools depth -aa EC_2.F.bam > EC_2.genome.depth
samtools depth -aa EC_4.F.bam > EC_4.genome.depth
samtools depth -aa EC_7.F.bam > EC_7.genome.depth
```

This output has a simple format:
Chromosome	bp	depth
 
`head EC_2.genome.depth`
```
NC_035780.1	1	3
NC_035780.1	2	5
NC_035780.1	3	6
NC_035780.1	4	7
NC_035780.1	5	7
NC_035780.1	6	7
NC_035780.1	7	8
NC_035780.1	8	13
NC_035780.1	9	16
NC_035780.1	10	16
```
 
If you recall, we used a heat challenge as a proof of concept for our new method.  
Let's look at coverage across a heat shock protein to see if we are indeed 
enriching for targets that we expect to be expressed.

For graphing purposes, we are going to look at a smaller region of Chromosome 1.  Let's reduce our files to this region using awk (mawk).
``` 
mawk '$2 > 32736205 && $2 < 32866205' EC_2.genome.depth > EC_2.graph.depth 
mawk '$2 > 32736205 && $2 < 32866205' EC_4.genome.depth > EC_4.graph.depth 
mawk '$2 > 32736205 && $2 < 32866205' EC_7.genome.depth > EC_7.graph.depth 
```
 
To create a tidy file let's concatenate the three files together and add a column for a sample identifier
``` 
sed -i 's/$/\tEC_2/g' EC_2.graph.depth 
sed -i 's/$/\tEC_4/g' EC_4.graph.depth 
sed -i 's/$/\tEC_7/g' EC_7.graph.depth
echo -e "Contig\tbp\tDepth\tSample" > header
cat header EC_*.graph.depth > TotalCov.txt 
``` 
 
For the graph, we also want annotations of genes, exons, and coding sequence.  We can extract this from the .gff annotations file included with the genome.
``` 
mawk '$4 > 32736205' ref_C_virginica-3.0_top_level.CHR_1.gff3 | mawk '$5 < 32866205' | mawk '$3 == "exon"' | cut -f1,4,5,9 | uniq -w 30 | sed 's/ID=.*product=//g' | sed 's/;trans.*//g' | sed 's/%.*//g' > exons
cat <(echo -e "Contig\tStart\tEnd\tTreatment") exons > exon.list
```
``` 
mawk '$4 > 32736205' ref_C_virginica-3.0_top_level.CHR_1.gff3 | mawk '$5 < 32866205' | mawk '$3 == "mRNA"' | cut -f1,4,5,9 | uniq -w 30 | sed 's/ID=.*product=//g' | sed 's/;trans.*//g' | sed 's/%.*//g' > genes
cat <(echo -e "Contig\tStart\tEnd\tTreatment") genes > genes.list
```
```
mawk '$4 > 32736205' ref_C_virginica-3.0_top_level.CHR_1.gff3 | mawk '$5 < 32866205' | mawk '$3 == "CDS"' | cut -f1,4,5,9 | uniq -w 30 | sed 's/ID=.*product=//g' | sed 's/;trans.*//g' | sed 's/%.*//g' > CDS
cat <(echo -e "Contig\tStart\tEnd\tTreatment") CDS > CDS.list
``` 
 
We also are going to use information from the RNAseq reads of our probe sequences.  
I've already calculated these files for you, but the process is very similar to what we used for the DNA reads.
We simply need to make a header file and concatenate them.

``` 
echo -e "Contig\tbp\tDepth\tSample" > header
cat header *.exon.cov.stats > TotalRNACov.txt
``` 

To actually plot our graph, we will use R, so let's switch to RStudio
 
This will open the R program.  Now enter the following code into the console.  
The command prompt should now be a ">"
 
First, we need to load the proper libraries:
```
library(ggplot2)
library(grid)
library(plyr)
library(dplyr)
library(scales)
library(zoo)
```
 
Next, let's set a color palette and import our data
```
cbPalette <- c("#D55E00", "#009E73", "#56B4E9" ,"#0072B2" ,"#E69F00" ,"#F0E442" ,"#999999" ,"#CC79A7","#7570B3")
DepC <- read.table("TotalCov.txt", header = TRUE)
DepR <- read.table("TotalRNACov.txt", header = TRUE)
``` 
Next, we set our tables to data frames and put in the proper factors.
``` 
DepC <- as.data.frame(DepC)
DepC$Sample <- factor(DepC$Sample,levels=c("EC_2","EC_4","EC_7"))
DepR <- as.data.frame(DepR)
DepR$Sample <- factor(DepR$Sample,levels=c("RNA_1","RNA_2","RNA_3","RNA_4"))
``` 
 
Next we read in our exons, genes, and CDS and convert to data frames as well.
```
exons <- read.table("exon.list", header = TRUE, sep = "\t")
exons <- as.data.frame(exons)
 
genes <- read.table("genes.list", header = TRUE, sep = "\t")
genes <- as.data.frame(genes)
 
cds <- read.table("CDS.list", header = TRUE, sep = "\t")
cds <- as.data.frame(cds)
``` 
 
Our data is still a little too big for plotting purposes, so let's subset it.
``` 
subDepC <-subset(DepC, bp <32755000 & bp > 32739000)
subDepR <-subset(DepR, bp <32755000 & bp > 32739000)
subexons <-subset(exons, End <32755205 & End > 32740205)
subgenes <-subset(genes, End <32800757 & Start < 32754201)
subcds <-subset(cds, End <32800757 & Start < 32755000)
subDepR$Depth <- subDepR$Depth / -1
submean.cov <- ddply(subDepC, .(Contig,bp), summarize,  Depth=mean(Depth))
submeanR.cov <- ddply(subDepR, .(Contig,bp), summarize,  Depth=mean(Depth))
subgenes$End[4] <- 32755000
```
Ok, now we are ready to plot.  First, let's take care of a couple color settings. 
 
```
redcol <-"#940000"
cbPalettedd <- c( "#009E73","#D55E00", "#E69F00")
``` 
 
Now, we can use ggplot to make our graph and save it to a PNG file
``` 
dd <- ggplot(subDepC, aes(x= bp, y=Depth)) +
  geom_area(aes(group=Sample),position = "identity",color=alpha("grey30",0.25),fill=cbPalette[4], alpha=0.1, linetype="dotted")+  
  geom_line(data=submean.cov,aes(y=rollmean(Depth, 100, na.pad=TRUE)),colour=cbPalette[4], size =1.0, alpha=0.9)  +
  geom_line(data=submeanR.cov,aes(y=rollmean(Depth, 100, na.pad=TRUE)),colour=redcol, size =1.0, alpha=0.9)  +
  geom_area(data=subDepR, aes(group=Sample),position = "identity",color=alpha("grey30",0.25),fill=redcol, alpha=0.1, linetype="dotted")+
  scale_color_manual(values=cbPalettedd) +
  geom_segment(data=subgenes, aes(x = Start, y = 715, xend = End, yend = 715), size = 6,color=cbPalette[9], alpha=1)+
  geom_segment(data=subexons,aes(x = Start, y = 715, xend = End, yend = 715, color=Treatment),size = 4, alpha=1) +
  geom_segment(data=subcds,aes(x = Start, y = 715, xend = End, yend = 715),size = 1, color="grey90", alpha=1) +
  theme_bw()+
  coord_cartesian(xlim = c(32740000,32755000))+
  xlim(32740000,32755000) +
  scale_y_continuous(limits=c(-415,735),labels=c("250","0","500"), breaks=c(-250,0,500),expand=c(0.01,0)) +
  guides(color=guide_legend("Exons")) +
  theme(legend.position = c(0.75, 0.15))

png(filename="EecSeq_Figure.png", type="cairo",units="px", width=5600, 
    height=3000, res=600, bg="transparent")
dd
dev.off()
``` 
 
We're done here, so let's quit R.
 
`quit()`
 
 
Now, you can exit KITT and then copy your figure to your local computer
 
`exit`
`scp my_username@kitt.uri.edu:Week10/EecSeq/EecSeq_Figure.png ~/Downloads`
 
Don't forget to put in your username in for the my_username.

Also, if you are using a windows machine, you may have to use an FTP client to transfer this file.  
 
Once you open the file:

![alt text](https://github.com/jpuritz/Winter.School2018/raw/master/Exercises/Day1/EecSeq_Figure.png)

Each exome capture pool coverage is plotted in light blue with dashed grey border, 
and a rolling 100 bp window average across all pools is plotted in dark blue. 
Each RNAseq (probe) sample coverage is plotted in light red with dashed grey border 
and a rolling 100 bp window average across all pools is plotted in dark red. 
Gene regions are marked in purple with exons color coded by gene. 
Coding sequence (CDS) is marked by a white bar within exon markers.
 
We can see that we did enrich for exon coverage in the Heat Shock Cognate 71 kDa Protein!
 


