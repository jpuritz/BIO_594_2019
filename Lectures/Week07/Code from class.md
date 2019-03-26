# Code from Week7

create environment

`conda create -n week7 ddocent`

## Calling SNPs
Create working directory and link to the data

```bash
mkdir week7
cd week7
ln -s /home/BIO594/DATA/Week7/example/*.fq.gz .
```

Start dDocent

`dDocent`

Use these settings:
```
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
jpuritz@gmail.com
```

Use `5` for K1 and `3` for K2 during assembly

When finished, start filtering SNPs.  **I won't comment this code as it is all review**

## SNP Filtering
```
mkdir Filter
cd Filter/
ln -s ../TotalRawSNPs.vcf .
vcftools --vcf TotalRawSNPs.vcf --max-missing 0.5 --maf 0.001 --minQ 20 --recode --recode-INFO-all --out TRS
```
Output should resemble:
```
VCFtools - 0.1.14
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
Run Time = 4.00 seconds
```

Command:
```
vcftools --vcf TRS.recode.vcf --minDP 5 --recode --recode-INFO-all --out TRSdp5
```

Output:
```
VCFtools - 0.1.14
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
Run Time = 3.00 seconds
```

Command:
```
pop_missing_filter.sh TRSdp5.recode.vcf ../popmap 0.05 1 TRSdp5p05
```

Output:
```
After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 2816 out of a possible 2993 Sites
Run Time = 3.00 seconds
```

Command:
```
dDocent_filters TRSdp5p05.recode.vcf TRSdp5p05
```

Partial Output:

```
                                            Histogram of mean depth per site

  250 +-+-+---+---+---+---+---+---+--+---+---+---+---+---+---+---+---+---+---+---+---+---+--+---+---+---+---+---+-+-+
      +   +   +   +   +   +   +   +  +   +   +   +   +   +   +   +   +   +   +   +   +   +  +   +   +   +   +   +   +
      |                                      *            'meandepthpersite' using (bin($1,binwidth)):(1.0) ******* |
      |                                     ***                                                                     |
      |                                     ***                                                                     |
  200 +-+                                  ****                                                                   +-+
      |                                    ****                                                                     |
      |                                   *****                                                                     |
      |                                   *****                                                                     |
  150 +-+                                *******                                                                  +-+
      |                                  *******                                                                    |
      |                                  *******                                                                    |
      |                                  ********                                                                   |
      |                                  ********                                                                   |
  100 +-+                                ********                                                                 +-+
      |                                  ********                                                                   |
      |                                  ********                                                                   |
      |                                **********                                                                   |
   50 +-+                              **********                                                                 +-+
      |                               ************                                                                  |
      |                              **************                                                                 |
      |                              ***************                                                                |
      +   +   +   +   +   +   +   +  ****************+   +   +   +   +   +   +   +   +   +  +   +   +   +   +   +   +
    0 +-+-+---+---+---+---+---+---+********************--+---+---+---+---+---+---+---+---+--+---+---+---+---+---+-+-+
      10  15  20  25  30  35  40  45 50  55  60  65  70  75  80  85  90  95 100 105 110 11 120 125 130 135 140 145 150
                                                        Mean Depth

If distrubtion looks normal, a 1.645 sigma cutoff (~90% of the data) would be 5171.64712
The 95% cutoff would be 64
Would you like to use a different maximum mean depth cutoff than 64, yes or no
yes
Please enter new cutoff
75
Number of sites filtered based on maximum mean depth
 0 of 2136

Number of sites filtered based on within locus depth mismatch
 0 of 1976

Total number of sites filtered
 840 of 2816

Remaining sites
 1976

Filtered VCF file is called Output_prefix.FIL.recode.vcf

Filter stats stored in TRSdp5p05.filterstats
```

Commands:
```
vcfallelicprimitives -k -g TRSdp5p05.FIL.recode.vcf |sed 's:\.|\.:\.\/\.:g' > TRSdp5p05F.prim
vcftools --vcf TRSdp5p05F.prim --recode --recode-INFO-all --remove-indels --out SNP.TRSdp5p05F
```
Output:
```
After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 1731 out of a possible 2130 Sites
Run Time = 1.00 seconds
```

Command:
```
filter_hwe_by_pop.pl -v SNP.TRSdp5p05F.recode.vcf -p ../popmap -c 0.5 -out SNP.TRSdp5p05FHWE
```
Output:
```
Processing population: PopA (20 inds)
Processing population: PopB (20 inds)
Processing population: PopC (20 inds)
Processing population: PopD (20 inds)
Outputting results of HWE test for filtered loci to 'filtered.hwe'
Kept 1731 of a possible 1731 loci (filtered 0 loci)
```
Command:
```
vcftools --vcf SNP.TRSdp5p05FHWE.recode.vcf --maf 0.05 --recode --recode-INFO-all --out SNP.TRSdp5p05FHWEmaf05
```
Output:
```
VCFtools - 0.1.14
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf SNP.TRSdp5p05FHWE.recode.vcf
        --recode-INFO-all
        --maf 0.05
        --out SNP.TRSdp5p05FHWEmaf05
        --recode

After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 941 out of a possible 1731 Sites
```

## Converting from VCF to other outputs

