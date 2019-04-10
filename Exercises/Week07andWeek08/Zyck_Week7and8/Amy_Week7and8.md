# Zyck Week8and9 Exercise
****

## Simulated Dataset

### Calling SNPs

Create environment
```javascript
conda create -n Week7and8 ddocent

conda activate Week7and8
```
Create working directory and link to the data
```javascript
mkdir Week7and8
cd Week7and8
ln -s /home/BIO594/Exercises/Week07_and_Week_08/* .
```

Moved into simulated directory
```javascript
cd simulated
```

Start dDocent
```javascript
dDocent
```

Used these settings:
```javascript
Number of Processors
80
Maximum Memory
0
Trimming
yes
Assembly?
yes
Type_of_Assembly
PE
Clustering_Similarity%
0.9
Mapping_Reads?
yes
Mapping_Match_Value
1
Mapping_MisMatch_Value
4
Mapping_GapOpen_Penalty
6
Calling_SNPs?
yes
Email
```
Use 6 for K1 and 5 for K2 during assembly

### Filtering SNPs
```javascript
mkdir Filter
cd Filter/

#make symbolic link to dDocent output in parent directory
ln -s ../TotalRawSNPs.vcf .

#filter out loci with missing data, alleles with low freq, and alleles with low quality scores
vcftools --vcf TotalRawSNPs.vcf --max-missing 0.5 --maf 0.001 --minQ 20 --recode --recode-INFO-all --out TRS
```
Output (minus all warning messages):
```javascript
VCFtools - 0.1.16
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf TotalRawSNPs.vcf
        --recode-INFO-all
        --maf 0.001
        --minQ 20
        --max-missing 0.5
        --out TRS
        --recode

After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 2993 out of a possible 3025 Sites
Run Time = 1.00 seconds
```
Command:
```javascript
#filter out loci with low depth
vcftools --vcf TRS.recode.vcf --minDP 5 --recode --recode-INFO-all --out TRSdp5
```

Output (minus all warning messages):
```javascript
VCFtools - 0.1.16
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf TRS.recode.vcf
        --recode-INFO-all
        --minDP 5
        --out TRSdp5
        --recode

After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 2993 out of a possible 2993 Sites
Run Time = 1.00 seconds
```

Command:
```javascript
pop_missing_filter.sh TRSdp5.recode.vcf ../popmap 0.05 1 TRSdp5p05
```

Output:
```javascript
After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 2816 out of a possible 2993 Sites
Run Time = 2.00 seconds
```

Command:
```javascript
#filter out loci with poor allelic balance, off kilter mapping quality ratios among alleles, and more
dDocent_filters TRSdp5p05.recode.vcf TRSdp5p05
```

Output:
```javascript
This script will automatically filter a FreeBayes generated VCF file using criteria related to site depth,
quality versus depth, strand representation, allelic balance at heterzygous individuals, and paired read representation.
The script assumes that loci and individuals with low call rates (or depth) have already been removed.
Contact Jon Puritz (jpuritz@gmail.com) for questions and see script comments for more details on particular filters
Number of sites filtered based on allele balance at heterozygous loci, locus quality, and mapping quality / Depth
 394 of 2816
Are reads expected to overlap?  In other words, is fragment size less than 2X the read length?  Enter yes or no.
  No
Number of additional sites filtered based on overlapping forward and reverse reads
  0 of 2422
Is this from a mixture of SE and PE libraries? Enter yes or no.
  No
Number of additional sites filtered based on properly paired status.
  0 of 2422
Number of sites filtered based on high depth and lower than 2*DEPTH quality score
  277 of 2422

If distrubtion looks normal, a 1.645 sigma cutoff (~90% of the data) would be 5171.64712
The 95% cutoff would be 64
Would you like to use a different maximum mean depth cutoff than 64, yes or no
  yes
Please enter new cutoff
  75
Number of sites filtered based on maximum mean depth
  0 of 2422

Number of sites filtered based on within locus depth mismatch
  0 of 2208

Total number of sites filtered
  608 of 2816

Remaining sites
  2208

Filtered VCF file is called Output_prefix.FIL.recode.vcf

Filter stats stored in TRSdp5p05.filterstats
```
Commands:
```javascript
vcfallelicprimitives -k -g TRSdp5p05.FIL.recode.vcf |sed 's:\.|\.:\.\/\.:g' > TRSdp5p05F.prim

#remove indels
vcftools --vcf TRSdp5p05F.prim --recode --recode-INFO-all --remove-indels --out SNP.TRSdp5p05F
```

