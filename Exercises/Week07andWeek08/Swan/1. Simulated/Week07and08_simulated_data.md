```
conda activate Week9.Ex
cd home/stan/Week9/Week9.Ex/simulated/fasqfiles
dDocent
wc -l Final.recode.vcf
```
```
3042 Final.recode.vcf
```

```
cd ..
head TotalRawSNPs.vcf
vcftools --vcf TotalRawSNPs.vcf  --max-missing 0.5 --maf 0.001 --minQ 20 --recode --recode-INFO-all --out TRS

>output: TRS.log  TRS.recode.vcf
```
```
VCFtools - 0.1.15
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
Run Time = 2.00 seconds
```

```
vcftools --vcf TRS.recode.vcf --minDP 5 --recode --recode-INFO-all --out TRSdp5
```
```
VCFtools - 0.1.15
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
```
pop_missing_filter.sh TRSdp5.recode.vcf popmap 0.05 1 TRSdp5p05
```
```
rm: cannot remove 'badloci': No such file or directory

VCFtools - 0.1.15
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf TRSdp5.recode.vcf
	--keep keep.PopA
	--out PopA
	--missing-site

Keeping individuals in 'keep' list
After filtering, kept 20 out of 80 Individuals
Outputting Site Missingness
After filtering, kept 2993 out of a possible 2993 Sites
Run Time = 0.00 seconds

VCFtools - 0.1.15
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf TRSdp5.recode.vcf
	--keep keep.PopB
	--out PopB
	--missing-site

Keeping individuals in 'keep' list
After filtering, kept 20 out of 80 Individuals
Outputting Site Missingness
After filtering, kept 2993 out of a possible 2993 Sites
Run Time = 0.00 seconds

VCFtools - 0.1.15
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf TRSdp5.recode.vcf
	--keep keep.PopC
	--out PopC
	--missing-site

Keeping individuals in 'keep' list
After filtering, kept 20 out of 80 Individuals
Outputting Site Missingness
After filtering, kept 2993 out of a possible 2993 Sites
Run Time = 1.00 seconds

VCFtools - 0.1.15
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf TRSdp5.recode.vcf
	--keep keep.PopD
	--out PopD
	--missing-site

Keeping individuals in 'keep' list
After filtering, kept 20 out of 80 Individuals
Outputting Site Missingness
After filtering, kept 2993 out of a possible 2993 Sites
Run Time = 0.00 seconds

VCFtools - 0.1.15
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf TRSdp5.recode.vcf
	--exclude-positions loci.to.remove
	--recode-INFO-all
	--out TRSdp5p05
	--recode

After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 2816 out of a possible 2993 Sites
Run Time = 1.00 seconds
```
```
dDocent_filters TRSdp5p05.recode.vcf TRSdp5p05
```
```
This script will automatically filter a FreeBayes generated VCF file using criteria related to site depth,
quality versus depth, strand representation, allelic balance at heterzygous individuals, and paired read representation.
The script assumes that loci and individuals with low call rates (or depth) have already been removed.

Contact Jon Puritz (jpuritz@gmail.com) for questions and see script comments for more details on particular filters

Number of sites filtered based on allele balance at heterozygous loci, locus quality, and mapping quality / Depth
 394 of 2816

Are reads expected to overlap?  In other words, is fragment size less than 2X the read length?  Enter yes or no.
yes
Is this from a mixture of SE and PE libraries? Enter yes or no.
yes
Number of additional sites filtered based on properly paired status
 0 of 2422

Number of sites filtered based on high depth and lower than 2*DEPTH quality score
 277 of 2422



                                               Histogram of mean depth per site

      300 +---------------------------------------------------------------------------------------------------------+
          |   +    +    +    +     +    +    +     +    +    +     +    +    +    +     +    +    +     +    +    + |
          |                                               'meandepthpersite' using (bin($1,binwidth)):(1.0) ******* |
          |                                                                                      **                 |
      250 |-+                                                                                  ****               +-|
          |                                                                                    * ****               |
          |                                                                                  *** ** *               |
          |                                                                                *** * ** *               |
      200 |-+                                                                              * * * ** *             +-|
          |                                                                                * * * ** ***             |
          |                                                                               ** * * ** * *             |
      150 |-+                                                                             ** * * ** * *           +-|
          |                                                                             **** * * ** * ***           |
          |                                                                             * ** * * ** * * *           |
          |                                                                             * ** * * ** * * *           |
      100 |-+                                                                           * ** * * ** * * *         +-|
          |                                                                             * ** * * ** * * *           |
          |                                                                         *** * ** * * ** * * *           |
          |                                                                         * *** ** * * ** * * *           |
       50 |-+                                                                     *** * * ** * * ** * * **        +-|
          |                                                                       * * * * ** * * ** * * ****        |
          |                                                                      ** * * * ** * * ** * * ** *****    |
          |   +    +    +    +     +    +    +     +    +    +     +    +    + **** * * * ** * * ** * * ** * * ** + |
        0 +---------------------------------------------------------------------------------------------------------+
              12   15   18   21    24   27   30    33   36   39    42   45   48   51    54   57   60    63   66   69
                                                          Mean Depth

