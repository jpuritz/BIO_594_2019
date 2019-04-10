### Week 7 and Week 8 Exercise
#### Cassie Raker
---

###### create environment
```
conda create -n week0708 ddocent
```

###### create directory and move data
```
mkdir ceraker.0708.ex
cd ceraker.0708.ex/
cp -r /home/BIO594/Exercises/Week07_and_Week_08/* .
```

#### Simulated Data
###### run dDocent on simulated data
```
cd simulated/
dDocent
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
ceraker@uri.edu
```
```
K1 = 5
K2 = 3
```

###### results
```
dDocent assembled 2691 sequences (after cutoffs) into 731 contigs
```

###### Filter SNPs
```
mkdir Filter
cd Filter/
ln -s ../TotalRawSNPs.vcf .
vcftools --vcf TotalRawSNPs.vcf --max-missing 0.5 --maf 0.001 --minQ 20 --recode --recode-INFO-all --out TRS
```
###### results
```
After filtering, kept 80 out of 80 Individuals
After filtering, kept 2137 out of a possible 2354 Sites
```
###### Generate a .prim file
```
vcfallelicprimitives -k -g TRS.recode.vcf |sed 's:\.|\.:\.\/\.:g' > TRS.prim
```
###### Filter out indels
```
dDocent_filters TRS.recode.vcf TRS
```
###### results
```
Number of sites filtered based on maximum mean depth
 195 of 1802

Number of sites filtered based on within locus depth mismatch
 3 of 1588

Total number of sites filtered
 552 of 2137

Remaining sites
 1585

Filtered VCF file is called Output_prefix.FIL.recode.vcf
```
```
vcftools --vcf SNP.TRS.recode.vcf --max-alleles 2 --recode --recode-INFO-all --out SNP.TRS
```
###### copy filtered vcf file to main directory so R can find it
```
cp /home/craker/BIO594_Puritz/ceraker.0708.ex/simulated/Filter/TRS.FIL.recode.vcf /home/craker/BIO594_Puritz/ceraker.0708.ex/
```
##### THIS CODE WRITTEN IN R
###### load pcadapt library
```{r}
library(pcadapt)
```

###### load VCF file
```{r}
filename <- read.pcadapt("TRS.FIL.recode.vcf", type = "vcf" )
```
###### first PCA
```{r}
x <- pcadapt(input = filename, K = 20)
```

###### plot the likelihoods
```{r}
plot(x, option = "screeplot")
```
![simulated data scree plot](/Users/cassieraker/Desktop/BIO594/week0708/sim_scree.png)

###### Create population designations
```{r}
poplist.names <- c(rep("POPA", 20),rep("POPB", 20),rep("POPC", 20), rep("POPD",20))
```

###### Plot PCAs 1 and 2
```{r}
plot(x, option = "scores", pop = poplist.names)
```
![simulated PCA](/Users/cassieraker/Desktop/BIO594/week0708/sim_PCA.png)

##### DAPC analysis (hopefully)
###### load in vcf
```
my_vcf <- read.vcfR("TRS.FIL.recode.vcf")
my_genind <- vcfR2genind(my_vcf)
```

###### basic genetic clustering
```
grp <- find.clusters(my_genind, max.n.clust = 40)
table(pop(my_genind), grp$grp)
```
"Error in table(pop(my_genind), grp$grp) : all arguments must have the same length"
Could not figure out how to fix this and so subsequent code did not run.

```
table.value(table(pop(my_genind), grp$grp), col.lab=paste("inf", 1:2), row.lab=paste("ori", 1:4))
```

```
dapc1 <- dapc(my_genind, grp$grp)
scatter(dapc1, col=col, bg="white", solid=1)
```

```
contrib <- loadingplot(dapc1$var.contr, axis=1, thres=0.005, lab.jitter = 1)
```

```
contrib
```

```
setPop(my_genind) <- ~Library

dapc1 <- dapc(my_genind, pop(my_genind))

contrib <- loadingplot(dapc1$var.contr, axis=1, thres=0.005, lab.jitter = 1)
```

```
setPop(my_genind) <- ~Library

dapc1 <- dapc(my_genind, pop(my_genind))

contrib <- loadingplot(dapc1$var.contr, axis=1, thres=0.04, lab.jitter = 1)
```

