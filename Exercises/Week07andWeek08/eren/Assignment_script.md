Week 7-8 Assignment
===============

I called and filter SNPs, run two outlier detection softwares, and run PCA and DAPC for the simulated dataset.

To call and filter SNPs, I used dDocent pipeline.

Steps:

#### First, create a conda environment
```
conda create -n dDocent A410

activate A410
```


#### Run ddocent
```
dDocent

# 80 individuals are detected <yes>

# Do you want to quality trim your reads? <yes>

# Do you want to perform an assembly? <no> #because we have a referance.fasta file.

# Do you want to map reads?  <yes>

  # -match -mismatch and -gap penalty parameters: 1 - 4 - 6  (default)

#Do you want to use FreeBayes to call SNPs? <yes>
```

With this step, data trimmed and mapped to the reference by dDocent. Then SNPs were created by FreeBays software.

#### Data Outputs:
```
# TotalRawSNPs.vcf -- Raw SNP, INDEL, MNP and other variants for every individual.
```

----

To filter SNPs, I used vcftools and followed the dDocent Filtering Tutorial steps (http://www.ddocent.com/filtering/)

As a first filtering step, I only keep variants that have been successfully genotyped in 50% of individuals, with a minimum quality score of 30, and a minor allele count of 3.

```
vcftools --gzvcf TotalRawSNPs.vcf --max-missing 0.5 --mac 3 --minQ 30 --recode --recode-INFO-all --out raw.g5mac3


# Output:

# After filtering, kept 80 out of 80 Individuals
# Outputting VCF file...
# After filtering, kept 1890 out of a possible 3281 Sites
```

With this step I got rid of  ~40% of the data.

Then I applied minimum depth filter (as 3) for genotype call.

```
vcftools --vcf raw.g5mac3.recode.vcf --minDP 3 --recode --recode-INFO-all --out raw.g5mac3dp3

# Output:
# After filtering, kept 1890 out of a possible 1890 Sites
```
Then, I evaluated the potential errors:

```
curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/ErrorCount.sh
chmod +x ErrorCount.sh
./ErrorCount.sh raw.g5mac3dp3.recode.vcf

#Output:
...
The total SCORCHED EARTH error rate is 0.00826484685139208.

```
So, the data looks good.


Next step is getting rid of individuals with bad sequence data (by assessing levels of missing data)

```
vcftools --vcf raw.g5mac3dp3.recode.vcf --missing-indv

# Output:
Outputting Individual Missingness
After filtering, kept 1890 out of a possible 1890 Sites
```

Since my data is a simulated data, missing data values are low. So, I'll skip this filtering step.

Next, I have removed poor coverage individuals, and I restricted the data to variants called in a high percentage of individuals and filter by mean depth of genotypes (0.95 and meandp: 20)
```
vcftools --vcf raw.g5mac3dp3.recode.vcf --max-missing 0.95 --maf 0.05 --recode --recode-INFO-all --out DP3g95maf05 --min-meanDP 20

# Output: After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 1126 out of a possible 1890 Sites
```

Next, I estimate missing data for loci in each population, But first I created four lists that have individual names for each population.

```
mawk '$2 == "PopA"' popmap > 1.keep && mawk '$2 == "PopB"' popmap > 2.keep && mawk '$2 == "PopC"' popmap > 3.keep && mawk '$2 == "PopD"' popmap > 4.keep
```

```
vcftools --vcf DP3g95maf05.recode.vcf --keep 1.keep --missing-site --out 1

vcftools --vcf DP3g95maf05.recode.vcf --keep 2.keep --missing-site --out 2

vcftools --vcf DP3g95maf05.recode.vcf --keep 3.keep --missing-site --out 3

vcftools --vcf DP3g95maf05.recode.vcf --keep 4.keep --missing-site --out 4
```

Then I combined and made a list of loci about the threshold of %10 missing data to delete.

```
cat 1.lmiss 2.lmiss 3.lmiss 4.lmiss | mawk '!/CHR/' | mawk '$6 > 0.1' | cut -f1,2 >> badloci
```

Removing these loci


```
vcftools --vcf DP3g95maf05.recode.vcf --exclude-positions badloci --recode --recode-INFO-all --out DP3g95p5maf05
```

(Nothing has been removed)

Next step is using vcffilter to filter allele balance. Allale balence must be around 0.5 Filtering out loci with an allele balance below 0.25 and above 0.75.

```
vcffilter -s -f "AB > 0.25 & AB < 0.75 | AB < 0.01" DP3g95p5maf05.recode.vcf > DP3g95p5maf05.fil1.vcf
```

With the step above, 8 more loci have been removed.

```
mawk '!/#/' DP3g95p5maf05.recode.vcf | wc -l

# Output: 1126

mawk '!/#/' DP3g95p5maf05.fil1.vcf | wc -l

# Output: 1118
```

Sites that have reads from both strands have been removed (in fact, we don't have any)

```
vcffilter -f "SAF / SAR > 100 & SRF / SRR > 100 | SAR / SAF > 100 & SRR / SRF > 100" -s DP3g95p5maf05.fil1.vcf > DP3g95p5maf05.fil2.vcf

```

Filtering the ratio of mapping qualities between reference and alternate alleles:

```
vcffilter -f "MQM / MQMR > 0.9 & MQM / MQMR < 1.05" DP3g95p5maf05.fil2.vcf > DP3g95p5maf05.fil3.vcf

mawk '!/#/' DP3g95p5maf05.fil3.vcf | wc -l

# Output: 1118
```

Again, nothing changed.

Next I checked ratio of locus quality score to depth. Then, removed any locus that has a quality score below 1/4 of the depth.

```
vcffilter -f "QUAL / DP > 0.25" DP3g95p5maf05.fil4.vcf > DP3g95p5maf05.fil5.vcf

# Output: 1116
```

After that I calculated the meant depth and removed the loci above the cutoff that do not have quality scores 2 times the depth.


```
cut -f8 DP3g95p5maf05.fil5.vcf | grep -oe "DP=[0-9]*" | sed -s 's/DP=//g' > DP3g95p5maf05.fil5.DEPTH

mawk '!/#/' DP3g95p5maf05.fil5.vcf | cut -f1,2,6 > DP3g95p5maf05.fil5.vcf.loci.qual

# mean depth:

mawk '{ sum += $1; n++ } END { if (n > 0) print sum / n; }' DP3g95p5maf05.fil5.DEPTH

# Output: 4705.9

python -c "print int(4705.9+3*(1952**0.5))"

# Output: 00826484685139208

paste DP3g95p5maf05.fil5.vcf.loci.qual DP3g95p5maf05.fil5.DEPTH | mawk -v x=2084 '$4 > x' | mawk '$3 < 2 * $4' > DP3g95p5maf05.fil5.lowQDloci

vcftools --vcf DP3g95p5maf05.fil5.vcf --site-depth --exclude-positions DP3g95p5maf05.fil5.lowQDloci --out DP3g95p5maf05.fil5

# Output: After filtering, kept 914 out of a possible 1116 Sites

cut -f3 DP3g95p5maf05.fil5.ldepth > DP3g95p5maf05.fil5.site.depth

mawk '!/D/' DP3g95p5maf05.fil5.site.depth | mawk -v x=31 '{print $1/x}' > meandepthpersite```

Ploting data as a histogram:

```
gnuplot << \EOF
set terminal dumb size 120, 30
set autoscale
set xrange [10:150]
unset label
set title "Histogram of mean depth per site"
set ylabel "Number of Occurrences"
set xlabel "Mean Depth"
binwidth=1
bin(x,width)=width*floor(x/width) + binwidth/2.0
set xtics 5
plot 'meandepthpersite' using (bin($1,binwidth)):(1.0) smooth freq with boxes
pause -1
EOF```

```
Output:

Histogram of mean depth per site

 50 ++--+---+---+---+---+---+---+---+---+---+---+---+---+---+--+---+---+---+---+---+---+---+---+---+---+---+---+--++
    +   +   +   +   +   +   +   +   +   +   +   +   +   + 'meandepthpersite' using (bin($1,binwidth)):(1.0)+****** +
 45 ++                                                                                                        **  ++
    |                                                                                                         **   |
    |                                                                                                       ****   |
 40 ++                                                                                                      ****  ++
    |                                                                                                       ****   |
 35 ++                                                                                                      ***** ++
    |                                                                                                       *****  |
 30 ++                                                                                                      *******+
    |                                                                                                       ********
 25 ++                                                                                                     *********
    |                                                                                                  **  *********
    |                                                                                                  **  *********
 20 ++                                                                                                 **  *********
    |                                                                                                  **  *********
 15 ++                                                                                                 **  *********
    |                                                                                                  *************
 10 ++                                                                                                 *************
    |                                                                                                 **************
    |                                                                                             *** **************
  5 ++                                                                                           ** ****************
    +   +   +   +   +   +   +   +   +   +   +   +   +   +   +  +   +   +   +   +   +   +   ********+****************
  0 ++--+---+---+---+---+---+---+---+---+---+---+---+---+---+--+---+---+---+---+--**********************************
    10  15  20  25  30  35  40  45  50  55  60  65  70  75  80 85  90  95 100 105 110 115 120 125 130 135 140 145 150
```


Since our data is simulated I will not remove any loci by mean depth.

This step is to remove indels:

```
curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/filter_hwe_by_pop.pl
chmod +x filter_hwe_by_pop.pl
```

Converting variant calls to SNPs:


```
vcfallelicprimitives DP3g95p5maf05.fil5.vcf --keep-info --keep-geno > DP3g95p5maf05.prim.vcf

```

removing indels:

```
vcftools --vcf DP3g95p5maf05.prim.vcf --remove-indels --recode --recode-INFO-all --out SNP.DP3g95p5maf05

# Output: After filtering, kept 950 out of a possible 1177 Sites
```

Final version of the filtered VCF file is:

SNP.DP3g95p5maf05.recode.vcf
```
