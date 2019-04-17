## Calling of SNPs with ddocent

(base) [etakyi@KITT Exercises]$ mkdir Week78
(base) [etakyi@KITT Exercises]$ cd Week78/
(base) [etakyi@KITT Week78]$ ls
(base) [etakyi@KITT Week78]$ mkdir simulated
(base) [etakyi@KITT Week78]$ cd simulated/
(base) [etakyi@KITT simulated]$ ln -s /home/BIO594/Exercises/Week07_and_Week_08/simulated/* .
(base) [etakyi@KITT simulated]$ ls

#### To activate this environment, use
####  $ conda activate Week78
#### To deactivate an active environment, use
#### $ conda deactivate

```
(base) [etakyi@KITT simulated]$ conda activate Week78
(Week78) [etakyi@KITT simulated]$ dDocent
dDocent 2.7.7

Contact jpuritz@uri.edu with any problems


Checking for required software

All required software is installed!

dDocent run started Fri Apr 12 14:17:34 EDT 2019

80 individuals are detected. Is this correct? Enter yes or no and press [ENTER]
yes
Proceeding with 80 individuals
dDocent detects 80 processors available on this system.
Please enter the maximum number of processors to use for this analysis.
80
dDocent detects 503 gigabytes of maximum memory available on this system.
Please enter the maximum memory to use for this analysis in gigabytes
For example, to limit dDocent to ten gigabytes, enter 10
This option does not work with all distributions of Linux.  If runs are hanging at variant calling, enter 0
Then press [ENTER]
450

Do you want to quality trim your reads?
Type yes or no and press [ENTER]?
yes

Do you want to perform an assembly?
Type yes or no and press [ENTER].
no

Reference contigs need to be in a file named reference.fasta

Do you want to map reads?  Type yes or no and press [ENTER]
yes
BWA will be used to map reads.  You may need to adjust -A -B and -O parameters for your taxa.
Would you like to enter a new parameters now? Type yes or no and press [ENTER]
no
Proceeding with default values for BWA read mapping.
Do you want to use FreeBayes to call SNPs?  Please type yes or no and press [ENTER]
yes

Please enter your email address.  dDocent will email you when it is finished running.
Don't worry; dDocent has no financial need to sell your email address to spammers.
evelyn-takyi@my.uri.edu


At this point, all configuration information has been entered and dDocent may take several hours to run.
It is recommended that you move this script to a background operation and disable terminal input and output.
All data and logfiles will still be recorded.
To do this:
Press control and Z simultaneously
Type 'bg' without the quotes and press enter
Type 'disown -h' again without the quotes and press enter

Now sit back, relax, and wait for your analysis to finish

Trimming reads

Using BWA to map reads
Using BWA to map reads

Creating alignment intervals

Using FreeBayes to call SNPs
/home/etakyi/miniconda3/envs/Week78/bin/dDocent: line 434: popmap: Permission denied
100% 79:0=0s 67
/home/etakyi/miniconda3/envs/Week78/bin/dDocent: line 603: TotalRawSNPs.vcf: Permission denied

Using VCFtools to parse TotalRawSNPS.vcf for SNPs that are called in at least 90% of individuals
```

## Filtering Raw SNPS
```
(Week78) [etakyi@KITT simulated]$ vcftools --vcf TotalRawSNPs.vcf --max-missing 0.5 --maf 0.01 --minQ 20 --recode --recode-INFO-all --out TRS
After filtering, kept 80 out of 80 Individuals
O
After filtering, kept 2312 out of a possible 3025 Sites
Run Time = 2.00 seconds
(Week78) [etakyi@KITT simulated]$ vcftools --vcf TRS.recode.vcf --minDP 5 --recode --recode-INFO-all --out TRSdp5

After filtering, kept 80 out of 80 Individuals
After filtering, kept 2312 out of a possible 2312 Sites
(Week78) [etakyi@KITT simulated]$ pop_missing_filter.sh TRSdp5.recode.vcf popmap 0.05 1 TRSdp5p05
After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 2168 out of a possible 2312 Sites

(Week78) [etakyi@KITT simulated]$ dDocent_filters TRSdp5p05.recode.vcf TRSdp5p05
This script will automatically filter a FreeBayes generated VCF file using criteria related to site depth,
quality versus depth, strand representation, allelic balance at heterzygous individuals, and paired read representation.
The script assumes that loci and individuals with low call rates (or depth) have already been removed.

Contact Jon Puritz (jpuritz@gmail.com) for questions and see script comments for more details on particular filters

Number of sites filtered based on allele balance at heterozygous loci, locus quality, and mapping quality / Depth
 87 of 2168

Are reads expected to overlap?  In other words, is fragment size less than 2X the read length?  Enter yes or no.
no
Number of additional sites filtered based on overlapping forward and reverse reads
 0 of 2081

Is this from a mixture of SE and PE libraries? Enter yes or no.
no
Number of additional sites filtered based on properly paired status
 0 of 2081

Number of sites filtered based on high depth and lower than 2*DEPTH quality score
 167 of 2081



                                               Histogram of mean depth per site

      250 +---------------------------------------------------------------------------------------------------------+
          |   +    +    +    +     +    +    +     +    +    +     +    +    +    +     +    +    +     +    +    + |
          |                                               'meandepthpersite' using (bin($1,binwid**)):(1.0) ******* |
          |                                                                                    ****                 |
          |                                                                                    * **                 |
      200 |-+                                                                                *** ****             +-|
          |                                                                                *** * ** *               |
          |                                                                                * * * ** *               |
          |                                                                                * * * ** *               |
      150 |-+                                                                              * * * ** ***           +-|
          |                                                                               ** * * ** * *             |
          |                                                                             **** * * ** * ***           |
          |                                                                             * ** * * ** * * *           |
          |                                                                             * ** * * ** * * *           |
      100 |-+                                                                           * ** * * ** * * *         +-|
          |                                                                             * ** * * ** * * *           |
          |                                                                             * ** * * ** * * *           |
          |                                                                             * ** * * ** * * *           |
       50 |-+                                                                       ***** ** * * ** * * *         +-|
          |                                                                       *** * * ** * * ** * * ****        |
          |                                                                       * * * * ** * * ** * * ** ***      |
          |                                                                      ** * * * ** * * ** * * ** * ***    |
          |   +    +    +    +     +    +    +     +    +    +     +    +    + **** * * * ** * * ** * * ** * * ** + |
        0 +---------------------------------------------------------------------------------------------------------+
              12   15   18   21    24   27   30    33   36   39    42   45   48   51    54   57   60    63   66   69
                                                          Mean Depth

If distrubtion looks normal, a 1.645 sigma cutoff (~90% of the data) would be 5174.048195
The 95% cutoff would be 64
Would you like to use a different maximum mean depth cutoff than 64, yes or no
no
Number of sites filtered based on maximum mean depth
 217 of 2081

Number of sites filtered based on within locus depth mismatch
 0 of 1820

Total number of sites filtered
 348 of 2168

Remaining sites
 1820

Filtered VCF file is called Output_prefix.FIL.recode.vcf

Filter stats stored in TRSdp5p05.filterstats
(Week78) [etakyi@KITT simulated]$ vcfallelicprimitives -k -g TRSdp5p05.FIL.recode.vcf |sed 's:\.|\.:\.\/\.:g' > TRSdp5p05F.prim
(Week78) [etakyi@KITT simulated]$ vcftools --vcf TRSdp5p05F.prim --recode --recode-INFO-all --remove-indels --out SNP.TRSdp5p05F
After filtering, kept 80 out of 80 Individuals
After filtering, kept 1562 out of a possible 1940 Sites

(Week78) [etakyi@KITT simulated]$ filter_hwe_by_pop.pl -v SNP.TRSdp5p05F.recode.vcf -p popmap -c 0.5 -out SNP.TRSdp5p05FHWE
Processing population: PopA (20 inds)
Processing population: PopB (20 inds)
Processing population: PopC (20 inds)
Processing population: PopD (20 inds)
Outputting results of HWE test for filtered loci to 'filtered.hwe'
Kept 1562 of a possible 1562 loci (filtered 0 loci)

(Week78) [etakyi@KITT simulated]$ vcftools --vcf SNP.TRSdp5p05FHWE.recode.vcf --maf 0.05 --recode --recode-INFO-all --out SNP.TRSdp5p05FHWEmaf05
After filtering, kept 848 out of a possible 1562 Sites
### Final filtered
(Week78) [etakyi@KITT simulated]$ mawk '!/#/' Final_filtered.recode.vcf | wc -l
848
```
#### Run outlier detection program
#### Convert to bayescan outputfile
```
(Week78) [etakyi@KITT simulated]$ java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.TRSdp5p05FHWEmaf05.recode.vcf -outputfile SNP.TRSdp5p05FHWEBS -spid BSsnp.spid
WARN  14:38:47 - PGDSpider configuration file not found! Loading default configuration.
initialize convert process...
read input file...
read input file done.
write output file...
write output file done.
(Week78) [etakyi@KITT simulated]$ BayeScan2.1_linux64bits SNP.TRSdp5p05FHWEBS -nbp 30 -thin 20 > bs.log
^Z
[1]+  Stopped                 BayeScan2.1_linux64bits SNP.TRSdp5p05FHWEBS -nbp 30 -thin 20 > bs.log
(Week78) [etakyi@KITT simulated]$ bg
[1]+ BayeScan2.1_linux64bits SNP.TRSdp5p05FHWEBS -nbp 30 -thin 20 > bs.log &
(Week78) [etakyi@KITT simulated]$ disown -a
R
> source("plot_R.r")
> plot_bayescan("SNP.TRSdp5p05FH_fst.txt")
$outliers
[1] 586 587
```
![plot1](https://github.com/jpuritz/BIO_594_2019/blob/master/Exercises/Week07andWeek08/EvelynW7%268/Simulated/bayescan.png)

### Uisng PCAAdapt
### First convert filtered SNP to include loci that has only two alleles.
(Week78) [etakyi@KITT simulated]$ vcftools --vcf Final_filtered.recode.vcf --max-alleles 2 --recode --recode-INFO-all --out SNP.TRSdp5p05FHWE2A
After filtering, kept 80 out of 80 Individuals
After filtering, kept 845 out of a possible 848 Sites
#### Go to R studio to run PCAdapt
```{R}
library(pcadapt)
library(vcfR)
library(adegenet)
```
```{R}
filename1 <- read.pcadapt("SNP.TRSdp5p05FHWE2A.recode.vcf", type = "vcf")
x <- pcadapt(input = filename1, K = 10)
plot(x, option = "screeplot", K = 10)
poplist.names <- c(rep("POPA", 20),rep("POPB", 20),rep("POPC", 20), rep("POPD",20))
plot(x, option = "scores", pop = poplist.names)
plot(x, option = "scores", i = 2, j = 3, pop = poplist.names)
plot(x, option = "scores", i = 3, j = 4, pop = poplist.names)
plot(x, option = "scores", i = 2, j = 3, pop = poplist.names)
x <- pcadapt(filename1, K = 3)
```

```{R}
library(qvalue)
qval <- qvalue(x$pvalues)$qvalues
alpha <- 0.1
outliers <- which (qval < alpha)
length(outliers)
outliers
[1] 132 133
```
![plot2](https://github.com/jpuritz/BIO_594_2019/blob/master/Exercises/Week07andWeek08/EvelynW7%268/Simulated/pcadapt.png)

#### To remove outliers from the vcf file
```
(Week78) [etakyi@KITT simulated]$ paste <(seq 1 845) <( mawk '!/#/' Final_filtered.recode.vcf | cut -f1,2)
```
##### create a text file called positions using nano of the outliers you want to remove
##### remove outliers using VCFtools
```
vcftools --vcf Final_filtered.recode.vcf  --exclude-positions positions  --recode-INFO-all --recode --out SNP_neutral
```
#### Analyse the neutral file using R Packages
#### PCA
```
my_vcf <- read.vcfR("SNP_neutral.recode.vcf")
my_genind <- vcfR2genind(my_vcf)
strata<- read.table("popmap-copy", header=TRUE)
strata_df <- data.frame(strata)
strata(my_genind) <- strata_df
setPop(my_genind) <- ~Population
X <- tab(my_genind, freq = TRUE, NA.method = "mean")
pca1 <- dudi.pca(X, scale = FALSE, scannf = FALSE, nf = 3)
barplot(pca1$eig[1:50], main = "PCA eigenvalues", col = heat.colors(50))
s.class(pca1$li, pop(my_genind))
title("PCA of simulated dataset\naxes 1-2")
add.scatter.eig(pca1$eig[1:20], 3,1,2)
col <- funky(15)
s.class(pca1$li, pop(my_genind),xax=1,yax=2, col=col, axesell=FALSE, cstar=0, cpoint=3, grid=FALSE)
s.label(pca1$li)
```
![plot3](https://github.com/jpuritz/BIO_594_2019/blob/master/Exercises/Week07andWeek08/EvelynW7%268/Simulated/PCA.png)

#### Run DAPC
```
grp <- find.clusters(my_genind, max.n.clust = 40)
table(pop(my_genind), grp$grp)
dapc1 <- dapc(my_genind, grp$grp, n.pca = 20, n.da = 4)
scatter(dapc1) # plot of the group

set.seed(20160308) # Setting a seed for a consistent result
grp <- find.clusters(my_genind, max.n.clust = 10, n.pca = 20, choose.n.clust = FALSE)
names(grp)
grp$grp
dapc1 <- dapc(my_genind, grp$grp, n.pca = 20, n.da = 6)
scatter(dapc1) # plot of the group
```
![plot4](https://github.com/jpuritz/BIO_594_2019/blob/master/Exercises/Week07andWeek08/EvelynW7%268/Simulated/DAPC.png)

#### Two analysis from Silliman paper
#### Basic statistics
```{R}
basicstat <- basic.stats(my_genind, diploid = TRUE, digits = 3)
as.data.frame(basicstat$overall)
boot <- boot.ppfis(my_genind,nboot = 1000)
colnames(basicstat$Ho) <- pop_order
Ho <- colMeans(basicstat$Ho,na.rm = T)
He <- colMeans(basicstat$Hs,na.rm = T)
n.ind.samp <- colMeans(basicstat$n.ind.samp)
Fis<- boot$fis.ci$ll
x <- cbind(n.ind.samp,Ho,He,Fis)
x
```
#### Plot of expected heterozygosity to observed heterozygosity
```{R}
comb <- summary(my_genind)
names(comb)
plot(comb$Hobs, xlab="Loci number", ylab="Observed Heterozygosity",
     main="Observed heterozygosity per locus")
plot(comb$Hobs,comb$Hexp, xlab="Hobs", ylab="Hexp",
     main="Expected heterozygosity as a function of observed heterozygosity per locus")
bartlett.test(list(comb$Hexp, comb$Hobs)) # a test : H0: Hexp = Hobs
```
![plot5](https://github.com/jpuritz/BIO_594_2019/blob/master/Exercises/Week07andWeek08/EvelynW7%268/Simulated/Basicstats.png)

#### Pairwise FST
```{r}
gindF.fst.mat <- pairwise.fst(my_genind, pop = strata(my_genind)$Population,res.type = "matrix")
gindF.fst.mat
reg_names = c("PopA","PopB","PopC","PopD")
colnames(gindF.fst.mat)<- reg_names
rownames(gindF.fst.mat)<- reg_names
gindF.fst.mat.tri <- gindF.fst.mat
gindF.fst.mat.tri[lower.tri(gindF.fst.mat, diag=TRUE)] <- NA
melted <- melt(gindF.fst.mat, na.rm =TRUE)
par(mfrow=c(2,1))
ggplot(data = melted, aes(Var2, Var1, fill = value))+ geom_tile(color = "white")+
  scale_fill_gradient(low = "white", high = "red", name="FST")  +
  ggtitle(expression(atop("Pairwise FST, WC (1984)", atop(italic("N = 137, L = 9,170"), ""))))+
  labs( x = "Sampling Site", y = "Sampling Site") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 6, hjust = 1),axis.text.y = element_text(size = 10)) +
  coord_fixed()
```
![plot6](https://github.com/jpuritz/BIO_594_2019/blob/master/Exercises/Week07andWeek08/EvelynW7%268/Simulated/FST.png)