Copy a PGDspider configuration file and file to map individuals to population
```
cp /home/BIO594/DATA/Week7/example/BSsnp.spid .
ln -s ../popmap .
```
Now, run PGDspider
```
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.TRSdp5p05FHWEmaf05.recode.vcf -outputfile SNP.TRSdp5p05FHWEBS -spid BSsnp.spid
```
Output:
```
WARN  15:46:52 - PGDSpider configuration file not found! Loading default configuration.                   │
initialize convert process...                                                                             │
read input file...                                                                                        │
read input file done.                                                                                     │
write output file...                                                                                      │
write output file done.
```
## Outlier Detection

### Run BayeScan

To learn more about BayeScan [LINK](http://cmpg.unibe.ch/software/BayeScan/)
```
BayeScan2.1_linux64bits SNP.TRSdp5p05FHWEBS -nbp 30 -thin 20
```
Copy R source file
```
cp /home/BIO594/DATA/Week7/example/plot_R.r .
```

### Open Rstudio 
```
source("plot_R.r")
plot_bayescan("SNP.TRSdp5p05FH_fst.txt")
```

## More outlier Detection

For all other analyses, we need to limit SNPs to only those with two alleles:

```
vcftools --vcf SNP.TRSdp5p05FHWEmaf05.recode.vcf --max-alleles 2 --recode --recode-INFO-all --out SNP.TRSdp5p05FHWE2A
```

## PCAdapt

This program runs entirely in R and has excellent [documentation](https://bcm-uga.github.io/pcadapt/)


### Open Rstudio 

R code:
```R
#Load pcadapt library
library(pcadapt)

#load our VCF file into R
filename <- read.pcadapt("SNP.TRSdp5p05FHWE2A.recode.vcf", type = "vcf" )

#Create first PCA
x <- pcadapt(input = filename, K = 20)

#Plot the likelihoods
plot(x, option = "screeplot")
#Plot Plot the likelihoods for only first 10 K
plot(x, option = "screeplot", K = 10)

#Create population designations
poplist.names <- c(rep("POPA", 20),rep("POPB", 20),rep("POPC", 20), rep("POPD",20))

#Plot the actual PCA (first two PCAs)
plot(x, option = "scores", pop = poplist.names)
#Plot PCA with PCA 2 and PCA 3
plot(x, option = "scores", i = 2, j = 3, pop = poplist.names)
#Plot PCA with PCA 3 and PCA 4
plot(x, option = "scores", i = 3, j = 4, pop = poplist.names)

#Redo PCA with only 3 K
x <- pcadapt(filename, K = 3)

summary(x)

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

## R code for running Outflank
See documentation [here](https://github.com/whitlock/OutFLANK)

```
R
```

```R
library(OutFLANK)  # outflank package
library(vcfR)
library(bigsnpr)   # package for LD pruning

my_vcf <- read.vcfR("SNP.TRSdp5p05FHWE2A.recode.vcf")

geno <- extract.gt(my_vcf) # Character matrix containing the genotypes
position <- getPOS(my_vcf) # Positions in bp
chromosome <- getCHROM(my_vcf) # Chromosome information

G <- matrix(NA, nrow = nrow(geno), ncol = ncol(geno))

G[geno %in% c("0/0", "0|0")] <- 0
G[geno  %in% c("0/1", "1/0", "1|0", "0|1")] <- 1
G[geno %in% c("1/1", "1|1")] <- 2

G[is.na(G)] <- 9

head(G[,1:10])

pop <- read.csv("indv", header=FALSE)
pop <- pop$V1


my_fst <- MakeDiploidFSTMat(t(G), locusNames = paste0(chromosome,"_", position), popNames = pop)

my_dist <- OutFLANK(my_fst, NumberOfSamples = 4, qthreshold=0.1, RightTrimFraction=0.1, LeftTrimFraction=0.1)


OutFLANKResultsPlotter(my_dist)

plot(my_dist$results$FST, col=as.numeric(as.factor(chromosome)))


my_dist$results[which(my_dist$results$OutlierFlag == TRUE),]
```

## BayEnv2

[Documentation](https://bitbucket.org/tguenther/bayenv2_public/src)

First, convert vcf to BayEnv input
```
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.TRSdp5p05FHWE2A.recode.vcf -outputfile SNP.TRSdp5p05FHWEBayEnv.txt -spid SNPBayEnv.spid
```

```
WARN  22:05:19 - PGDSpider configuration file not found! Loading default configuration.
initialize convert process...
read input file...
read input file done.
write output file...
write output file done.
```

Run BayEnv to generate the covariance matrix

`bayenv2 -i SNP.TRSdp5p05FHWEBayEnv.txt -p 4 -k 100000 -r 63479 > matrix.out`

This code generates 100,000 iterations.  We only need the last one.

`tail -5 matrix.out | head -4 > matrix`

With the matrix we will use our environmental factor file:

`cat environ`

```
-0.888330138    -0.565300997    0.080757285     1.37287385
-0.565300997    -0.484543712    -0.565300997    -0.403786427
```

The environmental file are standardized environmental data with each line representing an environemtal factor with the value for each population tab delimited.  This dummy file has 2 variables for 4 populations

Next, we calculate the Bayes Factor for each SNP for each environmental variable:

```
calc_bf.sh SNP.TRSdp5p05FHWEBayEnv.txt environ matrix 4 10000 2
```

Next, we convert the output into something suitable to input into R
```
paste <(seq 1 981) <(cut -f2,3 bf_environ.environ ) > bayenv.out
cat <(echo -e "Locus\tBF1\tBF2") bayenv.out > bayenv.final
```

Now, open R

`R`

```
table_bay <- read.table("bayenv.final",header=TRUE)
plot(table_bay$BF1)

table_bay[which(table_bay$BF1 > 100),]
```