Output:
```javascript
After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 1918 out of a possible 2364 Sites
Run Time = 1.00 seconds
```

Command:
```javascript
#filter via HWE
filter_hwe_by_pop.pl -v SNP.TRSdp5p05F.recode.vcf -p ../popmap -c 0.5 -out SNP.TRSdp5p05FHWE
```

Output:
```javascript
Processing population: PopA (20 inds)
Processing population: PopB (20 inds)
Processing population: PopC (20 inds)
Processing population: PopD (20 inds)
Outputting results of HWE test for filtered loci to 'filtered.hwe'
Kept 1918 of a possible 1918 loci (filtered 0 loci)
```

Command:
```javascript
#filter out low maf loci
vcftools --vcf SNP.TRSdp5p05FHWE.recode.vcf --maf 0.05 --recode --recode-INFO-all --out SNP.TRSdp5p05FHWEmaf05
```

Output:
```javascript
VCFtools - 0.1.16
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf SNP.TRSdp5p05FHWE.recode.vcf
        --recode-INFO-all
        --maf 0.05
        --out SNP.TRSdp5p05FHWEmaf05
        --recode

After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 943 out of a possible 1731 Sites
```

### Converting from VCF to other outputs
```javascript
#Copy a PGDspider configuration file and file to map individuals to population
cp ../BSsnp.spid .
ln -s ../popmap

#Now, run PGDspider
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.TRSdp5p05FHWEmaf05.recode.vcf -outputfile SNP.TRSdp5p05FHWEBS -spid BSsnp.spid
```

Output:
```javascript
WARN  20:14:46 - PGDSpider configuration file not found! Loading default configuration.
initialize convert process...
read input file...
read input file done.
write output file...
write output file done.
```

### Outlier Detection
```javascript
#Run BayeScan
BayeScan2.1_linux64bits SNP.TRSdp5p05FHWEBS -nbp 30 -thin 20

#Copy R source file
cp ../plot_R.r .
```

#### In Rstudio
```javascript
source("plot_R.r")
plot_bayescan("SNP.TRSdp5p05FH_fst.txt")
```

### More outlier Detection
For all other analyses, we need to limit SNPs to only those with two alleles:
```javascript
vcftools --vcf SNP.TRSdp5p05FHWEmaf05.recode.vcf --max-alleles 2 --recode --recode-INFO-all --out SNP.TRSdp5p05FHWE2A
```

Output:
```javascript
VCFtools - 0.1.16
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf SNP.TRSdp5p05FHWEmaf05.recode.vcf
        --recode-INFO-all
        --max-alleles 2
        --out SNP.TRSdp5p05FHWE2A
        --recode

After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 940 out of a possible 943 Sites
```
### PCAdapt
#### In RStudio
```javascript
#Load pcadapt library
library(pcadapt)

#load our VCF file into R
filename <- read.pcadapt("SNP.TRSdp5p05FHWE2A.recode.vcf", type = "vcf" )

#Create first PCA
x <- pcadapt(input = filename, K = 10)

#Plot the likelihoods
plot(x, option = "screeplot")

#Create population designations
x <- pcadapt(input= filename, K=2)
poplist.names <- c(rep("POPA", 20),rep("POPB", 20),rep("POPC", 20), rep("POPD",20))

#Plot the actual PCA (first two PCAs)
plot(x, option = "scores", pop=poplist.names)
#Start looking for outliers
#Make Manhattan Plot
plot(x , option = "manhattan")
#Make qqplot
plot(x, option = "qqplot", threshold = 0.1)
# Look at P-value distribution
plot(x, option = "stat.distribution")

# Set FDR
library(qvalue)
qval <- qvalue(x$pvalues)$qvalues
alpha <- 0.1

# Save outliers
outliers <- which(qval < alpha)
outliers


# Testing for library effects

poplist.names <- c(rep("LIB1", 40),rep("LIB2", 40))
x <- pcadapt(input = filename, K = 20)

plot(x, option = "scores", pop = poplist.names)
plot(x, option = "scores", i = 2, j = 3, pop = poplist.names)

x <- pcadapt(filename, K = 2)

summary(x)

plot(x , option = "manhattan")
plot(x, option = "qqplot", threshold = 0.1)

plot(x, option = "stat.distribution")

library(qvalue)
qval <- qvalue(x$pvalues)$qvalues
alpha <- 0.1
outliers <- which(qval < alpha)
```
### Generate a VCF file with only neutral SNPs

