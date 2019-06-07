# _Uca rapax_ Assembly and Filtering
Author: Amy Zyck

Date: June 7, 2019

### Assembly

```javascript
cd Fiddler_Crab/ddocent_env/RefOpt
```
#### Create an environment
```javascript
conda create -n ddocent_env ddocent
conda activate ddocent_env
```

#### Run `ReferenceOpt.sh`
```javascript
curl -L -O https://raw.githubusercontent.com/jpuritz/dDocent/master/scripts/ReferenceOpt.sh
chmod +x ReferenceOpt.sh
```
```javascript
bash ./ReferenceOpt.sh 2 4 2 4 PE 16
```
```javascript

                                                   Histogram of number of reference contigs

                         3 +----------------------------------------------------------------------------------------+
                           |          +       *  + ****     +           +          +          +          +          |
                           |                  *    ****     'plot.kopt.data' using (bin($1,binwidth)):(1.0) ******* |
                           |                  *    ****                                                             |
                       2.5 |-+                *    ****                                                           +-|
                           |                  *    ****                                                             |
                           |                  *    ****                                                             |
                           |                  *    ****                                                             |
                         2 |-+        **   *****  ********           **       ***                                 +-|
                           |          **   *****  ****** *           **       * *                                   |
                           |          **   *****  ****** *           **       * *                                   |
                       1.5 |-+        **   *****  ****** *           **       * *                                 +-|
                           |          **   *****  ****** *           **       * *                                   |
                           |          **   *****  ****** *           **       * *                                   |
                           |          **   *****  ****** *           **       * *                                   |
                         1 |-+       ******************* ********************** ************************************|
                           |         ******************* ******** * ****** *  * *****  *  *  * **** * *  *   *   *  |
                           |         ******************* ******** * ****** *  * *****  *  *  * **** * *  *   *   *  |
                           |         ******************* ******** * ****** *  * *****  *  *  * **** * *  *   *   *  |
                       0.5 |-+       ******************* ******** * ****** *  * *****  *  *  * **** * *  *   *   *+-|
                           |         ******************* ******** * ****** *  * *****  *  *  * **** * *  *   *   *  |
                           |         ******************* ******** * ****** *  * *****  *  *  * **** * *  *   *   *  |
                           |         ******************* ******** * ****** *  * *****  *  *  *+**** * *  *   *   *  |
                         0 +----------------------------------------------------------------------------------------+
                         10000      15000      20000      25000       30000      35000      40000      45000      50000
                                                          Number of reference contigs

Average contig number = 25964.8
The top three most common number of contigs
X       Contig number
1       49899
1       47803
1       45897
The top three most common number of contigs (with values rounded)
X       Contig number
2       33400
2       22300
2       21700
```

#### Visualize data in `kopt.data` in R-Studio
```javasript
library(ggplot2)

data.table <- read.table("kopt.data", header = FALSE, col.names= c("k1","k2","Similarity", "Contigs"))

data.table$K1K2 <- paste(data.table$k1, data.table$k2, sep=",")

df=data.frame(data.table)
df$K1K2 <- as.factor(df$K1K2)

p <- ggplot(df, aes(x=Similarity, y=Contigs, group=K1K2)) + scale_x_continuous(breaks=seq(0.8,0.98,0.01)) + geom_line(aes(colour = K1K2))
p
```

Picked 0.9 as the similarity threshold

#### Run `RefMapOpt.sh` using the similarity threshold of 0.9
Note- You will need to have the trimmed reads files *.R1.fq.gz and *.R2.fq.gz included to run this script
```javascript
curl -L -O https://raw.githubusercontent.com/jpuritz/dDocent/master/scripts/RefMapOpt.sh
chmod +x RefMapOpt.sh
```
```javascript
./RefMapOpt.sh 2 4 2 4 0.9 PE 20
```

This loops across cutoffs of 2-4 using a similarity of 90% for clustering, parellized across 20 processors, using PE assembly technique.

