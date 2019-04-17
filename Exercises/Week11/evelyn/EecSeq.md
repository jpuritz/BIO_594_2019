#### EecSeq Exercises
#####
1. To explore a small EecSeq data set
2. To learn how to use bedtools and samtools to explore  coverage across genomic intervals and annotations
3. To plot the coverage of EecSeq pools across a gene of interest
```
cd ~/Week11
mkdir EecSeq
cd EecSeq
conda create -n EecSeq ddocent
source activate EecSeq
```
```
ln -s /home/BIO594/Exercises/Week_11/EecSeq/* .
```
```
bwa mem reference.fasta EC_2.F.fq.gz EC_2.R.fq.gz -t 8 -a -M -B 3 -O 5 -R "@RG\tID:EC_2\tSM:EC_2\tPL:Illumina" 2> bwa.EC_2.log | samtools view -@4 -q 1 -SbT reference.fasta - > EC_2.bam
bwa mem reference.fasta EC_4.F.fq.gz EC_4.R.fq.gz -t 8 -a -M -B 3 -O 5 -R "@RG\tID:EC_4\tSM:EC_4\tPL:Illumina" 2> bwa.EC_4.log | samtools view -@4 -q 1 -SbT reference.fasta - > EC_4.bam
bwa mem reference.fasta EC_7.F.fq.gz EC_7.R.fq.gz -t 8 -a -M -B 3 -O 5 -R "@RG\tID:EC_7\tSM:EC_7\tPL:Illumina" 2> bwa.EC_7.log | samtools view -@4 -q 1 -SbT reference.fasta - > EC_7.bam

(EecSeq) [etakyi@KITT EecSeq]$ samtools sort -@8 EC_2.bam -o EC_2.bam && samtools index EC_2.bam
(EecSeq) [etakyi@KITT EecSeq]$ samtools sort -@8 EC_4.bam -o EC_4.bam && samtools index EC_4.bam
(EecSeq) [etakyi@KITT EecSeq]$ samtools sort -@8 EC_7.bam -o EC_7.bam && samtools index EC_7.bam
```
```
java -Xms4g -jar picard.jar MarkDuplicatesWithMateCigar I=EC_2.bam O=EC_2md.bam M=EC_2_dup_metrics.txt MINIMUM_DISTANCE=300
```

