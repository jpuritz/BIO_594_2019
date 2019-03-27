
# Making files for other programs
This is an R Notebook detailing how I take a .vcf file from ipyrad that has been subsequently filtered using VCFtools, and turn it into other formats for population genetic analyses. I do this first for the full SNP dataset , then again for only outlier SNPs or only neutral SNPs, so it is a bit repetetive. Using a [table of contents extension](https://github.com/jupyterlab/jupyterlab-toc) for Jupyter Lab can help navigate long notebooks like this.

I primarily use the [*radiator* R package](https://rdrr.io/github/thierrygosselin/radiator/) by Thierry Gosselin for file conversions. This package has great documentation and can do more than what is presented here.

For the full "combined" SNP dataset (before filtering based on outliers), I need to convert the .vcf file into the following formats:
* `genind` object for PCA and popgen summary statistics
* `hierfstat` for calculating F_{ST}
* Inputs for outlier detection programs (BayeScan, *OutFLANK*, and *pcadapt*)

For the "neutral" SNP dataset, I convert the .vcf file into:
* `genind` object for PCA and popgen summary statistics
* `hierfstat` for calculating F_{ST}
* Input for Structure
* Input for Treemix, using "unlinked" dataset
* Inputs for EEMS

For the "outlier" dataset, I convert the .vcf file into: 
* `genind` object for PCA and popgen summary statistics
* `hierfstat` for calculating F_{ST}
* Input for Structure


# Combined dataset
## Make genind object for PCA and popgen summary statistics


```R
library("adegenet") # .genind format
library("radiator") # Conversion from vcf to a lot of other formats
library("dplyr") 
```

    Loading required package: ade4
    
       /// adegenet 2.1.1 is loaded ////////////
    
       > overview: '?adegenet'
       > tutorials/doc/questions: 'adegenetWeb()' 
       > bug reports/feature requests: adegenetIssues()
    
    
    
    Attaching package: ‘dplyr’
    
    The following objects are masked from ‘package:stats’:
    
        filter, lag
    
    The following objects are masked from ‘package:base’:
    
        intersect, setdiff, setequal, union
    



```R
# set filename prefix, should match with the prefix for the input .vcf and desired output files
filtsuf = "OL-c85t10-x45m75"
```

uses *radiator* to convert a filtered .vcf from Filtering_VCF.ipynb to a [genind object](https://www.rdocumentation.org/packages/adegenet/versions/1.0-0/topics/genind). Requires a .strata file, which lists the population assignment of each individual and was created in Filtering_VCF.ipynb.


```R
# convert filtered .vcf to a genind object
# common.markers: Only keep markers common in all popululations
# pop.levels: Orders populations from north to south (useful for later plotting)
rad.filt <- vcf2genind(paste0(filtsuf,"-maf025.recode.vcf"),filename=paste0(filtsuf,"-maf025-all"),
                      common.markers = T, strata="./OL-c85t10-x45.strata", 
                      pop.levels = c("Klaskino_BC","Barkley_BC","Ladysmith_BC","Victoria_BC","Discovery_WA","Liberty_WA","TritonCove_WA","NorthBay_WA","Willapa_WA","Netarts_OR","Yaquina_OR","Coos_OR","Humboldt_CA","Tomales_CA","NorthSanFran_CA","SouthSanFran_CA","Elkhorn_CA","MuguLagoon_CA","SanDiego_CA"),
                      parallel.core = 1)
```

    VCF is biallelic


    Reading 13487 / 13487 loci.
    Done.


        number of markers with REF/ALT change(s) = 0
    Using markers common in all populations:
        Number of markers before/blacklisted/after:13487/63/13424
    Scanning for monomorphic markers...
        Number of markers before/blacklisted/after: 13424/0/13424
    
    Tidy genomic data:
        Number of common markers: 13424
        Number of chromosome/contig/scaffold: 6187
        Number of individuals: 117
        Number of populations: 19
    
    Writing tidy data set:
    OL-c85t10-x45m75-maf025-all.rad


Read in the other info from .strata file and extract information such as region, latitude, and longitude. Region in my case was determined after running Structure analyses and exploring the data with PCA. For clarity, I show how to create the input files when region is already determined. Then saves `genind` object to a file to be read in by subsequent analyses.


```R
info <- as.data.frame(read.table("./OL-c85t10-x45.strata",header = T,sep = "\t",stringsAsFactors = F))

mystrats <- as.data.frame(matrix(,nrow = length(indNames(rad.filt$genind.no.imputation)),ncol=5))
colnames(mystrats) <- c("POPULATION","LOCATION","REGION","LATITUDE","LONGITUDE")

for(i in 1:nrow(info)){
    j <- grep(gsub("_","-",info[i,1]),indNames(rad.filt$genind.no.imputation),value=FALSE)
    mystrats[j,1] <-info$STRATA[i] 
    mystrats[j,2] <-info$LOCATION[i] 
    mystrats[j,3] <-info$REGION[i]
    mystrats[j,4] <-info$LATITUDE[i]
    mystrats[j,5] <-info$LONGITUDE[i]
}
just.strats <- select(mystrats,c("POPULATION","LOCATION","REGION"))
stratted.filt <- strata(rad.filt$genind.no.imputation, formula= REGION/POPULATION/LOCATION, combine = TRUE,just.strats)
stratted.filt@other <- select(mystrats, LATITUDE,LONGITUDE)

```


```R
save(stratted.filt, file=paste(filtsuf,"-maf025-filt.genind",sep=""))
```

Do again for "unlinked" .vcf, with only 1 SNP per GBS locus. Note that `radiator` can subset SNPs as well if you'd prefer.


```R
rad.u <- vcf2genind(paste0(filtsuf,"-maf025-u.vcf"),filename=paste0(filtsuf,"-maf025-u"),
                      common.markers = T, strata="./OL-c85t10-x45.strata", 
                      pop.levels = c("Klaskino_BC","Barkley_BC","Ladysmith_BC","Victoria_BC","Discovery_WA","Liberty_WA","TritonCove_WA","NorthBay_WA","Willapa_WA","Netarts_OR","Yaquina_OR","Coos_OR","Humboldt_CA","Tomales_CA","NorthSanFran_CA","SouthSanFran_CA","Elkhorn_CA","MuguLagoon_CA","SanDiego_CA"),
                      parallel.core = 1)
```

    VCF is biallelic


    Reading 6208 / 6208 loci.
    Done.


        number of markers with REF/ALT change(s) = 0
    Using markers common in all populations:
        Number of markers before/blacklisted/after:6208/22/6186
    Scanning for monomorphic markers...
        Number of markers before/blacklisted/after: 6186/0/6186
    
    Tidy genomic data:
        Number of common markers: 6186
        Number of chromosome/contig/scaffold: 6186
        Number of individuals: 117
        Number of populations: 19
    
    Writing tidy data set:
    OL-c85t10-x45m75-maf025-u.rad



```R
stratted.u <- strata(rad.u$genind.no.imputation, formula= REGION/POPULATION/LOCATION, combine = TRUE,just.strats)
stratted.u@other <- select(mystrats, LATITUDE,LONGITUDE)
save(stratted.u, file=paste(filtsuf,"-maf025-u.genind",sep=""))
```

## Make *hierfstat* object for popgen summary stats
Hierfstat usually accepts a `genind` object, but will not accept the `genind` format created by the *radiator* package (which is kind of annoying). Make sure to use the same population ordering as above.


```R
hf.filt <- vcf2hierfstat(paste0(filtsuf,"-maf025.recode.vcf"),filename=paste0(filtsuf,"-maf025-all"),
                      common.markers = T, strata="./OL-c85t10-x45.strata", 
                      pop.levels = c("Klaskino_BC","Barkley_BC","Ladysmith_BC","Victoria_BC","Discovery_WA","Liberty_WA","TritonCove_WA","NorthBay_WA","Willapa_WA","Netarts_OR","Yaquina_OR","Coos_OR","Humboldt_CA","Tomales_CA","NorthSanFran_CA","SouthSanFran_CA","Elkhorn_CA","MuguLagoon_CA","SanDiego_CA"),
                      parallel.core = 1)
```

    VCF is biallelic


    Reading 13487 / 13487 loci.
    Done.


        number of markers with REF/ALT change(s) = 0
    Using markers common in all populations:
        Number of markers before/blacklisted/after:13487/63/13424
    Scanning for monomorphic markers...
        Number of markers before/blacklisted/after: 13424/0/13424
    
    Tidy genomic data:
        Number of common markers: 13424
        Number of chromosome/contig/scaffold: 6187
        Number of individuals: 117
        Number of populations: 19
        * Number of sample pop, np = 19
        * Number of markers, nl = 13424
        * The highest number used to label an allele, nu = 4
        * The alleles are encoded with one digit number
    
    Writing tidy data set:
    OL-c85t10-x45m75-maf025-all.rad



```R
# save to file
hf.filt <- hf.filt$hierfstat.no.imputation
save(hf.filt, file=paste0(filtsuf,"-maf025-filt.hf"))
```

Do again for u?


```R
hf.u <- vcf2hierfstat(paste0(filtsuf,"-maf025-u.vcf"),filename=paste0(filtsuf,"-maf025-u"),
                      common.markers = T, strata="../Making_Files/OL-c85t10-x45.strata", 
                      pop.levels = c("Klaskino_BC","Barkley_BC","Ladysmith_BC","Victoria_BC","Discovery_WA","Liberty_WA","TritonCove_WA","NorthBay_WA","Willapa_WA","Netarts_OR","Yaquina_OR","Coos_OR","Humboldt_CA","Tomales_CA","NorthSanFran_CA","SouthSanFran_CA","Elkhorn_CA","MuguLagoon_CA","SanDiego_CA"),
                      parallel.core = 1)
```

    VCF is biallelic


    Reading 6208 / 6208 loci.
    Done.


        number of markers with REF/ALT change(s) = 0
    Using markers common in all populations:
        Number of markers before/blacklisted/after:6208/22/6186
    Scanning for monomorphic markers...
        Number of markers before/blacklisted/after: 6186/0/6186
    
    Tidy genomic data:
        Number of common markers: 6186
        Number of chromosome/contig/scaffold: 6186
        Number of individuals: 117
        Number of populations: 19
        * Number of sample pop, np = 19
        * Number of markers, nl = 6186
        * The highest number used to label an allele, nu = 4
        * The alleles are encoded with one digit number
    
    Writing tidy data set:
    OL-c85t10-x45m75-maf025-u.rad



```R
hf.u <- hf.u$hierfstat.no.imputation
save(hf.u, file=paste0(filtsuf,"-maf025-u.hf"))
```

### Make input for BayeScan


```R
x <- write_bayescan(rad.filt$tidy.data, filename=paste0(filtsuf,"-maf025-filt-BS"),parallel.core = 1)
```

    Generating BayeScan file...
    Using markers common in all populations:
        Number of markers before/blacklisted/after:13424/0/13424
    Scanning for monomorphic markers...
        Number of markers before/blacklisted/after: 13424/0/13424
        generating REF/ALT dictionary
        integrating new genotype codings...
    Warning message:
    “Unknown columns: `POLYMORPHIC`”Warning message:
    “Unknown columns: `POLYMORPHIC`”Warning message:
    “Unknown columns: `POLYMORPHIC`”Warning message:
    “Unknown columns: `POLYMORPHIC`”Warning message:
    “Unknown columns: `POLYMORPHIC`”Warning message:
    “Unknown columns: `POLYMORPHIC`”writing BayeScan file with:
        Number of populations: 19
        Number of individuals: 117
        Number of biallelic markers: 13424
    Writting populations dictionary
    Writting markers dictionary


### Make input for OutFLANK and pcadapt
A table with the allele counts per individual is required for both *OutFLANK* and *pcadapt*. This code just saves the table stored in a genind object, as well as a file with the population information required by OutFLANK.


```R
# Write file with allele counts per individual for OutFLANK and pcadapt
write.table(stratted.filt@tab, file = paste0(filtsuf,"-maf025-filt.tab"),sep = "\t",row.names = T,col.names = T,quote = F )
# Write file with population information
write.table(strata(stratted.filt)$POPULATION, file = paste0(filtsuf,".pop"),sep = "\t",row.names = F,col.names = F,quote = F )
```

# Neutral dataset
File conversion steps for the "neutral" SNP dataset.


```R
#set filename suffix
filtsuf = "OL-c85t10-x45m75-maf025-neutI2"
```

## Make genind objects
Similar as above 


```R
rad.filt <- vcf2genind(paste0(filtsuf,".recode.vcf"),filename=filtsuf,
                      common.markers = T, strata="./OL-c85t10-x45.strata", 
                      pop.levels = c("Klaskino_BC","Barkley_BC","Ladysmith_BC","Victoria_BC","Discovery_WA","Liberty_WA","TritonCove_WA","NorthBay_WA","Willapa_WA","Netarts_OR","Yaquina_OR","Coos_OR","Humboldt_CA","Tomales_CA","NorthSanFran_CA","SouthSanFran_CA","Elkhorn_CA","MuguLagoon_CA","SanDiego_CA"),
                      parallel.core = 1)
```

    VCF is biallelic


    Reading 13136 / 13136 loci.
    Done.


        number of markers with REF/ALT change(s) = 0
    Using markers common in all populations:
        Number of markers before/blacklisted/after:13136/63/13073
    Scanning for monomorphic markers...
        Number of markers before/blacklisted/after: 13073/0/13073
    
    Tidy genomic data:
        Number of common markers: 13073
        Number of chromosome/contig/scaffold: 6058
        Number of individuals: 117
        Number of populations: 19
    
    Writing tidy data set:
    OL-c85t10-x45m75-maf025-neutI2.rad



```R
rad.u <- vcf2genind(paste0(filtsuf,"-u.vcf"),filename=paste0(filtsuf,"-u"),
                      common.markers = T, strata="./OL-c85t10-x45.strata", 
                      pop.levels = c("Klaskino_BC","Barkley_BC","Ladysmith_BC","Victoria_BC","Discovery_WA","Liberty_WA","TritonCove_WA","NorthBay_WA","Willapa_WA","Netarts_OR","Yaquina_OR","Coos_OR","Humboldt_CA","Tomales_CA","NorthSanFran_CA","SouthSanFran_CA","Elkhorn_CA","MuguLagoon_CA","SanDiego_CA"),
                      parallel.core = 1)
```

    VCF is biallelic


    Reading 6079 / 6079 loci.
    Done.


        number of markers with REF/ALT change(s) = 0
    Using markers common in all populations:
        Number of markers before/blacklisted/after:6079/22/6057
    Scanning for monomorphic markers...
        Number of markers before/blacklisted/after: 6057/0/6057
    
    Tidy genomic data:
        Number of common markers: 6057
        Number of chromosome/contig/scaffold: 6057
        Number of individuals: 117
        Number of populations: 19
    
    Writing tidy data set:
    OL-c85t10-x45m75-maf025-neutI2-u.rad



```R
info <- as.data.frame(read.table("./OL-c85t10-x45.strata",header = T,sep = "\t",stringsAsFactors = F))

mystrats <- as.data.frame(matrix(,nrow = length(indNames(rad.filt$genind.no.imputation)),ncol=5))
colnames(mystrats) <- c("POPULATION","LOCATION","REGION","LATITUDE","LONGITUDE")

for(i in 1:nrow(info)){
    j <- grep(gsub("_","-",info[i,1]),indNames(rad.filt$genind.no.imputation),value=FALSE)
    mystrats[j,1] <-info$STRATA[i] 
    mystrats[j,2] <-info$LOCATION[i] 
    mystrats[j,3] <-info$REGION[i]
    mystrats[j,4] <-info$LATITUDE[i]
    mystrats[j,5] <-info$LONGITUDE[i]
}
just.strats <- select(mystrats,c("POPULATION","LOCATION","REGION"))
stratted.filt <- strata(rad.filt$genind.no.imputation, formula= REGION/POPULATION/LOCATION, combine = TRUE,just.strats)
stratted.filt@other <- select(mystrats, LATITUDE,LONGITUDE)

```


```R
save(stratted.filt, file=paste(filtsuf,"-filt.genind",sep=""))
```


```R
stratted.u <- strata(rad.u$genind.no.imputation, formula= REGION/POPULATION/LOCATION, combine = TRUE,just.strats)
stratted.u@other <- select(mystrats, LATITUDE,LONGITUDE)
save(stratted.u, file=paste(filtsuf,"-u.genind",sep=""))
```

## Make hierfstat object


```R
hf.filt <- vcf2hierfstat(paste0(filtsuf,".recode.vcf"),filename=paste0(filtsuf,"-filt"),
                      common.markers = T, strata="./OL-c85t10-x45.strata", 
                      pop.levels = c("Klaskino_BC","Barkley_BC","Ladysmith_BC","Victoria_BC","Discovery_WA","Liberty_WA","TritonCove_WA","NorthBay_WA","Willapa_WA","Netarts_OR","Yaquina_OR","Coos_OR","Humboldt_CA","Tomales_CA","NorthSanFran_CA","SouthSanFran_CA","Elkhorn_CA","MuguLagoon_CA","SanDiego_CA"),
                      parallel.core = 1)
```

    VCF is biallelic


    Reading 13136 / 13136 loci.
    Done.


        number of markers with REF/ALT change(s) = 0
    Using markers common in all populations:
        Number of markers before/blacklisted/after:13136/63/13073
    Scanning for monomorphic markers...
        Number of markers before/blacklisted/after: 13073/0/13073
    
    Tidy genomic data:
        Number of common markers: 13073
        Number of chromosome/contig/scaffold: 6058
        Number of individuals: 117
        Number of populations: 19
        * Number of sample pop, np = 19
        * Number of markers, nl = 13073
        * The highest number used to label an allele, nu = 4
        * The alleles are encoded with one digit number
    
    Writing tidy data set:
    OL-c85t10-x45m75-maf025-neutI2-filt.rad



```R
hf.filt <- hf.filt$hierfstat.no.imputation
save(hf.filt, file=paste0(filtsuf,"-filt.hf"))
```

## Make input for Structure
Uses the`rad.filt$tidy.data` object created when converting to a `genind` object. Not done on the "unlinked" dataset.


```R
write_structure(rad.filt$tidy.data, filename=paste0(filtsuf,"-filt"))
```

## Make input for Treemix
Use only the unlinked dataset. Uses a python script I wrote to convert a genpop object to Treemix input.


```R
# Convert genind object to genpop object
gp <- genind2genpop(stratted.u,pop=strata(stratted.u)$POPULATION)
# Write genpop object as a table
write.table(gp$tab, file=paste0(filtsuf,"-u.gp"),sep = "\t",row.names = T,col.names = T,quote = F )
# Use python script to convert to TreeMix format, can also be run normally in Terminal
system('python ../Scripts/genpop2Treemix.py OL-c85t10-x45m75-maf025-neutI2-u.gp OL-c85t10-x45m75-neutI2-u.pop.TM')
# Gzip the TreeMix input
system('gzip OL-c85t10-x45m75-neutI2-u.pop.TM',intern = T)
```

    
     Converting data from a genind to a genpop object... 
    
    ...done.
    






## Make EEMS input file 

Code to calculate the .diffs matrix for EEMS, taken from [EEMS github](https://github.com/dipetkov/eems/tree/master/str2diffs).


```R
# V1 methtod to get diffs matrix, preferred
bed2diffs_v1 <- function(Geno) {
  nIndiv <- nrow(Geno)
  nSites <- ncol(Geno)
  Diffs <- matrix(0, nIndiv, nIndiv)
  
  for (i in seq(nIndiv - 1)) {
    for (j in seq(i + 1, nIndiv)) {
      x <- Geno[i, ]
      y <- Geno[j, ]
      Diffs[i, j] <- mean((x - y)^2, na.rm = TRUE)
      Diffs[j, i] <- Diffs[i, j]
    }
  }
  Diffs
}
# V2 method to get .diffs matrix, only if V1 doesn't work
bed2diffs_v2 <- function(Geno) {
  nIndiv <- nrow(Geno)
  nSites <- ncol(Geno)
  Miss <- is.na(Geno)
  ## Impute NAs with the column means (= twice the allele frequencies)
  Mean <- matrix(colMeans(Geno, na.rm = TRUE), ## a row of means
                 nrow = nIndiv, ncol = nSites, byrow = TRUE) ## a matrix with nIndiv identical rows of means
  Mean[Miss == 0] <- 0 ## Set the means that correspond to observed genotypes to 0
  Geno[Miss == 1] <- 0 ## Set the missing genotypes to 0 (used to be NA) 
  Geno <- Geno + Mean
  ## Compute similarities
  Sim <- Geno %*% t(Geno) / nSites
  SelfSim <- diag(Sim) ## self-similarities
  vector1s <- rep(1, nIndiv) ## vector of 1s
  ## This chunk generates a `diffs` matrix
  Diffs <- SelfSim %*% t(vector1s) + vector1s %*% t(SelfSim) - 2 * Sim
  Diffs
}
```

I exclude all samples from Coos Bay (OR1), as we now know it is an anthropogenic migration event. Code to convert a genind object to format amenable to EEMS is also from [EEMS github](https://github.com/dipetkov/eems/tree/master/str2diffs).


```R
# Drop OR1 samples
gind.xOR <- stratted.filt[!(indNames(stratted.filt) %in% c("OR1-1-C6","OR1-2-C5","OR1-6-C3","OR1-7-C6","OR1-12-C8","OR1-4-C5")),drop=TRUE]

# Set suffix for EEMS input files
suf <- "OLxOR1-t10x45m75-maf025-neutI2-filt"

# From EEMS github
geno <- gind.xOR@tab
stopifnot(identical(gind.xOR@type, 'codom'))
# Get rid of non-biallelic loci
multi.loci <- names(which(gind.xOR@loc.n.all != 2))
multi.cols <- which(grepl(paste0("^", multi.loci, "\\.\\d+$", collapse = "|"), colnames(geno)))
if (length(multi.cols)) geno <- geno[, - multi.cols]
nloci <- dim(geno)[2] / 2
# Choose allele to be "derived" allele.
geno <- geno[, c(seq(1,ncol(geno),by = 2))]

# Get dimensions of matrix
dim(geno)
```


<ol class=list-inline>
	<li>111</li>
	<li>13073</li>
</ol>




```R
# 111 inds, 13,073 loci
# bed2diffs functions  
diffs.v1 <- bed2diffs_v1(geno)
diffs.v2 <- bed2diffs_v2(geno)
# Round to 6 digits
diffs.v1 <- round(diffs.v1, digits = 6)
diffs.v2 <- round(diffs.v2, digits = 6)
```

Check that the dissimilarity matrix has one positive eigenvalue and nIndiv-1 negative eigenvalues, as required by a full-rank Euclidean distance matrix. If the V1 method does not make a Euclidean matrix, you must use V2. 

**note**: the outlier dataset did not produce a Euclidean matrix by either method.


```R
tail(sort(round(eigen(diffs.v1)$values, digits = 2)))
```


<ol class=list-inline>
	<li>-0.22</li>
	<li>-0.2</li>
	<li>-0.17</li>
	<li>-0.15</li>
	<li>-0.01</li>
	<li>56.82</li>
</ol>




```R
tail(sort(round(eigen(diffs.v2)$values, digits = 2)))
```


<ol class=list-inline>
	<li>-0.18</li>
	<li>-0.17</li>
	<li>-0.17</li>
	<li>-0.17</li>
	<li>-0.04</li>
	<li>48.41</li>
</ol>



Write files for V1.


```R
write.table(diffs.v1, paste(suf,".v1.diffs",sep=""), 
            col.names = FALSE, row.names = FALSE, quote = FALSE)
```


```R
## Get gps coordinates from previously created info matrix
xOR.info <- dplyr::filter(info, !grepl("OR1",INDIVIDUALS))
gps_matrix <- matrix(,nrow = length(indNames(gind.xOR)),ncol=2)

for(i in 1:nrow(xOR.info)){
    j <- grep(gsub("_","-",xOR.info[i,1]),indNames(gind.xOR),value=FALSE)
    gps_matrix[j,1] <-xOR.info$LONGITUDE[i]
    gps_matrix[j,2] <-xOR.info$LATITUDE[i]
}
```


```R
#write .coord file
write.table(gps_matrix, paste(suf,".v1.coord",sep=""),col.names = FALSE, row.names = FALSE,quote = FALSE)
```

# Outlier dataset


```R
#set filename suffix
filtsuf = "OL-c85t10-x45m75-maf025-outI2Union"
```

Similar as above


```R
rad.filt <- vcf2genind(paste0(filtsuf,".recode.vcf"),filename=filtsuf,
                      common.markers = T, strata="./OL-c85t10-x45.strata", 
                      pop.levels = c("Klaskino_BC","Barkley_BC","Ladysmith_BC","Victoria_BC","Discovery_WA","Liberty_WA","TritonCove_WA","NorthBay_WA","Willapa_WA","Netarts_OR","Yaquina_OR","Coos_OR","Humboldt_CA","Tomales_CA","NorthSanFran_CA","SouthSanFran_CA","Elkhorn_CA","MuguLagoon_CA","SanDiego_CA"),
                      parallel.core = 1)
```

    VCF is biallelic


    Reading 235 / 235 loci.
    Done.


        number of markers with REF/ALT change(s) = 0
    Using markers common in all populations:
        Number of markers before/blacklisted/after:235/0/235
    Scanning for monomorphic markers...
        Number of markers before/blacklisted/after: 235/0/235
    
    Tidy genomic data:
        Number of common markers: 235
        Number of chromosome/contig/scaffold: 129
        Number of individuals: 117
        Number of populations: 19
    
    Writing tidy data set:
    OL-c85t10-x45m75-maf025-outI2Union.rad



```R
rad.u <- vcf2genind(paste0(filtsuf,"-u.vcf"),filename=paste0(filtsuf,"-u"),
                      common.markers = T, strata="./OL-c85t10-x45.strata", 
                      pop.levels = c("Klaskino_BC","Barkley_BC","Ladysmith_BC","Victoria_BC","Discovery_WA","Liberty_WA","TritonCove_WA","NorthBay_WA","Willapa_WA","Netarts_OR","Yaquina_OR","Coos_OR","Humboldt_CA","Tomales_CA","NorthSanFran_CA","SouthSanFran_CA","Elkhorn_CA","MuguLagoon_CA","SanDiego_CA"),
                      parallel.core = 1)
```

    VCF is biallelic


    Reading 129 / 129 loci.
    Done.


        number of markers with REF/ALT change(s) = 0
    Using markers common in all populations:
        Number of markers before/blacklisted/after:129/0/129
    Scanning for monomorphic markers...
        Number of markers before/blacklisted/after: 129/0/129
    
    Tidy genomic data:
        Number of common markers: 129
        Number of chromosome/contig/scaffold: 129
        Number of individuals: 117
        Number of populations: 19
    
    Writing tidy data set:
    OL-c85t10-x45m75-maf025-outI2Union-u.rad



```R
info <- as.data.frame(read.table("./OL-c85t10-x45.strata",header = T,sep = "\t",stringsAsFactors = F))

mystrats <- as.data.frame(matrix(,nrow = length(indNames(rad.filt$genind.no.imputation)),ncol=5))
colnames(mystrats) <- c("POPULATION","LOCATION","REGION","LATITUDE","LONGITUDE")

for(i in 1:nrow(info)){
    j <- grep(gsub("_","-",info[i,1]),indNames(rad.filt$genind.no.imputation),value=FALSE)
    mystrats[j,1] <-info$STRATA[i] 
    mystrats[j,2] <-info$LOCATION[i] 
    mystrats[j,3] <-info$REGION[i]
    mystrats[j,4] <-info$LATITUDE[i]
    mystrats[j,5] <-info$LONGITUDE[i]
}
just.strats <- select(mystrats,c("POPULATION","LOCATION","REGION"))
stratted.filt <- strata(rad.filt$genind.no.imputation, formula= REGION/POPULATION/LOCATION, combine = TRUE,just.strats)
stratted.filt@other <- select(mystrats, LATITUDE,LONGITUDE)

```


```R
save(stratted.filt, file=paste(filtsuf,"-filt.genind",sep=""))
```


```R
stratted.u <- strata(rad.u$genind.no.imputation, formula= REGION/POPULATION/LOCATION, combine = TRUE,just.strats)
stratted.u@other <- select(mystrats, LATITUDE,LONGITUDE)
save(stratted.u, file=paste(filtsuf,"-u.genind",sep=""))
```

## Make hierfstat 


```R
hf.filt <- vcf2hierfstat(paste0(filtsuf,".recode.vcf"),filename=paste0(filtsuf,"-filt"),
                      common.markers = T, strata="./OL-c85t10-x45.strata", 
                      pop.levels = c("Klaskino_BC","Barkley_BC","Ladysmith_BC","Victoria_BC","Discovery_WA","Liberty_WA","TritonCove_WA","NorthBay_WA","Willapa_WA","Netarts_OR","Yaquina_OR","Coos_OR","Humboldt_CA","Tomales_CA","NorthSanFran_CA","SouthSanFran_CA","Elkhorn_CA","MuguLagoon_CA","SanDiego_CA"),
                      parallel.core = 1)
```

    VCF is biallelic


    Reading 235 / 235 loci.
    Done.


        number of markers with REF/ALT change(s) = 0
    Using markers common in all populations:
        Number of markers before/blacklisted/after:235/0/235
    Scanning for monomorphic markers...
        Number of markers before/blacklisted/after: 235/0/235
    
    Tidy genomic data:
        Number of common markers: 235
        Number of chromosome/contig/scaffold: 129
        Number of individuals: 117
        Number of populations: 19
        * Number of sample pop, np = 19
        * Number of markers, nl = 235
        * The highest number used to label an allele, nu = 4
        * The alleles are encoded with one digit number
    
    Writing tidy data set:
    OL-c85t10-x45m75-maf025-outI2Union-filt.rad



```R
hf.filt <- hf.filt$hierfstat.no.imputation
save(hf.filt, file=paste0(filtsuf,"-filt.hf"))
```

### Make input for Structure


```R
#Use the previously created tidy datasets from radiator
write_structure(rad.filt$tidy.data, filename=paste0(filtsuf,"-filt"))
```

### Plot EEMS Results
Do after you have run EEMS.

#### Maf 0.025

Make a list of all EEMS directories to plot all the results into 1 plot:


```R
path = "../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/"
dirs = c(paste0(path,"OLxOR1-m80x60-maf025-W-nD200-ch1"),paste0(path,"OLxOR1-m80x60-maf025-W-nD200-ch2"), 
         paste0(path,"OLxOR1-m80x60-maf025-W-nD300-ch1"),paste0(path,"OLxOR1-m80x60-maf025-W-nD300-ch2"))
```


```R
eems.plots(mcmcpath = dirs, plotpath = paste0(path,"OLxOR1-m80x60-maf025-W-All-plots"),
           longlat = T,add.grid=F,add.outline = T,add.demes = T,
           projection.in = "+proj=longlat +datum=WGS84",projection.out = "+proj=merc +datum=WGS84",
           add.map = T,add.abline = T, add.r.squared = T)
```

    Input projection: +proj=longlat +datum=WGS84
    Output projection: +proj=merc +datum=WGS84
    
    
    
    Loading rgdal (required by projection.in)
    Loading rworldmap (required by add.map)
    Loading rworldxtra (required by add.map)
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    Processing the following EEMS output directories :
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch1../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch2../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch1../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch2
    Plotting effective migration surface (posterior mean of m rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch2
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch2
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting effective diversity surface (posterior mean of q rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch2
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch2
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting posterior probability trace
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch2
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch2
    Plotting average dissimilarities within and between demes
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch2
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch1
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    EEMS results for at least two different population grids



```R
for(dir in dirs){
    eems.plots(mcmcpath = dir, plotpath = paste0(dir,"-plots"),
           longlat = T,add.grid=F,add.outline = T,add.demes = T,
           projection.in = "+proj=longlat +datum=WGS84",projection.out = "+proj=merc +datum=WGS84",
           add.map = T,add.abline = T, add.r.squared = T)
}

```

    Input projection: +proj=longlat +datum=WGS84
    Output projection: +proj=merc +datum=WGS84
    
    
    
    Loading rgdal (required by projection.in)
    Loading rworldmap (required by add.map)
    Loading rworldxtra (required by add.map)
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    Processing the following EEMS output directories :
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch1
    Plotting effective migration surface (posterior mean of m rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch1
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting effective diversity surface (posterior mean of q rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch1
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting posterior probability trace
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch1
    Plotting average dissimilarities within and between demes
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch1
    Input projection: +proj=longlat +datum=WGS84
    Output projection: +proj=merc +datum=WGS84
    
    
    
    Loading rgdal (required by projection.in)
    Loading rworldmap (required by add.map)
    Loading rworldxtra (required by add.map)
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    Processing the following EEMS output directories :
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch2
    Plotting effective migration surface (posterior mean of m rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch2
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting effective diversity surface (posterior mean of q rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch2
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting posterior probability trace
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch2
    Plotting average dissimilarities within and between demes
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD200-ch2
    Input projection: +proj=longlat +datum=WGS84
    Output projection: +proj=merc +datum=WGS84
    
    
    
    Loading rgdal (required by projection.in)
    Loading rworldmap (required by add.map)
    Loading rworldxtra (required by add.map)
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    Processing the following EEMS output directories :
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch1
    Plotting effective migration surface (posterior mean of m rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch1
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting effective diversity surface (posterior mean of q rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch1
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting posterior probability trace
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch1
    Plotting average dissimilarities within and between demes
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch1
    Input projection: +proj=longlat +datum=WGS84
    Output projection: +proj=merc +datum=WGS84
    
    
    
    Loading rgdal (required by projection.in)
    Loading rworldmap (required by add.map)
    Loading rworldxtra (required by add.map)
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    Processing the following EEMS output directories :
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch2
    Plotting effective migration surface (posterior mean of m rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch2
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting effective diversity surface (posterior mean of q rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch2
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting posterior probability trace
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch2
    Plotting average dissimilarities within and between demes
    ../../EEMS/Choosing/OLxOR1-m80x60-maf025_results/OLxOR1-m80x60-maf025-W-nD300-ch2


#### All SNPs

Make a list of all EEMS directories to plot all the results into 1 plot:


```R
path = "../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/"
dirs = c(paste0(path,"OLxOR1-m80x60-mac2-W-nD200-ch1"),paste0(path,"OLxOR1-m80x60-mac2-W-nD200-ch2"), 
         paste0(path,"OLxOR1-m80x60-mac2-W-nD300-ch1"),paste0(path,"OLxOR1-m80x60-mac2-W-nD300-ch2"))
```


```R
eems.plots(mcmcpath = dirs, plotpath = paste0(path,"OLxOR1-m80x60-mac2-W-All-plots"),
           longlat = T,add.grid=F,add.outline = T,add.demes = T,
           projection.in = "+proj=longlat +datum=WGS84",projection.out = "+proj=merc +datum=WGS84",
           add.map = T,add.abline = T, add.r.squared = T)
```

    Input projection: +proj=longlat +datum=WGS84
    Output projection: +proj=merc +datum=WGS84
    
    
    
    Loading rgdal (required by projection.in)
    Loading rworldmap (required by add.map)
    Loading rworldxtra (required by add.map)
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    Processing the following EEMS output directories :
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch1../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch2../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch1../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch2
    Plotting effective migration surface (posterior mean of m rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch2
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch2
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting effective diversity surface (posterior mean of q rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch2
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch2
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting posterior probability trace
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch2
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch2
    Plotting average dissimilarities within and between demes
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch1
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch2
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch1
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    EEMS results for at least two different population grids



```R
for(dir in dirs){
    eems.plots(mcmcpath = dir, plotpath = paste0(dir,"-plots"),
           longlat = T,add.grid=F,add.outline = T,add.demes = T,
           projection.in = "+proj=longlat +datum=WGS84",projection.out = "+proj=merc +datum=WGS84",
           add.map = T,add.abline = T, add.r.squared = T)
}

```

    Input projection: +proj=longlat +datum=WGS84
    Output projection: +proj=merc +datum=WGS84
    
    
    
    Loading rgdal (required by projection.in)
    Loading rworldmap (required by add.map)
    Loading rworldxtra (required by add.map)
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    Processing the following EEMS output directories :
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch1
    Plotting effective migration surface (posterior mean of m rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch1
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting effective diversity surface (posterior mean of q rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch1
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting posterior probability trace
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch1
    Plotting average dissimilarities within and between demes
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch1
    Input projection: +proj=longlat +datum=WGS84
    Output projection: +proj=merc +datum=WGS84
    
    
    
    Loading rgdal (required by projection.in)
    Loading rworldmap (required by add.map)
    Loading rworldxtra (required by add.map)
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    Processing the following EEMS output directories :
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch2
    Plotting effective migration surface (posterior mean of m rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch2
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting effective diversity surface (posterior mean of q rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch2
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting posterior probability trace
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch2
    Plotting average dissimilarities within and between demes
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD200-ch2
    Input projection: +proj=longlat +datum=WGS84
    Output projection: +proj=merc +datum=WGS84
    
    
    
    Loading rgdal (required by projection.in)
    Loading rworldmap (required by add.map)
    Loading rworldxtra (required by add.map)
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    Processing the following EEMS output directories :
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch1
    Plotting effective migration surface (posterior mean of m rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch1
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting effective diversity surface (posterior mean of q rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch1
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting posterior probability trace
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch1
    Plotting average dissimilarities within and between demes
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch1
    Input projection: +proj=longlat +datum=WGS84
    Output projection: +proj=merc +datum=WGS84
    
    
    
    Loading rgdal (required by projection.in)
    Loading rworldmap (required by add.map)
    Loading rworldxtra (required by add.map)
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Using 'euclidean' distance to assign interpolation points to Voronoi tiles.
    
    
    
    Processing the following EEMS output directories :
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch2
    Plotting effective migration surface (posterior mean of m rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch2
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting effective diversity surface (posterior mean of q rates)
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch2
    Using the default DarkOrange to Blue color scheme, with 'white' as the midpoint color.
    It combines two color schemes from the 'dichromat' package, which itself is based on
    a collection of color schemes for scientific data graphics:
    	Light A and Bartlein PJ (2004). The End of the Rainbow? Color Schemes for Improved Data
    	Graphics. EOS Transactions of the American Geophysical Union, 85(40), 385.
    See also http://geog.uoregon.edu/datagraphics/color_scales.htm
    
    
    
    Plotting posterior probability trace
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch2
    Plotting average dissimilarities within and between demes
    ../../EEMS/Choosing/OLxOR1-m80x60-mac2_results/OLxOR1-m80x60-mac2-W-nD300-ch2


# Outlier


```R

```