The output is stored in a file called mapping.results
```javascript
cat mapping.results
```
```javascript
Cov     Non0Cov Contigs MeanContigsMapped       K1      K2      SUM Mapped     SUM Properly     Mean Mapped     Mean Properly   MisMatched
84.101  136.566 43287   25752.5                 2       2       65530184        51280936       3.64057e+06      2.84894e+06     593921
133.911 166.359 25782   20031.3                 2       3       62147416        52853141       3.45263e+06      2.93629e+06     315434
153.002 177.66  21173   17459.8                 2       4       58314090        48027482       3.23967e+06      2.66819e+06     418717
99.8526 150.196 35357   22767.8                 3       2       63550548        49332981       3530586          2.74072e+06     556878
151.695 180.5   21808   17738                   3       3       59549846        46078804       3.30832e+06      2.55993e+06     558437
180.241 203.798 17950   15247.6                 3       4       58239203        44554680       3.23551e+06      2475260         584175
113.48  163.508 30308   20447                   4       2       61910409        50773700       3.43947e+06      2.82076e+06     434541
165.088 190.109 18865   15754.7                 4       3       56061748        46065600       3.11454e+06      2559200         387594
217.761 241.803 15353   13308.1                 4       4       60182907        53964523       3.34349e+06      2.99803e+06     207248
```    
I chose 3 and 3. I ran dDocent for assembly on the subset.
```javascript
curl -L -O https://raw.githubusercontent.com/jpuritz/dDocent/master/dDocent
chmod +x dDocent
./dDocent
```
```javascript
dDocent 2.8.7

Contact jpuritz@uri.edu with any problems


Checking for required software

All required software is installed!

dDocent version 2.8.7 started Wed May 22 22:18:41 EDT 2019

24 individuals are detected. Is this correct? Enter yes or no and press [ENTER]
yes
Proceeding with 24 individuals
dDocent detects 80 processors available on this system.
Please enter the maximum number of processors to use for this analysis.
20

Do you want to quality trim your reads?
Type yes or no and press [ENTER]?
no

Do you want to perform an assembly?
Type yes or no and press [ENTER].
yes
What type of assembly would you like to perform?  Enter SE for single end, PE fo                                                                                        r paired-end, RPE for paired-end sequencing for RAD protocols with random sheari                                                                                        ng, or OL for paired-end sequencing that has substantial overlap.
Then press [ENTER]
PE
Reads will be assembled with Rainbow
CD-HIT will cluster reference sequences by similarity. The -c parameter (% similarity to cluster) may need to be changed for your taxa.
Would you like to enter a new c parameter now? Type yes or no and press [ENTER]
yes
Please enter new value for c. Enter in decimal form (For 90%, enter 0.9)
0.9
Do you want to map reads?  Type yes or no and press [ENTER]
no
Mapping will not be performed
Do you want to use FreeBayes to call SNPs?  Please type yes or no and press [ENTER]
no

Please enter your email address.  dDocent will email you when it is finished running.
Don't worry; dDocent has no financial need to sell your email address to spammers.


dDocent will require input during the assembly stage.  Please wait until prompt says it is safe to move program to the background.

                       Number of Unique Sequences with More than X Coverage (Counted within individuals)

  2.2e+06 +---------------------------------------------------------------------------------------------------------+
          |           +           +          +           +           +           +          +           +           |
    2e+06 |*+                                                                                                     +-|
          |*                                                                                                        |
          | *                                                                                                       |
  1.8e+06 |-*                                                                                                     +-|
          |  *                                                                                                      |
  1.6e+06 |-+ *                                                                                                   +-|
          |   *                                                                                                     |
  1.4e+06 |-+  *                                                                                                  +-|
          |    *                                                                                                    |
  1.2e+06 |-+   ***                                                                                               +-|
          |        **                                                                                               |
          |          *                                                                                              |
    1e+06 |-+         *****                                                                                       +-|
          |                *                                                                                        |
   800000 |-+               ******                                                                                +-|
          |                       *****                                                                             |
   600000 |-+                          ******                                                                     +-|
          |                                  ******************                                                     |
          |                                                    *****************************                        |
   400000 |-+                                                                               ************************|
          |           +           +          +           +           +           +          +           +           |
   200000 +---------------------------------------------------------------------------------------------------------+
          2           4           6          8           10          12          14         16          18          20
                                                           Coverage

Please choose data cutoff.  In essence, you are picking a minimum (within individual) coverage level for a read (allele) to be used in the reference assembly
3

                                 Number of Unique Sequences present in more than X Individuals

   160000 +---------------------------------------------------------------------------------------------------------+
          |*                   +                    +                     +                    +                    |
          | *                                                                                                       |
   140000 |-+*                                                                                                    +-|
          |   *                                                                                                     |
          |    *                                                                                                    |
   120000 |-+   *                                                                                                 +-|
          |      *                                                                                                  |
          |       *                                                                                                 |
   100000 |-+      *                                                                                              +-|
          |         *                                                                                               |
    80000 |-+        *****                                                                                        +-|
          |               ****                                                                                      |
          |                   *                                                                                     |
    60000 |-+                  *********                                                                          +-|
          |                             **                                                                          |
          |                               **********                                                                |
    40000 |-+                                       ***********                                                   +-|
          |                                                    ***********                                          |
          |                                                               *********************                     |
    20000 |-+                                                                                  *********************|
          |                                                                                                         |
          |                    +                    +                     +                    +                    |
        0 +---------------------------------------------------------------------------------------------------------+
          2                    4                    6                     8                    10                   12
                                                     Number of Individuals

Please choose data cutoff.  Pick point right before the assymptote. A good starting cutoff might be 10% of the total number of individuals
3
At this point, all configuration information has been entered and dDocent may take several hours to run.
It is recommended that you move this script to a background operation and disable terminal input and output.
All data and logfiles will still be recorded.
To do this:
Press control and Z simultaneously
Type 'bg' without the quotes and press enter
Type 'disown -h' again without the quotes and press enter

Now sit back, relax, and wait for your analysis to finish

dDocent assembled 83663 sequences (after cutoffs) into 21731 contigs

dDocent has finished with an analysis in /home/azyck/Fiddler_Crab/ddocent_env/RefOpt

dDocent started Wed May 22 22:18:41 EDT 2019

dDocent finished Wed May 22 22:24:47 EDT 2019
```

Copy the `reference.fasta` file from this `RefOpt` directory to the main working directory.
```javascript
cp reference.fasta ../
cd ../
```
Run dDocent on the full data set, skipping trimming and assembly.
```javascript
./dDocent
```
```javascript
dDocent 2.8.7

Contact jpuritz@uri.edu with any problems


Checking for required software

All required software is installed!

dDocent version 2.8.7 started Wed May 22 22:31:24 EDT 2019

376 individuals are detected. Is this correct? Enter yes or no and press [ENTER]
yes
Proceeding with 376 individuals
dDocent detects 80 processors available on this system.
Please enter the maximum number of processors to use for this analysis.
20

Do you want to quality trim your reads?
Type yes or no and press [ENTER]?
no

Do you want to perform an assembly?
Type yes or no and press [ENTER].
no

Reference contigs need to be in a file named reference.fasta

Do you want to map reads?  Type yes or no and press [ENTER]
yes
BWA will be used to map reads.  You may need to adjust -A -B and -O parameters for your taxa.
Would you like to enter a new parameters now? Type yes or no and press [ENTER]
yes
Please enter new value for A (match score).  It should be an integer.  Default is 1.
1
Please enter new value for B (mismatch score).  It should be an integer.  Default is 4.
3
Please enter new value for O (gap penalty).  It should be an integer.  Default is 6.
5
Do you want to use FreeBayes to call SNPs?  Please type yes or no and press [ENTER]
yes

Please enter your email address.  dDocent will email you when it is finished running.
Don't worry; dDocent has no financial need to sell your email address to spammers.
amaeliazyck@gmail.com


At this point, all configuration information has been entered and dDocent may take several hours to run.
It is recommended that you move this script to a background operation and disable terminal input and output.
All data and logfiles will still be recorded.
To do this:
Press control and Z simultaneously
Type 'bg' without the quotes and press enter
Type 'disown -h' again without the quotes and press enter

Now sit back, relax, and wait for your analysis to finish
```
```javasript
After filtering, kept 228044 out of a possible 711393 Sites
```