### Marking duplicate reads using bam files
```
(EecSeq) [etakyi@KITT EecSeq]$ java -Xms4g -jar picard.jar MarkDuplicatesWithMateCigar I=EC_2.bam O=EC_2md.bam M=EC_2_dup_metrics.txt MINIMUM_DISTANCE=300
INFO	2019-04-17 11:56:03	MarkDuplicatesWithMateCigar	Read     1,000,000 records.  Elapsed time: 00:00:13s.  Time for last 1,000,000:   13s.  Last read position: NC_035780.1:15,551,977
INFO	2019-04-17 11:56:03	MarkDuplicatesWithMateCigar	freeMemory: 4089277648; totalMemory: 4116185088; maxMemory: 28631367680; output buffer size: 19; duplicate queue size: 8
INFO	2019-04-17 11:56:16	MarkDuplicatesWithMateCigar	Read     2,000,000 records.  Elapsed time: 00:00:27s.  Time for last 1,000,000:   13s.  Last read position: NC_035780.1:28,073,712
INFO	2019-04-17 11:56:16	MarkDuplicatesWithMateCigar	freeMemory: 4245137000; totalMemory: 4280811520; maxMemory: 28631367680; output buffer size: 1111; duplicate queue size: 746
INFO	2019-04-17 11:56:29	MarkDuplicatesWithMateCigar	Read     3,000,000 records.  Elapsed time: 00:00:40s.  Time for last 1,000,000:   13s.  Last read position: NC_035780.1:42,060,034
INFO	2019-04-17 11:56:29	MarkDuplicatesWithMateCigar	freeMemory: 4246881368; totalMemory: 4281335808; maxMemory: 28631367680; output buffer size: 27; duplicate queue size: 18
INFO	2019-04-17 11:56:42	MarkDuplicatesWithMateCigar	Read     4,000,000 records.  Elapsed time: 00:00:53s.  Time for last 1,000,000:   13s.  Last read position: NC_035780.1:59,615,912
INFO	2019-04-17 11:56:42	MarkDuplicatesWithMateCigar	freeMemory: 4247660528; totalMemory: 4282908672; maxMemory: 28631367680; output buffer size: 183; duplicate queue size: 72
INFO	2019-04-17 11:56:48	MarkDuplicatesWithMateCigar	Processed 4452400 records
INFO	2019-04-17 11:56:48	MarkDuplicatesWithMateCigar	Found 0 records with no mate cigar optional tag.
INFO	2019-04-17 11:56:48	MarkDuplicatesWithMateCigar	Marking 250326 records as duplicates.
INFO	2019-04-17 11:56:48	MarkDuplicatesWithMateCigar	Found 14208 optical duplicate clusters.
[Wed Apr 17 11:56:48 EDT 2019] picard.sam.markduplicates.MarkDuplicatesWithMateCigar done.
```
```
(EecSeq) [etakyi@KITT EecSeq]$ java -Xms4g -jar picard.jar MarkDuplicatesWithMateCigar
 I=EC_4.bam O=EC_4md.bam M=EC_4_dup_metrics.txt MINIMUM_DISTANCE=300
 ```
 ```
INFO	2019-04-17 12:01:02	MarkDuplicatesWithMateCigar	Read     1,000,000 records.  Elapsed time: 00:00:14s.  Time for last 1,000,000:   14s.  Last read position: NC_035780.1:18,283,732
INFO	2019-04-17 12:01:02	MarkDuplicatesWithMateCigar	freeMemory: 4089266416; totalMemory: 4116185088; maxMemory: 28631367680; output buffer size: 21; duplicate queue size: 16
INFO	2019-04-17 12:01:16	MarkDuplicatesWithMateCigar	Read     2,000,000 records.  Elapsed time: 00:00:28s.  Time for last 1,000,000:   14s.  Last read position: NC_035780.1:34,022,905
INFO	2019-04-17 12:01:16	MarkDuplicatesWithMateCigar	freeMemory: 4246715752; totalMemory: 4280811520; maxMemory: 28631367680; output buffer size: 118; duplicate queue size: 82
INFO	2019-04-17 12:01:30	MarkDuplicatesWithMateCigar	Read     3,000,000 records.  Elapsed time: 00:00:42s.  Time for last 1,000,000:   14s.  Last read position: NC_035780.1:55,514,050
INFO	2019-04-17 12:01:30	MarkDuplicatesWithMateCigar	freeMemory: 4246804496; totalMemory: 4281335808; maxMemory: 28631367680; output buffer size: 73; duplicate queue size: 53
INFO	2019-04-17 12:01:39	MarkDuplicatesWithMateCigar	Processed 3640300 records
INFO	2019-04-17 12:01:39	MarkDuplicatesWithMateCigar	Found 0 records with no mate cigar optional tag.
INFO	2019-04-17 12:01:39	MarkDuplicatesWithMateCigar	Marking 215837 records as duplicates.
INFO	2019-04-17 12:01:39	MarkDuplicatesWithMateCigar	Found 11009 optical duplicate clusters.
[Wed Apr 17 12:01:39 EDT 2019] picard.sam.markduplicates.MarkDuplicatesWithMateCigar done. Elapsed time: 0.86 minutes.
```
```
(EecSeq) [etakyi@KITT EecSeq]$ java -Xms4g -jar picard.jar MarkDuplicatesWithMateCigar I=EC_7.bam O=EC_7md.bam M=EC_7_dup_metrics.txt MINIMUM_DISTANCE=300
```
```
INFO	2019-04-17 11:58:58	MarkDuplicatesWithMateCigar	Read     1,000,000 records.  Elapsed time: 00:00:14s.  Time for last 1,000,000:   14s.  Last read position: NC_035780.1:17,874,978
INFO	2019-04-17 11:58:58	MarkDuplicatesWithMateCigar	freeMemory: 4089091152; totalMemory: 4116185088; maxMemory: 28631367680; output buffer size: 117; duplicate queue size: 59
INFO	2019-04-17 11:59:12	MarkDuplicatesWithMateCigar	Read     2,000,000 records.  Elapsed time: 00:00:28s.  Time for last 1,000,000:   14s.  Last read position: NC_035780.1:33,838,965
INFO	2019-04-17 11:59:12	MarkDuplicatesWithMateCigar	freeMemory: 4246535096; totalMemory: 4280811520; maxMemory: 28631367680; output buffer size: 277; duplicate queue size: 9
INFO	2019-04-17 11:59:26	MarkDuplicatesWithMateCigar	Read     3,000,000 records.  Elapsed time: 00:00:42s.  Time for last 1,000,000:   14s.  Last read position: NC_035780.1:55,705,103
INFO	2019-04-17 11:59:26	MarkDuplicatesWithMateCigar	freeMemory: 4246885504; totalMemory: 4281335808; maxMemory: 28631367680; output buffer size: 22; duplicate queue size: 16
INFO	2019-04-17 11:59:35	MarkDuplicatesWithMateCigar	Processed 3642646 records
INFO	2019-04-17 11:59:35	MarkDuplicatesWithMateCigar	Found 0 records with no mate cigar optional tag.
INFO	2019-04-17 11:59:35	MarkDuplicatesWithMateCigar	Marking 196122 records as duplicates.
INFO	2019-04-17 11:59:35	MarkDuplicatesWithMateCigar	Found 9913 optical duplicate clusters.
[Wed Apr 17 11:59:35 EDT 2019] picard.sam.markduplicates.MarkDuplicatesWithMateCigar done. Elapsed time: 0.86 minutes.
```
### Next is to remove those duplicates and Filter them out
```{R}
samtools view -@8 -h -F 0x100 -q 10 -F 0x400 EC_2md.bam | mawk '$6 !~/[8-9].[SH]/ && $6 !~ /[1-9][0-9].[SH]/'| samtools view -@8 -b > EC_2.F.bam
samtools view -@8 -h -F 0x100 -q 10 -F 0x400 EC_4md.bam | mawk '$6 !~/[8-9].[SH]/ && $6 !~ /[1-9][0-9].[SH]/'| samtools view -@8 -b > EC_4.F.bam
samtools view -@8 -h -F 0x100 -q 10 -F 0x400 EC_7md.bam | mawk '$6 !~/[8-9].[SH]/ && $6 !~ /[1-9][0-9].[SH]/'| samtools view -@8 -b > EC_7.F.bam
```