Determining dDocent_contig_# and position #
```javascript
less +182 -N SNP.TRSdp5p05FHWEmaf05.recode.vcf
	dDocent_Contig_70	73

less +295 -N SNP.TRSdp5p05FHWEmaf05.recode.vcf
	dDocent_Contig_171	158

less +296 -N SNP.TRSdp5p05FHWEmaf05.recode.vcf
	dDocent_Contig_172	62

less +651 -N SNP.TRSdp5p05FHWEmaf05.recode.vcf
	dDocent_Contig_490	150

less +652 -N SNP.TRSdp5p05FHWEmaf05.recode.vcf
	dDocent_Contig_491	34

less +147 -N SNP.TRSdp5p05FHWE2A.recode.vcf
	dDocent_Contig_50	161

less +148 -N SNP.TRSdp5p05FHWE2A.recode.vcf
	dDocent_Contig_51	205
```

Create nano file with Outlier loci
```javascript
nano Outlier
  dDocent_Contig_70	  73
  dDocent_Contig_171	 158
  dDocent_Contig_172	 62
  dDocent_Contig_490	 150
  dDocent_Contig_491	 34
  dDocent_Contig_50	  161
  dDocent_Contig_51	  205
```
Create .vcf file with only neutral loci
```javascript
vcftools --vcf SNP.TRSdp5p05FHWEmaf05.recode.vcf --exclude-positions Outlier --recode --recode-INFO-all --out SNP.TRSdp5p05FHWEmaf05_neutral
```

Output:
```javascript
VCFtools - 0.1.17
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf SNP.TRSdp5p05FHWEmaf05.recode.vcf
        --exclude-positions Outlier
        --recode-INFO-all
        --out SNP.TRSdp5p05FHWEmaf05_neurtal
        --recode

After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 936 out of a possible 943 Sites
```

### RUN PCA ON NEUTRAL SNPs

#### In RStudio
```javascript
library(adegenet)
library(vcfR)

my_vcf <- read.vcfR("SNP.TRSdp5p05FHWEmaf05_neutral.recode.vcf")
my_genind <- vcfR2genind(my_vcf)

strata<- read.table("LibraryInfo", header=TRUE)
strata_df <- data.frame(strata)
strata(my_genind) <- strata_df

setPop(my_genind) <- ~Population

#Test Population Structure
library("hierfstat")
fstat(my_genind)

matFst <- pairwise.fst(my_genind)


#PCA

X <- tab(my_genind, freq = TRUE, NA.method = "mean")
pca1 <- dudi.pca(X, scale = FALSE, scannf = FALSE, nf = 3)
barplot(pca1$eig[1:50], main = "PCA eigenvalues", col = heat.colors(50))
s.class(pca1$li, pop(my_genind))
title("PCA of simulated dataset\naxes 1-2")
add.scatter.eig(pca1$eig[1:20], 3,1,2)

col <- funky(15)
s.class(pca1$li, pop(my_genind),xax=1,yax=2, col=col, axesell=FALSE, cstar=0, cpoint=3, grid=FALSE)
```
### RUN DAPC ON NEUTRAL SNPs

#### In RStudio
```javascript
grp <- find.clusters(my_genind, max.n.clust=40)
table(pop(my_genind), grp$grp)

table.value(table(pop(my_genind), grp$grp), col.lab=paste("inf", 1:2), row.lab=paste("ori", 1:4))

dapc1 <- dapc(my_genind, grp$grp)
scatter(dapc1,col=col,bg="white", solid=1)

contrib <- loadingplot(dapc1$var.contr, axis=1, thres=.01, lab.jitter=1)
contrib

setPop(my_genind) <- ~Library

dapc1 <- dapc(my_genind, pop(my_genind))
contrib <- loadingplot(dapc1$var.contr, axis=1, thres = 0.05, lab.jitter = 1)
contrib
```