### Filtering
In `Fiddler_Crab` make a new filtering directory
```javascript
mkdir filtering
cd filtering
ln -s ../TotalRawSNPs.vcf .
```

Change all genotypes with less than 5 reads to missing data
```javascript
vcftools --vcf TotalRawSNPs.vcf --recode-INFO-all --minDP 5 --out TRSdp5 --recode
```
```javascript
After filtering, kept 376 out of 376 Individuals
Outputting VCF file...
After filtering, kept 711393 out of a possible 711393 Sites
Run Time = 768.00 seconds
```
Filter out all variants that are not successfully genotyped in at least 50% of samples and do not have a minimum quality score of 20.
```javascript
vcftools --vcf TRSdp5.recode.vcf --recode-INFO-all --max-missing 0.5 --minQ 20 --out TRSdp5g5 --recode
```
```javascript
After filtering, kept 376 out of 376 Individuals
Outputting VCF file...
After filtering, kept 386185 out of a possible 711393 Sites
Run Time = 451.00 seconds
```

MAF filtering for FreeBayes Output
```javascript
curl -L -O https://raw.githubusercontent.com/jpuritz/dDocent/master/scripts/untested/multi.maf.sh
chmod +x multi.maf.sh
multi.maf.sh TRSdp5g5.recode.vcf 0.001 TRSdp5g5maf
```
```javascript
After filtering, kept 376 out of 376 Individuals
Outputting VCF file...
After filtering, kept 385420 out of a possible 386185 Sites
Run Time = 528.00 seconds
```

Use a custom script called `filter_missing_ind.sh` to filter out bad individuals
```javascript
curl -L -O https://raw.githubusercontent.com/jpuritz/dDocent/master/scripts/filter_missing_ind.sh
chmod +x filter_missing_ind.sh
./filter_missing_ind.sh TRSdp5g5maf.recode.vcf TRSdp5g5maf5MIa
```
```javascript
After filtering, kept 376 out of 376 Individuals
Outputting Individual Missingness
After filtering, kept 385420 out of a possible 385420 Sites
Run Time = 39.00 seconds

                                          Histogram of % missing data per individual
     Number of Occurrences
       40 ++---------+--**-----+----------+---------+----------+----------+---------+----------+---------+---------++
          +          +  **     +          +         +          'totalmissing' using (bin($1,binwidth)):(1.0) ****** +
          |             **                                                                                          |
       35 ++            **                                                                                         ++
          |             ***                                                                                         |
          |             ***                                                                                         |
       30 ++           ****                                                                                        ++
          |            ****                                                                                         |
          |            ****                                                                                         |
       25 ++           ****                                                                                        ++
          |            *****                                                                                        |
       20 ++           *****                                                                                       ++
          |         ********                                                                                        |
          |         **********                                                                                      |
       15 ++        **********                                                                                     ++
          |         **********                                                                                      |
          |         ****************                                                                                |
       10 ++        ****************                                                          **                   ++
          |       ******************                                                          **                    |
          |       * ******************                                                        **                    |
        5 ++ **** * **************** ***                                                      ***                  ++
          | ******* **************** ***********                                             ****          *******  |
          + ******* **************** *******  **************************************************************     ***+
        0 ++********************************************************************************************************+
          0         0.1       0.2        0.3       0.4        0.5        0.6       0.7        0.8       0.9         1
                                                       % of missing data

The 85% cutoff would be 0.285997
Would you like to set a different cutoff, yes or no
yes
Please eneter new cutoff.
0.5

After filtering, kept 340 out of 376 Individuals
Outputting VCF file...
After filtering, kept 385420 out of a possible 385420 Sites
Run Time = 497.00 seconds
```