If distrubtion looks normal, a 1.645 sigma cutoff (~90% of the data) would be 5160.47648
The 95% cutoff would be 64
Would you like to use a different maximum mean depth cutoff than 64, yes or no
no
Number of sites filtered based on maximum mean depth
 258 of 2422

Number of sites filtered based on within locus depth mismatch
 0 of 2096

Total number of sites filtered
 720 of 2816

Remaining sites
 2096

Filtered VCF file is called Output_prefix.FIL.recode.vcf

Filter stats stored in TRSdp5p05.filterstats
```
```
vcfallelicprimitives -k -g TRSdp5p05.FIL.recode.vcf | sed 's:\.|\.:\.\/\.:g' > TRSdp5p05.prim
```
```
less TRSdp5p05.prim
```
```
##fileformat=VCFv4.1
##fileDate=20180306
##source=freeBayes v1.0.2
##reference=reference.fasta
##phasing=none
##filter="AB > 0.2 & AB < 0.8 | AB < 0.01 | AB > 0.99 genotypes filtered with: QR > 0 | QA > 0 "
##filter="QUAL / DP > 0.1"
##filter="MQM / MQMR > 0.25 & MQM / MQMR < 1.75"
##filter="PAIRED < 0.005 & PAIREDR > 0.005 | PAIRED > 0.005 & PAIREDR < 0.005"
##INFO=<ID=NS,Number=1,Type=Integer,Description="Number of samples with data">
##INFO=<ID=DP,Number=1,Type=Integer,Description="Total read depth at the locus">
##INFO=<ID=DPB,Number=1,Type=Float,Description="Total read depth per bp at the locus; bases in reads overlapping / bases in haplotype">
##INFO=<ID=AC,Number=A,Type=Integer,Description="Total number of alternate alleles in called genotypes">
##INFO=<ID=AN,Number=1,Type=Integer,Description="Total number of alleles in called genotypes">
##INFO=<ID=AF,Number=A,Type=Float,Description="Estimated allele frequency in the range (0,1]">
##INFO=<ID=RO,Number=1,Type=Integer,Description="Reference allele observation count, with partial observations recorded fractionally">
##INFO=<ID=AO,Number=A,Type=Integer,Description="Alternate allele observations, with partial observations recorded fractionally">
##INFO=<ID=PRO,Number=1,Type=Float,Description="Reference allele observation count, with partial observations recorded fractionally">
##INFO=<ID=PAO,Number=A,Type=Float,Description="Alternate allele observations, with partial observations recorded fractionally">
##INFO=<ID=QR,Number=1,Type=Integer,Description="Reference allele quality sum in phred">
##INFO=<ID=QA,Number=A,Type=Integer,Description="Alternate allele quality sum in phred">
##INFO=<ID=PQR,Number=1,Type=Float,Description="Reference allele quality sum in phred for partial observations">
##INFO=<ID=PQA,Number=A,Type=Float,Description="Alternate allele quality sum in phred for partial observations">
```
```
vcftools --vcf TRSdp5p05.prim --recode --recode-INFO-all --remove-indels --out SNP.TRSdp5p05
```
```
VCFtools - 0.1.15
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf TRSdp5p05.prim
	--recode-INFO-all
	--out SNP.TRSdp5p05
	--recode
	--remove-indels