### Silliman's Analyses for Simulated Data

#### In RStudio
```javascript
#Loading all the necessary packages
library(ggplot2) #For plotting
library(reshape2) #For plotting
library(plyr)
library("cowplot") #For plotting manuscript figs


###Pairwise Fst

my_genind
fst.mat <- genet.dist(my_genind, method = "WC84")

#Providing population names for plotting
pop_order <- c("Pop1","Pop2","Pop3","Pop4")

meltedN <- melt(gindF.fst.mat.triN, na.rm =TRUE)
colnames(gindF.fst.mat.triN) <- pop_order
rownames(gindF.fst.mat.triN) <- pop_order

#Received an error here

#this should have produced a 4 x 4 matrix
round(gindF.fst.mat.triN,4)

#Plotting Pairwise fst
neutral <- ggplot(data = meltedN, aes(Var2, Var1, fill = value))+ geom_tile(color = "white")+
  scale_fill_gradient(low = "white", high = "red", name="FST")  +
  ggtitle(expression(atop("Pairwise FST, WC, Neutral", atop(italic("N = 117, L = 13,073"), ""))))+
  labs( x = "Sampling Site", y = "Sampling Site") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1),axis.text.y = element_text(size = 13)) +
  theme(axis.title = element_text(size = 16),legend.text = element_text(size =15), legend.title = element_text(size =16)) +
  theme(plot.title = element_text(size = 17)) +
coord_fixed()
neutral


###Genetic diversity (observed and expected heterozygosity)

#All populations
comb <- summary(my_genind)
names(comb)

plot(comb$Hobs, xlab="Loci number", ylab="Observed Heterozygosity",
     main="Observed heterozygosity per locus")


plot(comb$Hobs,comb$Hexp, xlab="Hobs", ylab="Hexp",
      main="Expected heterozygosity as a function of observed heterozygosity per locus")

bartlett.test(list(comb$Hexp, comb$Hobs)) # a test : H0: Hexp = Hobs

# calculate basic popgen statistics for the overall dataset
basicstat <- basic.stats(my_genind, digits = 3)

as.data.frame(basicstat$overall)

# get bootstrap confidence values for Fis
boot <- boot.ppfis(my_genind,nboot = 1000)
boot5 <- boot.ppfis(my_genind,nboot = 1000,quant = 0.5)

# add latitude for each population - just using the values from Silliman's study
# removed many to match out 4 x 4 matrix
latitude = c(50.298667,49.01585,49.011383,48.435667)

# combine all pop statistics
colnames(basicstat$Ho) <- pop_order
Ho <- colMeans(basicstat$Ho,na.rm = T)
He <- colMeans(basicstat$Hs,na.rm = T)
Fis<- boot5$fis.ci$ll
x <- cbind(Ho,He,Fis,boot$fis.ci,latitude)
# received an error here

#What is mean FIS across populations?
summary(Fis)

#Plot latitude agaiinst expected heterozygosity
R2 = round(summary(lm(x$He ~ x$latitude))$r.squared, 4)             

ggplot(x, aes(x = latitude, y = He)) + geom_point() +
geom_smooth(method=lm) +
ggtitle("Expected heterozygosity vs Latitude, Neutral") +
annotate(geom = "text", label=paste("italic(R^2)==",R2), x=45, y=0.25, parse=T) +
scale_x_reverse()
```

Unfortunately I received an error and could not complete the whole analysis. I still included the steps I would have done to complete the analyses. I will go back and attempt to resolve this error.


****
## Real Dataset

First need to remove SNPs with minor allele frequencies
```javascript
vcftools --vcf SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.recode.vcf --maf 0.05 --recode --recode-INFO-all --out SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF
```

### Convert from vcf to other outputs
```javascript
#Run PGDspider
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF.recode.vcf -outputfile SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF.BS -spid BSsnp.spid
```

Output:
```javascript
WARN  14:13:37 - PGDSpider configuration file not found! Loading default configuration.
initialize convert process...
read input file...
read input file done.
write output file...
write output file done.
```