Use a second custom script `pop_missing_filter.sh` to filter loci that have high missing data values in a single population. This step needs a file that maps individuals to populations `popmap`.
```javascript
ln -s ../popmap .
```
```javascript
curl -L -O https://raw.githubusercontent.com/jpuritz/dDocent/master/scripts/pop_missing_filter.sh
chmod +x pop_missing_filter.sh
./pop_missing_filter.sh TRSdp5g5maf5MIa.recode.vcf popmap 0.1 1 TRSdp5g5mafMIap9
```
```javascript
After filtering, kept 340 out of 340 Individuals
Outputting VCF file...
After filtering, kept 149880 out of a possible 385420 Sites
Run Time = 274.00 seconds
```
Filter out any sites with less than 95% overall call rate and MAF of 0.001.
```javascript
vcftools --vcf TRSdp5g5mafMIap9.recode.vcf --recode-INFO-all --max-missing 0.95 --maf 0.001 --out TRSdp5g5mafMIap9g9 --recode
```
```javascript
After filtering, kept 340 out of 340 Individuals
Outputting VCF file...
After filtering, kept 120155 out of a possible 149880 Sites
Run Time = 259.00 seconds
```
Use another custom filter script `dDocent_filters`
```javascript
curl -L -O https://raw.githubusercontent.com/jpuritz/dDocent/master/scripts/dDocent_filters
chmod +x dDocent_filters
./dDocent_filters TRSdp5g5mafMIap9g9.recode.vcf TRSdp5g5mafMIap9g9d
```
```javascript
This script will automatically filter a FreeBayes generated VCF file using criteria related to site depth,
quality versus depth, strand representation, allelic balance at heterzygous individuals, and paired read representation.
The script assumes that loci and individuals with low call rates (or depth) have already been removed.

Contact Jon Puritz (jpuritz@gmail.com) for questions and see script comments for more details on particular filters

Number of sites filtered based on allele balance at heterozygous loci, locus quality, and mapping quality / Depth
 76959 of 120155

Are reads expected to overlap?  In other words, is fragment size less than 2X the read length?  Enter yes or no.
yes
Is this from a mixture of SE and PE libraries? Enter yes or no.
no
Number of additional sites filtered based on properly paired status
 1227 of 43196

Number of sites filtered based on high depth and lower than 2*DEPTH quality score
 4189 of 41969

                                               Histogram of mean depth per site

      450 +---------------------------------------------------------------------------------------------------------+
          | +    +     +    +    +     +    +     +    +    +     +   *+ *   +    +     +    +    +     +    +     +|
          |                                               **eandepthpe*si*e' using (bin($1,binwidth)):(1.0) ******* |
      400 |-+                                             ***        *** *                                        +-|
          |                                            ** *** *     **** ** *                                       |
      350 |-+                                   **    *** *** *   ********* *   *                                 +-|
          |                                     **    ******* * *************   *                                   |
          |                                     **    ******* ***************   *                                   |
      300 |-+                                   **   ******** ****************  *                                 +-|
          |                                     **   *************************  *                                   |
      250 |-+                                   **   *************************  ***                               +-|
          |                                     ***********************************                                 |
          |                        *  ** **  * ************************************                                 |
      200 |-+                      * *** **  ****************************************                             +-|
          |                        * ****** ******************************************                              |
      150 |-+                      * **************************************************  ***                      +-|
          |                      * ****************************************************  ***                        |
          |                  *  ************************************************************                        |
      100 |-+                ***************************************************************                      +-|
          |              ** *******************************************************************                     |
       50 |-+            **********************************************************************  **   **          +-|
          |           ***************************************************************************** ****       **   |
          | +  *****************************************************************************************************|
        0 +---------------------------------------------------------------------------------------------------------+
            15   30    45   60   75    90  105   120  135  150   165  180   195  210   225  240  255   270  285   300
                                                          Mean Depth

If distrubtion looks normal, a 1.645 sigma cutoff (~90% of the data) would be 176038.7185
The 95% cutoff would be 277
Would you like to use a different maximum mean depth cutoff than 277, yes or no
no
Number of sites filtered based on maximum mean depth
 2176 of 41969

Number of sites filtered based on within locus depth mismatch
 35 of 39793

Total number of sites filtered
 80397 of 120155

Remaining sites
 39758

Filtered VCF file is called Output_prefix.FIL.recode.vcf

Filter stats stored in TRSdp5g5mafMIap9g9d.filterstats
```
Break complex mutational events (combinations of SNPs and INDELs) into sepearte SNP and INDEL calls, and then remove INDELs.
```javascript
vcfallelicprimitives TRSdp5g5mafMIap9g9d.FIL.recode.vcf --keep-info --keep-geno > TRSdp5g5mafMIap9g9d.prim.vcf
vcftools --vcf TRSdp5g5mafMIap9g9d.prim.vcf --remove-indels --recode --recode-INFO-all --out SNP.TRSdp5g5mafMIap9g9d
```
```javascript
After filtering, kept 340 out of 340 Individuals
Outputting VCF file...
After filtering, kept 43983 out of a possible 49258 Sites
Run Time = 93.00 seconds
```

This data set contains technical replicates. I will use a custom script `dup_sample_filter.sh` to automatically remove sites in VCF files that do not have congruent genotypes across duplicate individuals. It will only consider genotypes that have at least 5 reads.

`dup_sample_filter.sh` is located: https://github.com/amaeliazyck/RADseq_Uca-rapax_2016/blob/master/Scripts/dup_sample_filter.sh

The technical replicates are listed in `duplicates.samples.1` with the following format (each name should be separated by a tab):
```javascript
FBN_327a        FBN_327b
FBN_327a        FBN_327c
FBN_327a        FBN_327d
FBN_327b        FBN_327c
FBN_327b        FBN_327d
FBN_327c        FBN_327d
OBN_9b         OBN_9c
OBN_9b         OBN_9d
OBN_9c         OBN_9d
OBS_245a        OBS_245b
OBS_245a        OBS_245c
OBS_245a        OBS_245d
OBS_245b        OBS_245c
OBS_245b        OBS_245d
OBS_245c        OBS_245d
PCN_210a        PCN_210b
PCN_223a        PCN_223b
PCS_361a        PCS_361b
PCS_365a        PCS_365b
SPS_74a        SPS_74b
SPS_92a        SPS_92b
SPS_92a        SPS_92c
SPS_92a        SPS_92d
SPS_92b        SPS_92c
SPS_92b        SPS_92d
SPS_92c        SPS_92d
WC2_301a        WC2_301b
WC2_305a        WC2_305b
WC2_305a        WC2_305c
WC2_305b        WC2_305c
```  
Copy to `filtering`.
```javascript
ln -s ../dup_sample_filter.sh .
ln -s ../duplicates.samples.1 .
```
Run script.
```javascript
./dup_sample_filter.sh SNP.TRSdp5g5mafMIap9g9d.recode.vcf duplicates.samples.1
```
This produces a `mismatched.loci` file.
```javascript
head mismatched.loci
```
```javascript
2       dDocent_Contig_6167     14
2       dDocent_Contig_12111    122
2       dDocent_Contig_5485     184
2       dDocent_Contig_11981    240
14      dDocent_Contig_5512     27
2       dDocent_Contig_11857    114
2       dDocent_Contig_11642    216
2       dDocent_Contig_3841     25
2       dDocent_Contig_11322    100
2       dDocent_Contig_3530     210
```

