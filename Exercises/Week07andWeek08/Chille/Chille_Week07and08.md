## Week 7 and 8 Assignment
Author: E. Chille

### Simulated Data

**Call SNPs**

Create working directory
```
mkdir week07and8
cd week07and8
```
Create Conda environment
```
conda create -n Week7and8
conda activate Week7and8
```
Link to data and other tools for filtering and outlier detection
```
ln -s /home/BIO594/Exercises/Week07_and_Week_08/simulated/* .
ln -s ../popmap .
ln ../plot_R.r .
ln ../BSsnp.spid
ls
```
Run dDocent
```
dDocent
```
|Parameter|Input|
|---| :---: |
|Number of individuals| 80|  
|Maximum number of processors| 80|  
|Maximum memory| 0|  
|Quality trimming |yes|  
|Assembly|Yes, PE|
|Clustering similarity|default (0.9)|
|Read mapping|yes|
|BWA read mapping| default (1-4-6)|
|Call SNPs with FreeBayes|yes|
|K1|4|
|K2|8|

++Results++: dDocent assembled 1942 sequences (after cutoffs) into 1000 contigs

#### Filter

Create working directory and link to data
```
mkdir Filter
cd Filter
ln -s ../TotalRawSNPs.vcf .
```
Filter genotypes with:
- Calls below 40% across all individuals
- Minor allele frequency less than 0.1%
- Minor allele count less than 3
- Quality score less than 20 
```
vcftools --vcf TotalRawSNPs.vcf --max-missing 0.4 --maf 0.001 --mac 3 --minQ 20 --recode --recode-INFO-all --out TRS

--> After filtering, kept 80 out of 80 Individuals  
--> After filtering, kept 1922 out of a possible 3025 Sites
```

Filter out reads with a minimum depth coverage of 5 calls
```
vcftools --vcf TRS.recode.vcf --minDP 5 --recode --recode-INFO-all --out TRSdp5

--> After filtering, kept 80 out of 80 Individuals  
--> After filtering, kept 1922 out of a possible 1922 Sites
```

Filter by a population specific call rate of 5% using popmap file from previous directory
```
pop_missing_filter.sh TRSdp5.recode.vcf ../popmap 0.05 1 TRSdp5p05

--> After filtering, kept 80 out of 80 Individuals  
--> After filtering, kept 1797 out of a possible 1922 Sites
```
Automate filtering using dDocent_filters
```
dDocent_filters TRSdp5p05.recode.vcf TRSdp5p05
# Max mean depth cutoff: 68

--> Number of sites filtered based on maximum mean depth: 17 of 1752  
--> Number of sites filtered based on within locus depth mismatch: 0 of 1636  
--> Total number of sites filtered: 161 of 1797  
--> Remaining sites: 1636 
```
Create a prim file for further filtering
```
vcfallelicprimitives -k -g TRSdp5p05.FIL.recode.vcf |sed 's:\.|\.:\.\/\.:g' > TRSdp5p05F.prim
```
Filter out indels and filter by hwe
```
vcftools --vcf TRSdp5p05F.prim --recode --recode-INFO-all --remove-indels --out SNP.TRSdp5p05F

--> After filtering, kept 80 out of 80 Individuals  
--> After filtering, kept 1407 out of a possible 1744 Sites

filter_hwe_by_pop.pl -v SNP.TRSdp5p05F.recode.vcf -p ../popmap -c 0.5 -out SNP.TRSdp5p05FHWE

--> Kept 1407 of a possible 1407 loci (filtered 0 loci)
```
Filter by Minor Allele Frequency of 5%
```
vcftools --vcf SNP.TRSdp5p05FHWE.recode.vcf --maf 0.05 --recode --recode-INFO-all --out SNP.TRSdp5p05FHWEmaf05

--> After filtering, kept 80 out of 80 Individuals  
--> After filtering, kept 914 out of a possible 1407 Sites
```
#### Convert VCF Files to run outlier detection
For BayeScan: Run PGDspider to convert VCF into a format Bayscan can read
```
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.TRSdp5p05FHWEmaf05.recode.vcf -outputfile SNP.TRSdp5p05FHWEBS -spid BSsnp.spid
```
For PCAdapt: Create VCF containing only bi-allelic SNPs
```
vcftools --vcf SNP.TRSdp5p05FHWEmaf05.recode.vcf --max-alleles 2 --recode --recode-INFO-all --out SNP.TRSdp5p05FHWE2A
```

#### Outlier Detection using BayeScan and PCAdapt
Run Bayescan
```
BayeScan2.1_linux64bits SNP.TRSdp5p05FHWEBS -nbp 30 -thin 20
```
**In R:**