### Now we can check to make sure we have filtered out reads
```
(EecSeq) [etakyi@KITT EecSeq]$ paste <(samtools view -c EC_2md.bam) <(samtools view -c EC_2.F.bam )
4452400	4046460
(EecSeq) [etakyi@KITT EecSeq]$ paste <(samtools view -c EC_4md.bam) <(samtools view -c EC_4.F.bam )
3640300	3287915
paste <(samtools view -c EC_7md.bam) <(samtools view -c EC_7.F.bam )
3642646	3316261
```
### next will be to calculate the depth per bp along the reference.
```
(EecSeq) [etakyi@KITT EecSeq]$ samtools depth -aa EC_2.F.bam > EC_2.genome.depth
(EecSeq) [etakyi@KITT EecSeq]$
(EecSeq) [etakyi@KITT EecSeq]$ samtools depth -aa EC_4.F.bam > EC_4.genome.depth
(EecSeq) [etakyi@KITT EecSeq]$ samtools depth -aa EC_7.F.bam > EC_7.genome.depth
```
#### Use head to view a subset of each depth

#### coverage across a heat shock protein to see if we are indeed enriching for targets that we expect to be expressed.
```
(EecSeq) [etakyi@KITT EecSeq]$ mawk '$2 > 32736205 && $2 < 32866205' EC_2.genome.depth > EC_2.graph.depth
(EecSeq) [etakyi@KITT EecSeq]$ mawk '$2 > 32736205 && $2 < 32866205' EC_4.genome.depth > EC_4.graph.depth
(EecSeq) [etakyi@KITT EecSeq]$ mawk '$2 > 32736205 && $2 < 32866205' EC_7.genome.depth > EC_7.graph.depth
```
```
(EecSeq) [etakyi@KITT EecSeq]$ echo -e "Contig\tbp\tDepth\tSample" > header
(EecSeq) [etakyi@KITT EecSeq]$ less EC_2.graph.depth
(EecSeq) [etakyi@KITT EecSeq]$ cat header EC_*.graph.depth > TotalCov.txt
(EecSeq) [etakyi@KITT EecSeq]$ less TotalCov.txt
(EecSeq) [etakyi@KITT EecSeq]$ tail -n 5 TotalCov.txt
NC_035780.1	32866200	10	EC_7
NC_035780.1	32866201	10	EC_7
NC_035780.1	32866202	10	EC_7
NC_035780.1	32866203	10	EC_7
NC_035780.1	32866204	9	EC_7
 ```
 ```
(EecSeq) [etakyi@KITT EecSeq]$ mawk '$4 > 32736205' ref_C_virginica-3.0_top_level.CHR_1.gff3 | mawk '$5 < 32866205' | mawk '$3 == "exon"' | cut -f1,4,5,9 | uniq -w 30 | sed 's/ID=.*product=//g' | sed 's/;trans.*//g' | sed 's/%.*//g' > exons
(EecSeq) [etakyi@KITT EecSeq]$ cat <(echo -e "Contig\tStart\tEnd\tTreatment") exons > exon.list
(EecSeq) [etakyi@KITT EecSeq]$ cat exon.list
Contig	Start	End	Treatment
NC_035780.1	32741431	32741575	heat shock cognate 71 kDa protein
NC_035780.1	32741899	32742110	heat shock cognate 71 kDa protein
NC_035780.1	32742228	32742433	heat shock cognate 71 kDa protein
NC_035780.1	32742518	32742685	heat shock cognate 71 kDa protein
NC_035780.1	32742821	32743373	heat shock cognate 71 kDa protein
NC_035780.1	32743482	32743883	heat shock cognate 71 kDa protein
NC_035780.1	32744103	32744660	heat shock cognate 71 kDa protein
NC_035780.1	32772962	32773125	glucose-induced degradation protein 8 homolog
NC_035780.1	32753391	32753533	glucose-induced degradation protein 8 homolog
NC_035780.1	32752046	32752242	glucose-induced degradation protein 8 homolog
NC_035780.1	32748977	32749174	glucose-induced degradation protein 8 homolog
NC_035780.1	32746900	32747422	glucose-induced degradation protein 8 homolog
NC_035780.1	32753941	32754148	glucose-induced degradation protein 8 homolog
NC_035780.1	32753391	32753533	glucose-induced degradation protein 8 homolog
NC_035780.1	32752046	32752242	glucose-induced degradation protein 8 homolog
NC_035780.1	32748977	32749174	glucose-induced degradation protein 8 homolog
NC_035780.1	32746900	32747422	glucose-induced degradation protein 8 homolog
NC_035780.1	32754200	32754469	rho GTPase-activating protein 39-like
NC_035780.1	3
```
```
(EecSeq) [etakyi@KITT EecSeq]$ mawk '$4 > 32736205' ref_C_virginica-3.0_top_level.CHR_1.gff3 | mawk '$5 < 32866205' | mawk '$3 == "mRNA"' | cut -f1,4,5,9 | uniq -w 30 | sed 's/ID=.*product=//g' | sed 's/;trans.*//g' | sed 's/%.*//g' > genes
(EecSeq) [etakyi@KITT EecSeq]$ cat <(echo -e "Contig\tStart\tEnd\tTreatment") genes > genes.list
(EecSeq) [etakyi@KITT EecSeq]$ head  genes.list
Contig	Start	End	Treatment
NC_035780.1	32741431	32744660	heat shock cognate 71 kDa protein
NC_035780.1	32746900	32773125	glucose-induced degradation protein 8 homolog
NC_035780.1	32746900	32754148	glucose-induced degradation protein 8 homolog
NC_035780.1	32754200	32800756	rho GTPase-activating protein 39-like
NC_035780.1	32760682	32800756	rho GTPase-activating protein 39-like
NC_035780.1	32764085	32800756	rho GTPase-activating protein 39-like
NC_035780.1	32769864	32800756	rho GTPase-activating protein 39-like
NC_035780.1	32774894	32800756	rho GTPase-activating protein 39-like
NC_035780.1	32780043	32800756	rho GTPase-activating protein 39-like
```
```
(EecSeq) [etakyi@KITT EecSeq]$ mawk '$4 > 32736205' ref_C_virginica-3.0_top_level.CHR_1.gff3 | mawk '$5 < 32866205' | mawk '$3 == "CDS"' | cut -f1,4,5,9 | uniq -w 30 | sed 's/ID=.*product=//g' | sed 's/;trans.*//g' | sed 's/%.*//g' > CDS
(EecSeq) [etakyi@KITT EecSeq]$ cat <(echo -e "Contig\tStart\tEnd\tTreatment") CDS > CDS.list
(EecSeq) [etakyi@KITT EecSeq]$ head CDS.list
Contig	Start	End	Treatment
NC_035780.1	32741903	32742110	heat shock cognate 71 kDa protein;protein_id=XP_022328101.1
NC_035780.1	32742228	32742433	heat shock cognate 71 kDa protein;protein_id=XP_022328101.1
NC_035780.1	32742518	32742685	heat shock cognate 71 kDa protein;protein_id=XP_022328101.1
NC_035780.1	32742821	32743373	heat shock cognate 71 kDa protein;protein_id=XP_022328101.1
NC_035780.1	32743482	32743883	heat shock cognate 71 kDa protein;protein_id=XP_022328101.1
NC_035780.1	32744103	32744548	heat shock cognate 71 kDa protein;protein_id=XP_022328101.1
NC_035780.1	32753391	32753529	glucose-induced degradation protein 8 homolog;protein_id=XP_022342518.1
NC_035780.1	32752046	32752242	glucose-induced degradation protein 8 homolog;protein_id=XP_022342518.1
NC_035780.1	32748977	32749174	glucose-induced degradation protein 8 homolog;protein_id=XP_022342518.1
```
### Information from the RNAseq reads of our probe sequences.
```
echo -e "Contig\tbp\tDepth\tSample" > header
cat header *.exon.cov.stats > TotalRNACov.txt
```
### Expression of the HSP and other genes are plotted in R using both the exome capture and RNA dataset
```{R}
library(ggplot2)
library(grid)
library(plyr)
library(dplyr)
library(scales)
library(zoo)
```
```{r}
cbPalette <- c("#D55E00", "#009E73", "#56B4E9" ,"#0072B2" ,"#E69F00" ,"#F0E442" ,"#999999" ,"#CC79A7","#7570B3")
DepC <- read.table("TotalCov.txt", header = TRUE)
DepR <- read.table("TotalRNACov.txt", header = TRUE)
```
```{r}
DepC <- as.data.frame(DepC)
DepC$Sample <- factor(DepC$Sample,levels=c("EC_2","EC_4","EC_7"))
DepR <- as.data.frame(DepR)
DepR$Sample <- factor(DepR$Sample,levels=c("RNA_1","RNA_2","RNA_3","RNA_4"))
```

```{r}
exons <- read.table("exon.list", header = TRUE, sep = "\t")
exons <- as.data.frame(exons)

genes <- read.table("genes.list", header = TRUE, sep = "\t")
genes <- as.data.frame(genes)

cds <- read.table("CDS.list", header = TRUE, sep = "\t")
cds <- as.data.frame(cds)
```
```{r}
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

```{r}
redcol <-"#940000"
cbPalettedd <- c( "#009E73","#D55E00", "#E69F00")
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

![plot1](http://kitt.uri.edu:8787/s/2476ecfc78a3130e14416/files/Week11/EecSeq/EecSeq_Figure.png)