```javascript
echo -e "Mismatches\tNumber_of_Loci" > mismatch.txt
for i in {2..20}
do
paste <(echo $i) <(mawk -v x=$i '$1 > x' mismatched.loci | wc -l) >> mismatch.txt
done
```
In RStudio
````javascript
library(ggplot2)
mismatch <- read.table("mismatch.txt", header = TRUE)
df=data.frame(mismatch)

p <- ggplot(df, aes(x=Mismatches, y=Number_of_Loci)) + geom_point() +theme_bw() + scale_x_continuous(minor_breaks = seq(1,20,by=1))
p
```
![mismatched](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/mismatched.png)

I decided to filter out loci with mismatched values > 6.
```javascript
mawk '$1 > 6' mismatched.loci | cut -f2,3 > mismatchedloci

vcftools --vcf SNP.TRSdp5g5mafMIap9g9d.recode.vcf --exclude-positions mismatchedloci --recode --recode-INFO-all --out SNP.TRSdp5g5mafMIap9g9dMM
```
```javascript
After filtering, kept 340 out of 340 Individuals
Outputting VCF file...
After filtering, kept 43532 out of a possible 43983 Sites
Run Time = 97.00 seconds
```





Use the script `rad_haplotyper.pl` written by [Chris Hollenbeck](https://github.com/chollenbeck). This tool takes a VCF file of SNPs and will parse through BAM files looking to link SNPs into haplotypes along paired reads.

First, copy the most recent VCF file to the directory with the BAM files and `reference.fasta`. In my case, it is `ddocent_env`.
```javascript
cp SNP.TRSdp5g5mafMIap9g9dMM.recode.vcf ../
cd ../
```

```javascript
curl -L -O https://raw.githubusercontent.com/chollenbeck/rad_haplotyper/e8bdc79f1d1d9ce3d769996315fc1ffd3a7d0e4e/rad_haplotyper.pl
chmod +x rad_haplotyper.pl
rad_haplotyper.pl -p popmap -v SNP.TRSdp5g5mafMIap9g9dMM.recode.vcf -r reference.fasta -g SNPTRSdp5g5mafMIap9g9dMM -mp 5 -x 40 -z 0.1 -e
```
Output will resemble
```javascript
Building haplotypes for FBN_306
Building haplotypes for FBN_307
Building haplotypes for FBN_308
Building haplotypes for FBN_310
Building haplotypes for FBN_311
...
Filtered 182 loci below missing data cutoff
Filtered 187 possible paralogs
Filtered 0 loci with low coverage or genotyping errors
Filtered 2 loci with an excess of haplotypes
Writing Genepop file: SNPTRSdp5g5mafMIap9g9dMM
```
All additional loci to be removed are stored in `stats.out`
```javascript
head stats.out
```
```javascript
Locus                   Sites   Haplotypes      Inds_Haplotyped Total_Inds      Prop_HaplotypedStatus   Poss_Paralog    Low_Cov/Geno_Err        Miss_Geno       Comment
dDocent_Contig_10004    19      23              339             340             0.997                   PASSED          0                        01
dDocent_Contig_10012    1       2               323             340             0.950                   PASSED          0                        017
dDocent_Contig_10017    18      21              340             340             1.000                   PASSED          0                        00
dDocent_Contig_10019    1       2               340             340             1.000                   PASSED          0                        00
dDocent_Contig_10030    32      28              334             340             0.982                   PASSED          1                        32
dDocent_Contig_10039    13      15              338             340             0.994                   PASSED          0                        02
dDocent_Contig_10054    32      64              338             340             0.994                   PASSED          0                        20
dDocent_Contig_10057    10      10              332             340             0.976                   PASSED          0                        17                       
```

Use this file to create a list of loci to filter.
```javascript
mawk '/FILT/' stats.out | cut -f1 > bad.hap.dp3.loci
```

Remove the bad RAD loci using the script `remove.bad.hap.loci.sh`
```javascript
curl -L -O https://raw.githubusercontent.com/jpuritz/dDocent/master/scripts/remove.bad.hap.loci.sh
chmod +x remove.bad.hap.loci.sh
./remove.bad.hap.loci.sh bad.hap.dp3.loci SNP.TRSdp5g5mafMIap9g9dMM.recode.vcf
```
This generates the filtered VCF file `SNP.TRSdp5g5mafMIap9g9dMM.filtered.vcf`

```javascript
vcftools --vcf SNP.TRSdp5g5mafMIap9g9dMM.filtered.vcf --missing-indv
```
```javascript
After filtering, kept 340 out of 340 Individuals
Outputting Individual Missingness
After filtering, kept 38121 out of a possible 38121 Sites
Run Time = 2.00 seconds
```

```javascript
head out.imiss
```
```javascript
INDV    N_DATA  N_GENOTYPES_FILTERED    N_MISS  F_MISS
FBN_306 38121   0       405     0.0106241
FBN_307 38121   0       158     0.0041447
FBN_308 38121   0       164     0.00430209
FBN_309 38121   0       683     0.0179166
FBN_310 38121   0       117     0.00306917
FBN_311 38121   0       73      0.00191496
FBN_312 38121   0       91      0.00238714
FBN_313 38121   0       117     0.00306917
FBN_314 38121   0       246     0.00645314
```

```javascript
mawk '/FBN_327/ || /OBN_9/ || /OBN_009/ || /OBS_245/ || /PCN_210/ || /PCN_223/ || /PCS_361/ || /PCS_365/ || /SPC_92/ || /WC2_301/ || /WC2_305/ || /SPS_74/ || /SPS_92/' out.imiss > dup.imiss
cat dup.imiss
```
```javascript
FBN_327a        38121   0       17      0.000445948
FBN_327b        38121   0       7       0.000183626
FBN_327c        38121   0       10      0.000262323
FBN_327d        38121   0       43      0.00112799
OBN_009a        38121   0       94      0.00246583
OBN_9b          38121   0       3       7.86968e-05
OBN_9c          38121   0       10      0.000262323
OBN_9d          38121   0       51      0.00133785
OBS_245a        38121   0       33      0.000865665
OBS_245b        38121   0       6       0.000157394
OBS_245c        38121   0       212     0.00556124
OBS_245d        38121   0       11      0.000288555
PCN_210a        38121   0       92      0.00241337
PCN_210b        38121   0       77      0.00201988
PCN_223a        38121   0       146     0.00382991
PCN_223b        38121   0       112     0.00293801
PCS_361a        38121   0       233     0.00611212
PCS_361b        38121   0       110     0.00288555
PCS_365a        38121   0       133     0.00348889
PCS_365b        38121   0       183     0.0048005
SPS_74a         38121   0       37      0.000970594
SPS_74b         38121   0       69      0.00181003
SPS_92a         38121   0       6       0.000157394
SPS_92b         38121   0       34      0.000891897
SPS_92c         38121   0       1       2.62323e-05
SPS_92d         38121   0       84      0.00220351
WC2_301a        38121   0       96      0.0025183
WC2_301b        38121   0       486     0.0127489
WC2_305a        38121   0       350     0.00918129
WC2_305b        38121   0       88      0.00230844
WC2_305c        38121   0       269     0.00705648
```

```javascript
mawk '!/FBN_327b/ && !/OBN_9b/ && !/OBS_245b/ && !/PCN_210b/ && !/PCN_223b/ && !/PCS_361b/ && !/PCS_365a/ && !/SPS_74a/ && !/SPS_92c/ && !/WC2_301a/ && !/WC2_305b/' dup.imiss > duplicate.samples.to.remove
vcftools --vcf SNP.TRSdp5g5mafMIap9g9dMM.filtered.vcf --recode --recode-INFO-all --out SNP.TRSdp5g5mafMIap9g9dMM --remove duplicate.samples.to.remove
```
```javascript
After filtering, kept 320 out of 340 Individuals
Outputting VCF file...
After filtering, kept 38121 out of a possible 38121 Sites
Run Time = 36.00 seconds
```

Filter out loci that are out of HWE in more than half the populations, using `filter_hwe_by_pop.pl` written by [Chris Hollenbeck](https://github.com/chollenbeck)
```javascript
curl -L -O https://raw.githubusercontent.com/jpuritz/dDocent/master/scripts/filter_hwe_by_pop.pl
chmod +x filter_hwe_by_pop.pl
./filter_hwe_by_pop.pl -v SNP.TRSdp5g5mafMIap9g9dMM.recode.vcf -c 0.5 -p popmap -o SNP.TRSdp5g5mafMIap9g9dMMHWE
```
```javascript
Processing population: FBN (33 inds)
Processing population: FBS (30 inds)
Processing population: OBN (31 inds)
Processing population: OBS (32 inds)
Processing population: PCN (33 inds)
Processing population: PCS (32 inds)
Processing population: SPN (32 inds)
Processing population: SPS (33 inds)
Processing population: WC1 (28 inds)
Processing population: WC2 (32 inds)
Processing population: WC3 (29 inds)
Processing population: WC4 (31 inds)
Outputting results of HWE test for filtered loci to 'filtered.hwe'
Kept 38003 of a possible 38121 loci (filtered 118 loci)
```
```javascript
vcftools --vcf SNP.TRSdp5g5mafMIap9g9dMMHWE.recode.vcf --recode --recode-INFO-all --out SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252A --maf 0.025 --max-alleles 2
```
```javascript
After filtering, kept 320 out of 320 Individuals
Outputting VCF file...
After filtering, kept 10597 out of a possible 38003 Sites
Run Time = 11.00 seconds
```


## Outlier Detection

### PCAdapt
In RStudio
```javascript
#Load pcadapt library
library(pcadapt)

