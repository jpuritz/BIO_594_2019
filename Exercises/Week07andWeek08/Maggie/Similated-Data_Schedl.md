# Analysis of Simulated Data for Week 7-8

### Maggie Schedl
#### Written on April 4th 2019

After logging into my KITT account
```
mkdir Week7_8  
cd Week7_8  
mkdir Simulated  
mkdir Real  
cd Simulated  
ln -s /home/BIO594/Exercises/Week07_and_Week_08/simulated/* .  
cd ..  
cd Real  
ln -s /home/BIO594/Exercises/Week07_and_Week_08/realdata/* .  
cd ..  
conda create -n Week78 ddocent   
conda activate Week78
```

### Calling SNPs with ddocent

```
dDocent  
80 processors  
0 max memory  
yes Trimming  
yes Assembly  
PE Assembly  
0.9 Cluster Similarity  
yes Map Reads  
1 Match Value  
4 Mismatch Value  
6 Gap Open Value  
YES Call SNPS  
```

First cuttoff: **6**

Second cutoff: **5**

### SNP filtering with vcftools  
What do I want to filter by?  
[vscftools website with all the options](https://vcftools.github.io/man_latest.html)

```
mkdir Filter
cd Filter/
ln -s ../TotalRawSNPs.vcf .
```
First filter by amount of missing data, minor allele frequency, minor allele count, and minimum quality score. Missing  data being: Exclude sites on the basis of the proportion of missing data (defined to be between 0 and 1, where 0 allows sites that are completely missing and 1 indicates no missing data allowed). I don't want a lot of missing data so I said less than half. The --mac 3 flag tells it to filter SNPs that have a minor allele count less than 3. In terms of genotypes it has to be called in at least 1 homozygote and 1 heterozygote or 3 heterozygotes.

```
vcftools --vcf TotalRawSNPs.vcf --max-missing 0.4 --maf 0.001 --mac 3 --minQ 20 --recode --recode-INFO-all --out TRS
```
**Output:  
After filtering, kept 80 out of 80 Individuals  
Outputting VCF file...  
After filtering, kept 1922 out of a possible 3025 Sites  
Run Time = 2.00 seconds**  

That is a lot, but I'm going to keep going.  
What about depth of coverage? I don't know much about this simulated data but I'm going to say at least 6 times coverage.  
```
vcftools --vcf TRS.recode.vcf --minDP 6 --recode --recode-INFO-all --out TRSdp6
```
**Output:  
After filtering, kept 80 out of 80 Individuals  
Outputting VCF file...  
After filtering, kept 1922 out of a possible 1922 Sites  
Run Time = 1.00 seconds**  
Ok that kept everything but good to check.

What about genotype call rate based on the population the samples are from? We have a popmap file in the directory above that can help with this, and I had previously downloaded a script that helps with this.
```
pop_missing_filter.sh TRSdp6.recode.vcf ../popmap 0.05 1 TRSdp6p05
```
**Output:  
After filtering, kept 80 out of 80 Individuals  
Outputting VCF file...  
After filtering, kept 1750 out of a possible 1922 Sites  
Run Time = 1.00 seconds**  

There is another script I can use to help automate filtering. All code can be found [here](https://github.com/jpuritz/dDocent/blob/master/scripts/dDocent_filters)
```
dDocent_filters TRSdp6p05.recode.vcf TRSdp6p05DF
```
Looks like the end of the distribution is around 68, so that was the max mean depth cuttoff I set. Loci with really high mean depth are likely paralogs.

**Ouput:  
Number of sites filtered based on maximum mean depth  
 17 of 1708  
Number of sites filtered based on within locus depth mismatch  
 0 of 1594  
Total number of sites filtered  
 156 of 1750  
Remaining sites  
 1594**  

 Another good thing is to filter by HWE. This needs to be done by population. But the file needs only contain SNPs and not complex variants like INDELs before using a [script](https://github.com/jpuritz/dDocent/blob/master/scripts/filter_hwe_by_pop.pl) to filter by HWE.
```
vcfallelicprimitives -k -g TRSdp6p05DF.FIL.recode.vcf |sed 's:\.|\.:\.\/\.:g' > TRSdp6p05DFF.prim  
vcftools --vcf TRSdp6p05DFF.prim --recode --recode-INFO-all --remove-indels --out SNP.TRSdp6p05DFF
```
**Output:  
After filtering, kept 80 out of 80 Individuals  
Outputting VCF file...  
After filtering, kept 1368 out of a possible 1700 Sites  
Run Time = 0.00 seconds**

```
filter_hwe_by_pop.pl -v SNP.TRSdp6p05DFF.recode.vcf -p ../popmap -c 0.5 -out SNP.TRSdp6p05DFFHWE
```
**Output:  
Processing population: PopA (20 inds)  
Processing population: PopB (20 inds)  
Processing population: PopC (20 inds)  
Processing population: PopD (20 inds)  
Outputting results of HWE test for filtered loci to 'filtered.hwe'  
Kept 1368 of a possible 1368 loci (filtered 0 loci)**  

Ok this is simulated data so maybe there wasn't anything to filter here.  

Filtering one more time for minor allele frequency.
```
vcftools --vcf SNP.TRSdp6p05DFFHWE.recode.vcf --maf 0.05 --recode --recode-INFO-all --out SNP.TRSdp6p05DFFHWEmaf05
```
**Output:  
After filtering, kept 80 out of 80 Individuals  
Outputting VCF file...  
After filtering, kept 891 out of a possible 1368 Sites  
Run Time = 0.00 seconds**  

This has hugely cut down on the SNPs! But hopefully these are good ones.

### Outlier Detection using [BayeScan](http://cmpg.unibe.ch/software/BayeScan/) and PCAdapt  
I like PCAs because there are no assumptions and I like a Bayesian approach because it seems more complex and therefore accurate to me. Plus these two programs work very differently so it'll be good to compare the two.

**BayeScan** needs some specific file configuration first. I need to move the popmap  to this directory (still in Filter) and the plot_R.r file for afterwards.
```
ln -s ../popmap .
cp ../plot_R.r .
```

```
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.TRSdp6p05DFFHWEmaf05.recode.vcf -outputfile SNP.TRSdp6p05DFFHWEBS -spid BSsnp.spid
```
Running BayeScan
```
BayeScan2.1_linux64bits SNP.TRSdp6p05DFFHWEBS -nbp 30 -thin 20
```

The output from this is going to come from making the graph R Studio. Find all R code in the Week7-8-Simulated.Rmd file.


**PCAdapt** also needs a specific file: SNPs that are only bi-allelic.

```
vcftools --vcf SNP.TRSdp6p05DFFHWEmaf05.recode.vcf --max-alleles 2 --recode --recode-INFO-all --out SNP.TRSdp6p05DFFHWE2A
```
**Output:  
After filtering, kept 80 out of 80 Individuals  
Outputting VCF file...  
After filtering, kept 888 out of a possible 891 Sites  
Run Time = 0.00 seconds**  

The rest of this analysis is also in the Week7-8-Simulated.Rmd file.

BayeScan identified 3 outliers: 178, 614 and 615
PCAdapt identified 2 outliers: 145 and 146

**Removing Outlier SNPs**

This is the format of the vcf file so I have to search for the outliers to get their CHROM and position to make the type of file vcftools --exclude-positions needs.  
CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  

I think the number BayeScan and PCAdapt spits out is the line number in the vcf file. I came to this conclusion by searching for the # in the second column and getting a lot of contigs, so that was probably not it there should be only one for  one outlier SNP. And then I searched for the dDocent_Contig_# and that almost made sense but then I didn't have a dDocent_Contig_145 so that can't be right because PCAdapt can't say something that doesn't exist is an outlier. So my final conclusion is that it's the line number in the vcf file.

If you use less +# -N vcf file it will take you to and show you the line number you search for. I copied and pasted the  CHROM and POS sections into here, then made a separate file to recode the vcf with.

```
less +178 -N SNP.TRSdp6p05DFFHWEmaf05.recode.vcf  
```
**dDocent_Contig_69       30**
```
less +615 -N SNP.TRSdp6p05DFFHWEmaf05.recode.vcf
```
**dDocent_Contig_491      34**
```
less +614 -N SNP.TRSdp6p05DFFHWEmaf05.recode.vcf
```
**dDocent_Contig_490      150**
```
less +145 -N SNP.TRSdp6p05DFFHWE2A.recode.vcf
```
**dDocent_Contig_50       161**
```
less +146 -N SNP.TRSdp6p05DFFHWE2A.recode.vcf
```
**dDocent_Contig_51       205**

```
nano PCA-BS-outliers
dDocent_Contig_69       30
dDocent_Contig_491      34
dDocent_Contig_490      150
dDocent_Contig_50       161
dDocent_Contig_51       205
```
```
vcftools --vcf SNP.TRSdp6p05DFFHWEmaf05.recode.vcf --exclude-positions PCA-BS-outliers  --recode --recode-INFO-all --out SNP.TRSdp6p05DFFHWE.neutral.BS-PCA
```
**Output:  
After filtering, kept 80 out of 80 Individuals  
Outputting VCF file...  
After filtering, kept 886 out of a possible 891 Sites  
Run Time = 0.00 seconds**  

Next is to make a different type of PCA (principle components analysis) and a DAPC (discriminant analysis of principle components) with only the neutral SNPs. I made the neutral set with the vcf with more than bi-allelic SNPs so I need to recode for max alleles again.
```
vcftools --vcf SNP.TRSdp6p05DFFHWE.neutral.BS-PCA.recode.vcf --max-alleles 2 --recode --recode-INFO-all --out SNP.TRSdp6p05DFFHWE2A.neutral.BS-PCA
```
**Output:  
After filtering, kept 80 out of 80 Individuals  
Outputting VCF file...  
After filtering, kept 883 out of a possible 886 Sites  
Run Time = 0.00 seconds**  

for adegenet need to have a strata file that is both population and library info. This is the LibraryInfo file in the directory above

```
cp ../LibraryInfo .
```

Back into the Week7-8-Simulated.Rmd file.



try bayenv on Simulated
To Run BayEnv the file needs to be configured again.

```
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.TRSdp6p05DFFHWE2A.recode.vcf -outputfile SNP.TRSdp6p05DFFHWE2A.txt -spid SNPBayEnv.spid
```
Now use BayEnv to make a covariance matrix
```
bayenv2 -i SNP.TRSdp6p05DFFHWE2A.txt -p 4 -k 100000 -r 63479 > matrix.out
```
Take the last 4 lines
```
tail -5 matrix.out | head -4 > matrix
```
Make the calculation matrix
```
calc_bf.sh SNP.TRSdp6p05DFFHWE2A.txt environ matrix 4 10000 2
```
convert it into the format for R
```
paste <(seq 1 883) <(cut -f2,3 bf_environ.environ ) > bayenv.out
cat <(echo -e "Locus\tBF1\tBF2") bayenv.out > bayenv.final
```