### Run Bayescan
```javascript
BayeScan2.1_linux64bits SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF.BS -nbp 30 -thin 20
```

#### Open Rstudio
```javascript
source("plot_R.r")
plot_bayescan("SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MA _fst.txt", FDR = 0.1)
```
_1 Outlier detected_

### More outlier Detection
For all other analyses, we need to limit SNPs to only those with two alleles:
```javascript
vcftools --vcf SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF.recode.vcf --max-alleles 2 --recode --recode-INFO-all --out SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF.2A
```

Output
```javascript
VCFtools - 0.1.16
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.recode.vcf
        --recode-INFO-all
        --max-alleles 2
        --out SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF.2A
        --recode

After filtering, kept 384 out of 384 Individuals
Outputting VCF file...
After filtering, kept 4412 out of a possible 4447 Sites
```

### BayEnv2

Convert vcf to BayEnv input
```javascipt
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF.2A.recode.vcf -outputfile SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF.2A.txt -spid SNPBayEnv.spid
```

Run BayEnv to generate the covariance matrix
```javascipt
bayenv2 -i SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF.2A.txt -p 16 -k 100000 -r 63479 > matrix.out
```

This code generates 100,000 iterations. Only need the last one.
```javascipt
tail -17 matrix.out | head -16 > matrix
```

With the matrix, use the environmental factor file:
```javascript
cat environ
```
_This file has 2 variables for 16 populations_

Calculate the Bayes Factor for each SNP for each environmental variable:
```javascipt
calc_bf.sh SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF.2A.txt environ matrix 16 10000 2
```

Convert the output into something suitable to input into R
```javascript
paste <(seq 1 4412) <(cut -f2,3 bf_environ.environ ) > bayenv.out
cat <(echo -e "Locus\tBF1\tBF2") bayenv.out > bayenv.final
```

####  In RStudio
```javascipt
table_bay <- read.table("bayenv.final",header=TRUE)
plot(table_bay$BF1)

table_bay[which(table_bay$BF1 > 100),]
```

_No outliers detected_

### Generate a VCF file with only neutral SNPs

Determining dDocent_contig_# and position #
```javascript
less +3689 -N SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF.recode.vcf
  Sc28pcJ_1837_HRSCAF_1971        7411732
```
Create nano file with Outlier loci
```javascript
nano Outlier
  Sc28pcJ_1837_HRSCAF_1971        7411732
```
Create .vcf file with only neutral loci
```javascript
vcftools --vcf SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF.recode.vcf --exclude-positions Outlier --recode --recode-INFO-all --out SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF_neutral
```

Output:
```javascipt
After filtering, kept 384 out of 384 Individuals
Outputting VCF file...
After filtering, kept 4446 out of a possible 4447 Sites
```
#### In RStudio
```javascript
library(adegenet)
library(vcfR)

my_vcf <- read.vcfR("SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.MAF_neutral.recode.vcf")
my_genind <- vcfR2genind(my_vcf)

strata<- read.table("LibraryInfo", header=TRUE)
strata_df <- data.frame(strata)
strata(my_genind) <- strata_df

setPop(my_genind) <- ~Population

#Test Population Structure
library("hierfstat")
fstat(my_genind)

matFst <- pairwise.fst(my_genind)


#PCA

X <- tab(my_genind, freq = TRUE, NA.method = "mean")
pca1 <- dudi.pca(X, scale = FALSE, scannf = FALSE, nf = 3)
barplot(pca1$eig[1:50], main = "PCA eigenvalues", col = heat.colors(50))
s.class(pca1$li, pop(my_genind))
title("PCA of simulated dataset\naxes 1-2")
add.scatter.eig(pca1$eig[1:20], 3,1,2)

col <- funky(15)
s.class(pca1$li, pop(my_genind),xax=1,yax=2, col=col, axesell=FALSE, cstar=0, cpoint=3, grid=FALSE)
```
### RUN DAPC ON NEUTRAL SNPs