#load our VCF file into R
filename <- read.pcadapt("SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252A.recode.vcf", type = "vcf")
```

```javascript
2835 variant(s) have been discarded as they are not SNPs.
Summary:

	- input file:				SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252A.recode.vcf
	- output file:				/tmp/RtmpuIxa78/file4958500bb46.pcadapt

	- number of individuals detected:	320
	- number of loci detected:		10597

7762 lines detected.
320 columns detected.
```
```javascript
#Create first PCA
x <- pcadapt(input = filename, K = 20)
```
```javascript
#Plot the likelihoods
plot(x, option = "screeplot")
```
![K20](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/ScreePlotK20.png)

2 or 3 seem to be a good cut off. Now zoomed in:
```javascript
plot(x, option = "screeplot", K = 10)
```
![K10](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/ScreePlotK10.png)

I'm going to pick 2.
```javascript
x <- pcadapt(input = filename, K = 2)
```

#### Calculate population designations
In terminal
```javascript
vcftools --vcf SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252A.recode.vcf --missing-indv
```
```javascript
After filtering, kept 320 out of 320 Individuals
Outputting Individual Missingness
After filtering, kept 10597 out of a possible 10597 Sites
Run Time = 1.00 seconds
```
```javascript
cut -f1 out.imiss |grep -v INDV| cut -f1 -d "_" | sort | uniq -c
```
```javascript
     30 FBN
     25 FBS
     19 OBN
     28 OBS
     27 PCN
     25 PCS
     28 SPN
     29 SPS
     25 WC1
     27 WC2
     28 WC3
     29 WC4