#### Real Data
###### Filter for minor allele frequency
```
vcftools --vcf SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.recode.vcf --max-alleles 2 --recode --recode-INFO-all --out SNP.DP3g98maf01_85INDout
```
###### results
```
After filtering, kept 384 out of 384 Individuals
After filtering, kept 7229 out of a possible 7303 Sites
```
###### convert vcf file using PGDSpider
```
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.DP3g98maf01_85INDout.recode.vcf -outputfile SNP.DP3g98maf01_85INDout -spid BSsnp.spid
```
###### Run BayeScan
```
bayescan2 SNP.DP3g98maf01_85INDout -nbp 30 -thin 20
```
###### BayEnv
```
cp /usr/local/bin/bayenv2 .
```
```
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.DP3g98maf01_85INDout.recode.vcf -outputfile SNP.DP3g98maf01_85INDoutBayEnv.txt -spid SNPBayEnv.spid
bayenv2 -i SNP.DP3g98maf01_85INDoutBayEnv.txt -p 16 -k 100000 -r 63479 > matrix.out
tail -5 matrix.out | head -4 > matrix
cat environ
```
```
calc_bf.sh SNP.DP3g98maf01_85INDoutBayEnv.txt environ matrix 16 10000 2
```

```
split -a 10 -l 2 SNP.DP3g98maf01_85INDoutBayEnv.txt snp_batch
for f in $(ls snp_batch*)
do
bayenv2 -i SNP.DP3g98maf01_85INDoutBayEnv.txt -e environ -m matrix -k 100000 -r 63479 -p 16 -n 2
done
rm -f snp_batch*
```
"cut: bf_environ.environ: No such file or directory"

commands below did not work due to issue mentioned above
```
paste <(seq 1 981) <(cut -f2,3 bf_environ.environ ) > bayenv.out
cat <(echo -e "Locus\tBF1\tBF2") bayenv.out > bayenv.final
```
###### In R
```
table_bay <- read.table("bayenv.final",header=TRUE)
plot(table_bay$BF1)

table_bay[which(table_bay$BF1 > 100),]
```

###### PCAs
###### copy filtered vcf file to main directory so R can find it
```
cp /home/craker/BIO594_Puritz/ceraker.0708.ex/realdata/SNP.DP3g98maf01_85INDout.recode.vcf /home/craker/BIO594_Puritz/ceraker.0708.ex/
```
###### add line to vcf file to R can recognize it
```
nano SNP.DP3g98maf01_85INDout.recode.vcf
added first line "##fileformat=VCFv"
```
![real data scree plot](/Users/cassieraker/Desktop/BIO594/week0708/realdata_scree.png)

###### Create population designations
```
poplist.names <- c(rep("POPA", 24),rep("POPB", 24),rep("POPC", 24), rep("POPD",24),rep("POPE",24),rep("POPF",24),rep("POPG",24),rep("POPH",24),rep("POPI",24),rep("POPJ",24),rep("POPK",24),rep("POPL",24),rep("POPM",24),rep("POPN",24),rep("POPO",24),rep("POPP",24))
```
(This looks like too many populations but I also think this is how many there are?)
###### Plot PCAs 1 and 2
```
plot(x, option = "scores", pop = poplist.names)
```

![real data PCA plot](/Users/cassieraker/Desktop/BIO594/week0708/realdata_PCA.png)

###### basic genetic clustering (DAPC)
```
grp <- find.clusters(my_genind, max.n.clust = 40)
table(pop(my_genind), grp$grp)
```
"Error in table(pop(my_genind), grp$grp) : all arguments must have the same length"
Could not figure out how to fix this and so subsequent code did not run.
```
table.value(table(pop(my_genind), grp$grp), col.lab=paste("inf", 1:2), row.lab=paste("ori", 1:4))
```

```
dapc1 <- dapc(my_genind, grp$grp)
scatter(dapc1, col=col, bg="white", solid=1)
```

```
contrib <- loadingplot(dapc1$var.contr, axis=1, thres=0.005, lab.jitter = 1)
```

```
contrib
```

```
setPop(my_genind) <- ~Library

dapc1 <- dapc(my_genind, pop(my_genind))

contrib <- loadingplot(dapc1$var.contr, axis=1, thres=0.005, lab.jitter = 1)
```

```
setPop(my_genind) <- ~Library

dapc1 <- dapc(my_genind, pop(my_genind))

contrib <- loadingplot(dapc1$var.contr, axis=1, thres=0.04, lab.jitter = 1)
```

#### Silliman Analyses
I had a lot of trouble getting these to work, as it was difficult to figure out the files to start with. My goal was to do the Fst and Treemix analysis, but I kept running into errors that I was missing files. I have included the things I attempted to do, as well as the scripts I would have used had I gotten it to work.