#### In RStudio
```javascript
grp <- find.clusters(my_genind, max.n.clust=40)
table(pop(my_genind), grp$grp)

table.value(table(pop(my_genind), grp$grp), col.lab=paste("inf", 1:2), row.lab=paste("ori", 1:4))

dapc1 <- dapc(my_genind, grp$grp)
scatter(dapc1,col=col,bg="white", solid=1)

contrib <- loadingplot(dapc1$var.contr, axis=1, thres=.01, lab.jitter=1)
contrib

setPop(my_genind) <- ~Library

dapc1 <- dapc(my_genind, pop(my_genind))
contrib <- loadingplot(dapc1$var.contr, axis=1, thres = 0.05, lab.jitter = 1)
contrib
```

### Silliman's Analyses for Real Dataset

#### In RStudio
```javascript
#Loading all the necessary packages
library(ggplot2) #For plotting
library(reshape2) #For plotting
library(plyr)
library("cowplot") #For plotting manuscript figs


###Pairwise Fst

my_genind
fst.mat <- genet.dist(my_genind, method = "WC84")

#Providing population names for plotting
pop_order <- c("Pop1","Pop2","Pop3","Pop4","Pop5","Pop6","Pop7","Pop8","Pop9","Pop10","Pop11","Pop12","Pop13","Pop14","Pop15","Pop16")

meltedN <- melt(gindF.fst.mat.triN, na.rm =TRUE)
colnames(gindF.fst.mat.triN) <- pop_order
rownames(gindF.fst.mat.triN) <- pop_order

#this produced a 16 x 16 by matrix
round(gindF.fst.mat.triN,4)

#Plotting Pairwise fst
neutral <- ggplot(data = meltedN, aes(Var2, Var1, fill = value))+ geom_tile(color = "white")+
  scale_fill_gradient(low = "white", high = "red", name="FST")  +
  ggtitle(expression(atop("Pairwise FST, WC, Neutral", atop(italic("N = 117, L = 13,073"), ""))))+
  labs( x = "Sampling Site", y = "Sampling Site") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1),axis.text.y = element_text(size = 13)) +
  theme(axis.title = element_text(size = 16),legend.text = element_text(size =15), legend.title = element_text(size =16)) +
  theme(plot.title = element_text(size = 17)) +
coord_fixed()
neutral


###Genetic diversity (observed and expected heterozygosity)

#All populations
comb <- summary(my_genind)
names(comb)

plot(comb$Hobs, xlab="Loci number", ylab="Observed Heterozygosity",
     main="Observed heterozygosity per locus")


plot(comb$Hobs,comb$Hexp, xlab="Hobs", ylab="Hexp",
      main="Expected heterozygosity as a function of observed heterozygosity per locus")

bartlett.test(list(comb$Hexp, comb$Hobs)) # a test : H0: Hexp = Hobs

# calculate basic popgen statistics for the overall dataset
basicstat <- basic.stats(my_genind, digits = 3)

as.data.frame(basicstat$overall)

# get bootstrap confidence values for Fis
boot <- boot.ppfis(my_genind,nboot = 1000)
boot5 <- boot.ppfis(my_genind,nboot = 1000,quant = 0.5)

# add latitude for each population - just using the values from Silliman's study
# removed 3 to match out 16 x 16 matrix
latitude = c(50.298667,49.01585,49.011383,48.435667,47.9978,47.7375,47.6131,47.3925,46.532386,45.3911556,44.579539,43.3559861,40.8557972,38.117549,37.95507,37.70867)

# combine all pop statistics
colnames(basicstat$Ho) <- pop_order
Ho <- colMeans(basicstat$Ho,na.rm = T)
He <- colMeans(basicstat$Hs,na.rm = T)
Fis<- boot5$fis.ci$ll
x <- cbind(Ho,He,Fis,boot$fis.ci,latitude)

#What is mean FIS across populations?
summary(Fis)

#Plot latitude agaiinst expected heterozygosity
R2 = round(summary(lm(x$He ~ x$latitude))$r.squared, 4)             

ggplot(x, aes(x = latitude, y = He)) + geom_point() +
geom_smooth(method=lm) +
ggtitle("Expected heterozygosity vs Latitude, Neutral") +
annotate(geom = "text", label=paste("italic(R^2)==",R2), x=45, y=0.25, parse=T) +
scale_x_reverse()
```
****
I plan to go back to Silliman's analyses and attempt Treemix on the simulated and realdata.