```

Back in RStudio
```javascript
# create population designations
poplist.names <- c(rep("FBN", 30),rep("FBS", 25),rep("OBN", 19), rep("OBS",28), rep("PCN",27), rep("PCS",25), rep("SPN",28), rep("SPS",29), rep("WC1",25), rep("WC2",27), rep("WC3",28), rep("WC4",29))
```

```javascript
#Plot the actual PCA (first two PCAs)
plot(x, option = "scores", pop = poplist.names)
```

![PCA](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/PCA1%262.png)

Very little spatial structure :(

### Looking for Outliers
#### Manhattan Plot
```javascript
#Start looking for outliers
#Make Manhattan Plot
plot(x , option = "manhattan")
```
![Manhattan](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/ManhattanPlot.png)

#### Q-Q Plot
```javascript
#Make qqplot
plot(x, option = "qqplot", threshold = 0.05)
```

![QQPlot](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/QQplot.png)

#### Look at P-value distribution
```javascript
# Look at P-value distribution
plot(x, option = "stat.distribution")
```

![pvalue](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/pvalue.png)

```javascript
library(qvalue)
qval1 <- qvalue(x$pvalues)$qvalues
alpha <- 0.05
```

#### Save outliers
```javascript
outliers1 <- which(qval1 < alpha)
outliers1
```
```javascript
[1]   44  144  320  321  322  323  324  325  573  804 1390 1482 2074 2738 2938 2983 2984
[18] 2987 3039 3040 3280 3424 3873 3874 3879 3880 4217 4220 4222 4224 4225 4226 4227 5065
[35] 5067 5068 5070 5298 5299 5301 5302 5304 6462 6465
```

```javascript
system("rm outliers1.txt", wait=FALSE)
invisible(lapply(outliers1, write, "outliers1.txt", append=TRUE))
```

In terminal
```javascript
head outliers1.txt
```
```javascript
44
144
320
321
322
323
324
325
573
804
```

```javascript
mawk '!/#/' SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252A.recode.vcf | cut -f1,2 > totalloci
NUM=(`cat totalloci | wc -l`)
paste <(seq 1 $NUM) totalloci > loci.plus.index
cat outliers1.txt | parallel "grep -w ^{} loci.plus.index" | cut -f2,3> outlier.loci.txt

head outlier.loci.txt
```
```javascript
dDocent_Contig_571      190
dDocent_Contig_1145     98
dDocent_Contig_1761     77
dDocent_Contig_1761     93
dDocent_Contig_1761     98
dDocent_Contig_1761     204
dDocent_Contig_1764     260
dDocent_Contig_1767     20
dDocent_Contig_2366     61
dDocent_Contig_2674     38
```

### Outflank
Work with SNPs with MAF > 0.05

In terminal
```javascript
vcftools --vcf SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252A.recode.vcf --maf 0.05 --recode --recode-INFO-all --out SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252Amaf05
```
```javascript
After filtering, kept 320 out of 320 Individuals
Outputting VCF file...
After filtering, kept 6786 out of a possible 10597 Sites
Run Time = 6.00 seconds
```

In RStudio
```javascript
library(OutFLANK)  # outflank package
library(vcfR)
library(bigsnpr)   # package for LD pruning
```

```javascript
my_vcf <- read.vcfR("SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252Amaf05.recode.vcf")
```
```javascript
Scanning file to determine attributes.
File attributes:
  meta lines: 64
  header_line: 65
  variant count: 6786
  column count: 329
Meta line 64 read in.
All meta lines processed.
gt matrix initialized.
Character matrix gt created.
  Character matrix gt rows: 6786
  Character matrix gt cols: 329
  skip: 0
  nrows: 6786
  row_num: 0
Processed variant: 6786
All variants processed
```

````javascript
geno <- extract.gt(my_vcf) # Character matrix containing the genotypes
position <- getPOS(my_vcf) # Positions in bp
chromosome <- getCHROM(my_vcf) # Chromosome information

G <- matrix(NA, nrow = nrow(geno), ncol = ncol(geno))

G[geno %in% c("0/0", "0|0")] <- 0
G[geno  %in% c("0/1", "1/0", "1|0", "0|1")] <- 1
G[geno %in% c("1/1", "1|1")] <- 2

G[is.na(G)] <- 9

head(G[,1:10])
```
```javascript
      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
[1,]    0    0    1    0    0    0    0    0    0     0
[2,]    1    0    0    0    0    0    0    0    0     0
[3,]    0    0    1    0    0    0    0    0    0     0
[4,]    1    1    1    0    0    1    0    0    0     0
[5,]    1    0    1    0    0    1    0    0    0     0
[6,]    1    0    1    0    0    0    0    0    0     0
```

```javascript
pop <- as.vector(poplist.names)
```

```javascript
my_fst <- MakeDiploidFSTMat(t(G), locusNames = paste0(chromosome,"_", position), popNames = pop)
```

```javascript
plot(my_fst$He, my_fst$FST)
```

![FST](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/FST1.png)

```javascript
plot(my_fst$FST, my_fst$FSTNoCorr)
abline(0,1)
```