After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 1815 out of a possible 2239 Sites
Run Time = 1.00 seconds
```
```
less SNP.TRSdp5p05.recode.vcf
```
```
##fileformat=VCFv4.1
##fileDate=20180306
##source=freeBayes v1.0.2
##reference=reference.fasta
##phasing=none
##filter="AB > 0.2 & AB < 0.8 | AB < 0.01 | AB > 0.99 genotypes filtered with: QR > 0 | QA > 0 "
##filter="QUAL / DP > 0.1"
##filter="MQM / MQMR > 0.25 & MQM / MQMR < 1.75"
##filter="PAIRED < 0.005 & PAIREDR > 0.005 | PAIRED > 0.005 & PAIREDR < 0.005"
##INFO=<ID=NS,Number=1,Type=Integer,Description="Number of samples with data">
##INFO=<ID=DP,Number=1,Type=Integer,Description="Total read depth at the locus">
##INFO=<ID=DPB,Number=1,Type=Float,Description="Total read depth per bp at the locus; bases in reads overlapping / bases in haplotype">
##INFO=<ID=AC,Number=A,Type=Integer,Description="Total number of alternate alleles in called genotypes">
##INFO=<ID=AN,Number=1,Type=Integer,Description="Total number of alleles in called genotypes">
##INFO=<ID=AF,Number=A,Type=Float,Description="Estimated allele frequency in the range (0,1]">
##INFO=<ID=RO,Number=1,Type=Integer,Description="Reference allele observation count, with partial observations recorded fractionally">
##INFO=<ID=AO,Number=A,Type=Integer,Description="Alternate allele observations, with partial observations recorded fractionally">
##INFO=<ID=PRO,Number=1,Type=Float,Description="Reference allele observation count, with partial observations recorded fractionally">
##INFO=<ID=PAO,Number=A,Type=Float,Description="Alternate allele observations, with partial observations recorded fractionally">
##INFO=<ID=QR,Number=1,Type=Integer,Description="Reference allele quality sum in phred">
##INFO=<ID=QA,Number=A,Type=Integer,Description="Alternate allele quality sum in phred">
##INFO=<ID=PQR,Number=1,Type=Float,Description="Reference allele quality sum in phred for partial observations">
##INFO=<ID=PQA,Number=A,Type=Float,Description="Alternate allele quality sum in phred for partial observations">
```
```
filter_hwe_by_pop.pl SNP.TRSdp5p05.recode.vcf -v SNP.TRSdp5p05.recode.vcf -p popmap -c 0.5 -out SNP.TRSdp5p05FHWE
```
```
Processing population: PopA (20 inds)
Processing population: PopB (20 inds)
Processing population: PopC (20 inds)
Processing population: PopD (20 inds)
Outputting results of HWE test for filtered loci to 'filtered.hwe'
Kept 1815 of a possible 1815 loci (filtered 0 loci)
```
TO CLARIFY
```
vcftools --vcf SNP.TRSdp5p05FHWE.recode.vcf --maf 0.05 --recode --recode-INFO-all --out SNP.TRSdp5p05FHWEmaf05
```
```
VCFtools - 0.1.15
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf SNP.TRSdp5p05FHWE.recode.vcf
	--recode-INFO-all
	--maf 0.05
	--out SNP.TRSdp5p05FHWEmaf05
	--recode

After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 861 out of a possible 1815 Sites
Run Time = 1.00 seconds
```
To convert the vcf file into a bayescan output
```
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.TRSdp5p05FHWEmaf05.recode.vcf -outputfile SNP.TRSdp5p05FHWEBS -spid BSsnp.spid
```
Take a look at the output
```
less SNP.TRSdp5p05FHWEBS
```
```
[loci]=861

[populations]=4

[pop]=1
 1      40      2       35 5
 2      40      2       2 38
 3      40      2       38 2
 4      40      2       36 4
 5      40      2       2 38
 6      40      2       37 3
 7      40      2       28 12
 8      38      2       36 2
 9      38      2       4 34
 10     38      2       21 17
 11     38      2       18 20
 12     40      2       33 7
 13     40      2       33 7
 14     40      2       38 2
 15     40      2       5 35
 16     40      2       35 5
 17     40      2       5 35
 18     38      2       6 32
```
Run BayeScan
```
BayeScan2.1_linux64bits SNP.TRSdp5p05FHWEBS -nbp 30 -thin 20
```
> get VCFtoOutlierOnly.sh
```
./VCFtoOutlierOnly.sh SNP.TRSdp5p05FHWEmaf05.recode.vcf SNP.TRSdp5p05FH_fst.txt  0.1 SNPTRS -SNPTRS.outlieronly --positions Outlier.list
```
```
VCFtools - 0.1.15
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf SNP.TRSdp5p05FHWEmaf05.recode.vcf
	--recode-INFO-all
	--out .outlieronly
	--positions Outlier.list
	--recode

After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 3 out of a possible 861 Sites
Run Time = 0.00 seconds

VCFtools - 0.1.15
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf SNP.TRSdp5p05FHWEmaf05.recode.vcf
	--exclude-positions Outlier.list
	--recode-INFO-all
	--out .neutralonly
	--recode

After filtering, kept 80 out of 80 Individuals
Outputting VCF file...
After filtering, kept 858 out of a possible 861 Sites
Run Time = 0.00 seconds
```
```
ls -t | head

SNPTRS.neutralonly.log
SNPTRS.neutralonly.recode.vcf
SNPTRS.outlieronly.log
SNPTRS.outlieronly.recode.vcf
Outlier.list
BS.noheader
totalloci
VCFtoOutlierOnly.sh
SNP.TRSdp5p05FH_fst.txt
SNP.TRSdp5p05FH.sel
```
```
mawk '!/#/' SNPTRS.neutralonly.recode.vcf | wc -l

858
```
