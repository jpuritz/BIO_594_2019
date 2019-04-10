## Analysis of Real Data for Week 7-8

### Maggie Schedl
#### Written on April 7th 2019

Bring in the data
```
conda activate Week78
cd Week7_8
mkdir Real
cd Real  
ln -s /home/BIO594/Exercises/Week07_and_Week_08/realdata/* .
conda activate Week78
```
Re-doing all filtering from Simulated just to make sure this is in the right format for BayEnv
```
vcftools --vcf SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.recode.vcf --max-missing 0.4 --maf 0.001 --mac 3 --minQ 20 --recode --recode-INFO-all --out SNPSReal
```
After filtering, kept 7295 out of a possible 7303 Sites  

Min depth

```
vcftools --vcf SNPSReal.recode.vcf --minDP 6 --recode --recode-INFO-all --out SNPSRealdp6
```
After filtering, kept 7295 out of a possible 7295 Sites

Missing data by pop
```
pop_missing_filter.sh SNPSRealdp6.recode.vcf ../popmap 0.05 1 SNPSRealdp6p05
```
After filtering, kept 7295 out of a possible 7295 Sites

dDocent filters
```
dDocent_filters SNPSRealdp6p05.recode.vcf SNPSRealdp6p05DF
```
![image](link)

Remove INDELs
```
vcfallelicprimitives -k -g SNPSRealdp6p05DF.FIL.recode.vcf |sed 's:\.|\.:\.\/\.:g' > SNPSRealdp6p05DFF.prim  
vcftools --vcf SNPSRealdp6p05DFF.prim --recode --recode-INFO-all --remove-indels --out SNPSRealdp6p05DFF
```
After filtering, kept 6341 out of a possible 6341 Sites

Filter by HWE by 0.5 of populations
```
filter_hwe_by_pop.pl -v SNPSRealdp6p05DFF.recode.vcf -p popmap -c 0.5 -out SNPSRealdp6p05DFFHWE
```
Kept 6339 of a possible 6341 loci (filtered 2 loci)


Filter for minor allele frequency 0.05
```
vcftools --vcf SNPSRealdp6p05DFFHWE.recode.vcf --maf 0.05 --recode --recode-INFO-all --out SNPSRealdp6p05DFFHWE.MAF
```
After filtering, kept 3986 out of a possible 6339 Sites


Now to run [BayeScan](http://cmpg.unibe.ch/software/BayeScan/) to find outlier SNPs

The popmap, .spid, and the plot_R.r are already in this directory too!  
Configure vcf file
```
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNPSRealdp6p05DFFHWE.MAF.recode.vcf -outputfile SNPSRealdp6p05DFFHWE.MAF.BS -spid BSsnp.spid
```
Run BayeScan
```
BayeScan2.1_linux64bits SNPSRealdp6p05DFFHWE.MAF.BS -nbp 30 -thin 20
```
Found two outlier SNPs: 3132 and 3293


Make sure only bi-alleleic
```
vcftools --vcf SNPSRealdp6p05DFFHWE.MAF.recode.vcf --max-alleles 2 --recode --recode-INFO-all --out SNPSRealdp6p05DFFHWE.MAF.2A
```
After filtering, kept 3952 out of a possible 3986 Sites


Use BayEnv
BayEnv: "Loci involved in local adaptation can potentially be identified by an unusual correlation between allele frequencies and important ecological variables, or by extreme allele frequency differences between geographic regions. However, such comparisons are complicated by differences in sample sizes and the neutral correlation of allele frequencies across populations due to shared history and gene flow. To overcome these difficulties, we have developed a Bayesian method that estimates the empirical pattern of covariance in allele frequencies between populations from a set of markers, and then uses this as a null model for a test at individual SNPs."
Configure file with the BayEnv PGDSpider file
```
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNPSRealdp6p05DFFHWE.MAF.2A.recode.vcf -outputfile SNPSRealdp6p05DFFHWE.MAF.2A.txt -spid SNPBayEnv.spid
```
Now use BayEnv to make a covariance matrix. P is number of populations. Look into the library info file to count 16 populations.  

Need to bring bayenv2 into this directory first
```
ln -s /usr/local/bin/bayenv2 ./bayenv2
```
Then run BayEnv
```
bayenv2 -i SNPSRealdp6p05DFFHWE.MAF.2A.txt -p 16 -k 100000 -r 63479 > matrix.out
```
The file contains a huge matrix, but we need the last 16 lines
```
tail -17 matrix.out | head -16 > matrix2
```
Now to

```
calc_bf.sh SNPSRealdp6p05DFFHWE.MAF.2A.txt environ matrix 16 10000 2
```

```
paste <(seq 1 3952) <(cut -f2,3 bf_environ.environ ) > bayenv.out
cat <(echo -e "Locus\tBF1\tBF2") bayenv.out > bayenv.final
```
In R
No Outlier SNPs found


Remove outliers from BayeScan (none from BayEnv)
```
less +3132 -N SNPSRealdp6p05DFFHWE.MAF.2A.recode.vcf
```
**Sc28pcJ_1650_HRSCAF_1766        16564696**
```
less +3293 -N SNPSRealdp6p05DFFHWE.MAF.2A.recode.vcf
```
**Sc28pcJ_1837_HRSCAF_1971        8510125**

```
nano outliers
Sc28pcJ_1650_HRSCAF_1766        16564696
Sc28pcJ_1837_HRSCAF_1971        8510125
```
Remove that one from the vcf
```
vcftools --vcf SNPSRealdp6p05DFFHWE.MAF.2A.recode.vcf --exclude-positions outliers  --recode --recode-INFO-all --out SNPSRealdp6p05DFFHWE.MAF.2A.NEU
```
**After filtering, kept 3950 out of a possible 3952 Sites**



A DAPC and PCA are in the Week-7-8-Real-Data.Rmd, along with attempted analysis from Silliman (2019)




makge genepop with pgd spider then go to treemix with That
