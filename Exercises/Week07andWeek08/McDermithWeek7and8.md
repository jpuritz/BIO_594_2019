# Simulated Data
## Call and Filter SNPS Code
dDocent

vcftools --vcf TotalRawSNPs.vcf --max-missing 0.5 --maf 0.001 --minQ 20 --recode --recode-INFO-all --out TRS

vcftools --vcf TRS.recode.vcf --minDP 5 --recode --recode-INFO-all --out TRSdp5

pop_missing_filter.sh TRSdp5.recode.vcf ../popmap 0.05 1 TRSdp5p05

dDocent_filters TRSdp5p05.recode.vcf TRSdp5p05

vcfallelicprimitives -k -g TRSdp5p05.FIL.recode.vcf |sed 's:\.|\.:\.\/\.:g' > TRSdp5p05F.prim
vcftools --vcf TRSdp5p05F.prim --recode --recode-INFO-all --remove-indels --out SNP.TRSdp5p05F

filter_hwe_by_pop.pl -v SNP.TRSdp5p05F.recode.vcf -p ../popmap -c 0.5 -out SNP.TRSdp5p05FHWE

vcftools --vcf SNP.TRSdp5p05FHWE.recode.vcf --maf 0.05 --recode --recode-INFO-all --out SNP.TRSdp5p05FHWEmaf05

java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.TRSdp5p05FHWEmaf05.recode.vcf -outputfile SNP.TRSdp5p05FHWEBS -spid BSsnp.spid

## PCA and Outlier Detection
#library(pcadapt)
#filename <- read.pcadapt("TotalRawSNPS.g5mac3.recode.vcf", type = "vcf")
#x <- pcadapt(input = filename, K=10)
#plot(x, option = "screeplot")

qval <- qvalue(x$pvalues)$qvalues
alpha <- 0.1
outliers <- which(qval < alpha)

source("Outlier Detection.R")
plot_bayescan("positions.txt")
plot_bayescan("positions.txt", FDR=0.1)

#PCA
library(pcadapt)
filename <- read.pcadapt("TotalRawSNPS.g5mac3.recode.vcf", type = "vcf")
x <- pcadapt(input = filename, K=10)
plot(x, option = "screeplot")
head("TotalRawSNPS.g5mac3.recode.vcf")

poplist.names <- c(rep("PopA", 20),rep("PopB", 20),rep("PopC", 20), rep("PopD",20))
plot(x, option = "scores", pop = poplist.names)
plot(x, option = "scores", i = 2, j = 3, pop = poplist.names)
plot(x, option = "scores", i = 3, j = 4, pop = poplist.names)
![Screen Shot 2019-04-14 at 2 07 39 AM](https://user-images.githubusercontent.com/46970271/56089067-fb700180-5e5a-11e9-8e0b-0f4722c10e6c.png)
## DAPC
#DAPC
library(adegenet)
library(vcfR)

my_vcf <- read.vcfR("TotalRawSNPS.g5mac3.recode.vcf")
my_genind2 <- vcfR2genind(my_vcf)

grp <- find.clusters(my_genind2, max.n.clust=40)
table(pop(my_genind2), grp$grp)
#if you get a same length error look at the pop(my_genid) file and grp (groupings file). Probably because of 2 different data sets
table.value(table(pop(my_genind2), grp$grp), col.lab=paste("inf", 1:2), row.lab=paste("ori", 1:4))

dapc1 <- dapc(my_genind2, grp$grp)
scatter(dapc1,col=col,bg="white", solid=1)

contrib <- loadingplot(dapc1$var.contr, axis=1, thres=.01, lab.jitter=1)
contrib

setPop(my_genind) <- ~Library

dapc1 <- dapc(my_genind, pop(my_genind))
contrib <- loadingplot(dapc1$var.contr, axis=1, thres=.05, lab.jitter=1)
## Silliman Analysis


# Real Data
## BayeScan
BayeScan2.1_linux64bits SNP.dp3 -nbp 30 -thin 20
Using 80 threads (80 cpu detected on this machine)

Visualizing BayeScan in R
source("plot_R.r")
plot_bayescan("SNP.DP3g98maf01_85INDoutFILBayenv.txt")
plot_bayescan("SNP.DP3g98maf01_85INDoutFILBayenv.txt", FDR=0.1)

## BayEnv
bayenv2 -i SNP.DP3g98maf01_85INDoutFILBayenv.txt -p 4 -k 100000 -r 63479 > matrix.out
calc_bf.sh SNP.DP3g98maf01_85INDoutFILBayenv.txt matrix 16 10000 2
(To run program in background)
^Z
bg
disown -a
## PCA
library(pcadapt)
filename <- read.pcadapt("SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.recode.vcf", type = "vcf" )

#Create first PCA
x <- pcadapt(input = filename, K = 20)

#Plot the likelihoods
plot(x, option = "screeplot")
#Plot Plot the likelihoods for only first 10 K
plot(x, option = "screeplot", K = 10)

#Create population designations
poplist.names <- c(rep("POPA", 20),rep("POPB", 20),rep("POPC", 20), rep("POPD",20))
## DAPC

## 2 Silliman
