# Code from Week9


First, remember to create a week8 directory and copy the data

```bash
mkdir week9
cd week9
cp /home/BIO594/DATA/Week8/* .
```

Now, open RStudio

All R code from this point on...

```R
library(adegenet)
library(vcfR)


my_vcf <- read.vcfR("SNPs.vcf")


my_genind <- vcfR2genind(my_vcf)


strata<- read.table("strata", header=TRUE)
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


#Missing Data
my_vcf <- read.vcfR("SNP.missing.vcf")


my_genind <- vcfR2genind(my_vcf)


strata<- read.table("strata", header=TRUE)
strata_df <- data.frame(strata)
strata(my_genind) <- strata_df

setPop(my_genind) <- ~Population

X <- tab(my_genind, freq = TRUE, NA.method = "mean")
pca1 <- dudi.pca(X, scale = FALSE, scannf = FALSE, nf = 3)
s.class(pca1$li, pop(my_genind),xax=1,yax=2, col=col, axesell=FALSE, cstar=0, cpoint=3, grid=FALSE)



my_vcf <- read.vcfR("SNP.missing2.vcf")


my_genind <- vcfR2genind(my_vcf)


strata<- read.table("strata", header=TRUE)
strata_df <- data.frame(strata)
strata(my_genind) <- strata_df

setPop(my_genind) <- ~Population

X <- tab(my_genind, freq = TRUE, NA.method = "mean")
pca1 <- dudi.pca(X, scale = FALSE, scannf = FALSE, nf = 3)
s.class(pca1$li, pop(my_genind),xax=1,yax=2, col=col, axesell=FALSE, cstar=0, cpoint=3, grid=FALSE)


my_vcf <- read.vcfR("SNP.missingPopD2.vcf")


my_genind <- vcfR2genind(my_vcf)


strata<- read.table("strata", header=TRUE)
strata_df <- data.frame(strata)
strata(my_genind) <- strata_df

setPop(my_genind) <- ~Population

X <- tab(my_genind, freq = TRUE, NA.method = "mean")
pca1 <- dudi.pca(X, scale = FALSE, scannf = FALSE, nf = 3)
s.class(pca1$li, pop(my_genind),xax=1,yax=2, col=col, axesell=FALSE, cstar=0, cpoint=3, grid=FALSE)

# Related


my_vcf <- read.vcfR("SNP.related.vcf")


my_genind <- vcfR2genind(my_vcf)


strata<- read.table("strata", header=TRUE)
strata_df <- data.frame(strata)
strata(my_genind) <- strata_df

setPop(my_genind) <- ~Population

X <- tab(my_genind, freq = TRUE, NA.method = "mean")
pca1 <- dudi.pca(X, scale = FALSE, scannf = FALSE, nf = 3)
s.class(pca1$li, pop(my_genind),xax=1,yax=2, col=col, axesell=FALSE, cstar=0, cpoint=3, grid=FALSE)



# Isolation by distance
my_vcf <- read.vcfR("SNPs.vcf")


my_genind <- vcfR2genind(my_vcf)


strata<- read.table("strata", header=TRUE)
strata_df <- data.frame(strata)
strata(my_genind) <- strata_df

setPop(my_genind) <- ~Population

xy <-read.table("dist.mat")
xy
my_genind@other$xy <- xy


toto <- genind2genpop(my_genind)
Dgeo <- dist(my_genind$other$xy)
Dgen <- dist.genpop(toto,method=2)
ibd <- mantel.randtest(Dgen,Dgeo)

plot(ibd)
plot(Dgeo, Dgen)
abline(lm(Dgen~Dgeo), col="red",lty=2)


#DAPC

grp <- find.clusters(my_genind, max.n.clust=40)
table(pop(my_genind), grp$grp)

table.value(table(pop(my_genind), grp$grp), col.lab=paste("inf", 1:2), row.lab=paste("ori", 1:4))


dapc1 <- dapc(my_genind, grp$grp)
scatter(dapc1,col=col,bg="white", solid=1)



contrib <- loadingplot(dapc1$var.contr, axis=1, thres=.01, lab.jitter=1)
contrib


setPop(my_genind) <- ~Library

dapc1 <- dapc(my_genind, pop(my_genind))
contrib <- loadingplot(dapc1$var.contr, axis=1, thres=.05, lab.jitter=1)




#Structure Like


compoplot(dapc1, posi="bottomright",txt.leg=paste("Cluster", 1:6), lab="", ncol=1, xlab="individuals")

temp <- which(apply(dapc1$posterior,1, function(e) all(e<0.9)))

compoplot(dapc1, subset=temp, posi="bottomright", txt.leg=paste("Cluster", 1:4), ncol=2)


```


## Silliman et al. 2019

Here will follow code from Katherine's [repository](https://github.com/ksil91/Ostrea_PopStructure)