![NoCorr](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/NoCorr.png)

We need to give OUTFlank a set of quasi-independent SNPs to estimate the neutral FST distribution. To approximate this, we will prune our SNPs to one per RAD contig

In terminal
```javascript
curl -L -O https://raw.githubusercontent.com/jpuritz/dDocent/master/scripts/untested/Filter_one_random_snp_per_contig.sh
chmod +x Filter_one_random_snp_per_contig.sh
./Filter_one_random_snp_per_contig.sh SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252Amaf05.recode.vcf
```
```javascript
Filtered VCF file is saved under name SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252Amaf05.filtered1SNPper.vcf
```

In RStudio
```javascript
my_vcf_sub <- read.vcfR("SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252Amaf05.filtered1SNPper.vcf")
```
```javascript
Scanning file to determine attributes.
File attributes:
  meta lines: 64
  header_line: 65
  variant count: 2426
  column count: 329
Meta line 64 read in.
All meta lines processed.
gt matrix initialized.
Character matrix gt created.
  Character matrix gt rows: 2426
  Character matrix gt cols: 329
  skip: 0
  nrows: 2426
  row_num: 0
Processed variant: 2426
All variants processed
```
```javascript
geno_sub <- extract.gt(my_vcf_sub) # Character matrix containing the genotypes
position_sub <- getPOS(my_vcf_sub) # Positions in bp
chromosome_sub <- getCHROM(my_vcf_sub) # Chromosome information

G_sub <- matrix(NA, nrow = nrow(geno_sub), ncol = ncol(geno_sub))

G_sub[geno_sub %in% c("0/0", "0|0")] <- 0
G_sub[geno_sub  %in% c("0/1", "1/0", "1|0", "0|1")] <- 1
G_sub[geno_sub %in% c("1/1", "1|1")] <- 2

G_sub[is.na(G_sub)] <- 9

head(G_sub[,1:10])
```
```javascript
      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
[1,]    0    0    1    0    0    0    0    0    0     0
[2,]    0    0    1    0    0    0    0    0    0     0
[3,]    1    0    1    0    0    0    0    0    0     0
[4,]    1    0    0    0    1    0    0    0    0     1
[5,]    1    2    2    2    1    1    2    2    2     0
[6,]    0    0    1    0    0    0    0    0    0     0
```

```javascript
pop <- as.vector(poplist.names)
```

```javascript
my_fst_sub <- MakeDiploidFSTMat(t(G_sub), locusNames = paste0(chromosome_sub,"_", position_sub), popNames = pop)
```

```javascript
plot(my_fst_sub$He, my_fst_sub$FST)
```

![FST2](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/FST2.png)

```javascript
out_trim <- OutFLANK(my_fst_sub, NumberOfSamples = 12, qthreshold=0.05, RightTrimFraction=0.05, LeftTrimFraction=0.05,Hmin =0.05)
```
```javascript
OutFLANKResultsPlotter(out_trim, withOutliers = TRUE,
                       NoCorr = TRUE, Hmin =0.05, binwidth = 0.001, Zoom =
                         FALSE, RightZoomFraction = 0.05, titletext = NULL)
```

![NoCorr](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/Nosamplesizecorr.png)

```javascript
hist(out_trim$results$pvaluesRightTail)
```

![Histo](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/Histo.png)    

```javascript
P1 <- pOutlierFinderChiSqNoCorr(my_fst, Fstbar = out_trim$FSTNoCorrbar,
                                   dfInferred = out_trim$dfInferred, qthreshold = 0.1, Hmin =0.05)
```

```javascript
my_out <- P1$OutlierFlag==TRUE
plot(P1$He, P1$FST, pch=19, col=rgb(0,0,0,0.1))
points(P1$He[my_out], P1$FST[my_out], col="blue")
```

![Outlier](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/Outlierpoint.png)

```javascript
P1[which(P1$OutlierFlag == TRUE),]
```

```javascript
        LocusName                         He           FST             T1
3727	dDocent_Contig_9324_207	0.3041831	0.05602335	0.008578829
```

### BayeScan

#### Convert VCF file to other outputs

In terminal
```javascript
cp /home/BIO594/DATA/Week7/example/BSsnp.spid

java -jar /usr/local/bin/PGDSpider2-cli.jar -spid BSsnp.spid -inputfile SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252Amaf05.recode.vcf -outputfile SNP1.BS
```

```javascript
BayeScan2.1_linux64bits SNP1.BS -thin 50 -nbp 30
```
Copy R source file
```javascript
cp /home/azyck/Week7and8/simulated/plot_R.r
```

In RStudio
```javascript
source("plot_R.r")
plot_bayescan("SNP_fst.txt")
```

![Baye1](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/Baye1.png)

```javascript
$outliers
[1] 3727

$nb_outliers
[1] 1
```

```javascript
bs <- plot_bayescan("SNP_fst.txt", FDR = 0.1)
```

![Baye2](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/Baye2.png)

```javascript
bs$outliers
```
```javascript
[1] 3727
```

```javascript
mawk '!/#/' SNP.TRSdp5g5mafMIap9g9dMMHWEmaf0252Amaf05.recode.vcf | cut -f1,2 > totalloci
NUM=(`cat totalloci | wc -l`)
paste <(seq 1 $NUM) totalloci > loci.plus.index
echo -e "3727" | parallel "grep -w ^{} loci.plus.index" | cut -f2,3> outlier2.loci.txt

head outlier2.loci.txt
```
```javascript
dDocent_Contig_9324     207
```

Combine all outlier loci into one file
```javascript
cat outlier*.loci.txt > all.outliers
cut -f1 all.outliers | sort | uniq | wc -l
```
```javascript
29
```