###### Silliman Treemix script
```
__author__ = 'ksil91'

import sys

def makeTM(infile,outfile):
	IN = open(infile,"r")
	OUT = open(outfile,"w")
	pops = []
	adict = {}
	next(IN)
	for line in IN:
		stuff = line.strip().split()
		pops.append(stuff[0])
		a1 = stuff[1::2]
		a2 = stuff[2::2]
		adict[stuff[0]] = zip(a1,a2)
	IN.close()
	OUT.write(" ".join(pops)+"\n")
	text = ""
	for loci in range(len(adict[stuff[0]])):
		for p in pops:
			text = text+",".join(map(str,adict[p][loci]))+" "
		if " 0,0" not in text:
			OUT.write(text+"\n")
		text = ""
	OUT.close()

def main(argv):
	#get arguments from command line
	infile_name = argv[1]
	outfile_name = argv[2]
	makeTM(infile_name,outfile_name)

if __name__ == "__main__":
	status = main(sys.argv)
	sys.exit(status)
© 2019 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About
```

###### Code from Fst analysis
```
fst.mat <- genet.dist(hf.filt, method = "WC84")
In [6]:
gindF.fst.mat.triN <- as.matrix(fst.mat)
colnames(gindF.fst.mat.triN) <- pop_order
rownames(gindF.fst.mat.triN) <- pop_order
write.table(gindF.fst.mat.triN, file="OL-t10x45m75-maf025-NeutI2-Pop.pwfst",row.names = T,col.names = T)
```
```
meltedN <- melt(gindF.fst.mat.triN, na.rm =TRUE)
round(gindF.fst.mat.triN,4)
```
```
#Average pairwise Fst
summary(meltedN$value)
```
```
# plot using ggplot
neutral <- ggplot(data = meltedN, aes(Var2, Var1, fill = value))+ geom_tile(color = "white")+
  scale_fill_gradient(low = "white", high = "red", name="FST")  +
  ggtitle(expression(atop("Pairwise FST, WC (1984), Neutral", atop(italic("N = 117, L = 13,073"), ""))))+
  labs( x = "Sampling Site", y = "Sampling Site") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1),axis.text.y = element_text(size = 13)) +
  theme(axis.title = element_text(size = 16),legend.text = element_text(size =15), legend.title = element_text(size =16)) +
  theme(plot.title = element_text(size = 17)) +
coord_fixed()
neutral
```

##### What I attempted in R
---
###### title: "Silliman"
###### output: html_document
---
###### load libraries
```
library("adegenet") #For storing genotype data
library(hierfstat) #For calculating pairwise Fst
library(ggplot2) #For plotting
library(reshape2) #For plotting
library(plyr)
library("cowplot") #For plotting manuscript figs
```
###### read in vcf file
```
my_vcf <- read.vcfR("TRS.FIL.recode.vcf")

Scanning file to determine attributes.
File attributes:
  meta lines: 65
  header_line: 66
  variant count: 1585
  column count: 89
Meta line 65 read in.
All meta lines processed.
gt matrix initialized.
Character matrix gt created.
  Character matrix gt rows: 1585
  Character matrix gt cols: 89
  skip: 0
  nrows: 1585
  row_num: 0
Processed variant: 1585
All variants processed
```

```
my_genind <- vcfR2genind(my_vcf)
```

```
strata<- read.table("LibraryInfo", header=TRUE)
strata_df <- data.frame(strata)
strata(my_genind) <- strata_df
setPop(my_genind) <- ~Population
```
"Error: Number of rows in data frame not equal to number of individuals in object."

###### load libraries for other analysis
```
library("adegenet") #for storing genetic data and running PCA
library("PCAviz")  #Visualizing output of PCA
library("cowplot") #Used with PCAviz
```

```
NA.afDraw<- function(ind){
  ind.mat <- ind@tab
  new.mat <- ind.mat
  af = colSums(ind.mat[,seq(1,ncol(ind.mat)-1,2)],na.rm = TRUE)/
      (2*apply(ind.mat[,seq(1,ncol(ind.mat)-1,2)],2,function(x) sum(!is.na(x))))
  af.Draw <- function(geno, af){
     new <- function(geno,af){
        if(is.na(geno)){
        newA = rbinom(1,2,af)
        }
        else {newA <- geno}
        return(newA)
   }
  new.row <- mapply(geno,af,FUN = new)
  return(new.row)}

  new.mat[,seq(1,ncol(ind.mat)-1,2)] <- t(apply(ind.mat[,seq(1,ncol(ind.mat)-1,2)],1,af.Draw,af))
  new.mat[,seq(2,ncol(ind.mat),2)] <- 2-new.mat[,seq(1,ncol(ind.mat)-1,2)]
  new.ind <- ind
  new.ind@tab <- new.mat
  return(new.ind)
}
```

```
u.na <- NA.afDraw(stratted.u)
```
"Error in NA.afDraw(stratted.u) : object 'stratted.u' not found"
