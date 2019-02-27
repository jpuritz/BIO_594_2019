---
layout: post
title: Week 5 Exercise: Discover the Number of Loci in our Dataset and Assemble a Reference
Author: Maggie Schedl
---
### Feb. 2019

### Much of this is adapted from [HERE](http://ddocent.com/assembly/) and [HERE](http://ddocent.com/UserGuide/) which are both by Jon Puritz.


Make a directory for this exercise, then copy the data into that directory. Next we have to make a conda environment to work in.
```
$mkdir Week5.Ex
$cd /home/BIO594/DATA/
$cp -r Week5 /home/mschedl/
$cd
$cd Week5
$conda create -n We_5_Ref ddocent
$conda activate We_5_Ref #this activates the environment so now we're good to go!
```
Lets look at the data we are starting with. Looks like everything has been demultiplexed so far and named to the individual.
```
$ls
```
![first image](/Exercises/Week05/Maggie/images/image1.png)

I also want to know these files look like because I am still very uncertain about working with sequence data.
```
$zcat PopA_001.F.fq.gz | head # this allows you to look at a zipped file without the extra steps of unzipping and zipping. And then I only really want to see the first part of it
```
![second image](/Exercises/Week05/Maggie/images/image2.png)

We want to find how many loci we have in these sequences, and we also want to be confident about their quality, and utility. This means we first need to look for unique sequences (how many of each sequence for each individual we have).
This code sets some variables and then goes through the files list and gets rid of all the quality scores (the BBBBBBs in the image above) and then finds unique reads within each individual and counts the coverage of each read. It also brings the forward and the reverse reads together and separates them with NNNNNNNs.

```
$ls *.F.fq.gz > fileslist
$sed -i'' -e 's/.F.fq.gz//g' fileslist
$AWK1='BEGIN{P=1}{if(P==1||P==2){gsub(/^[@]/,">");print}; if(P==4)P=0; P++}'
$AWK2='!/>/'
$AWK3='!/NNN/'
$PERLT='while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}'

$cat fileslist | parallel --no-notice -j 8 "zcat {}.F.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.forward"
$cat fileslist | parallel --no-notice -j 8 "zcat {}.R.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.reverse"
$cat fileslist | parallel --no-notice -j 8 "paste -d '-' {}.forward {}.reverse | mawk '$AWK3' | sed 's/-/NNNNNNNNNN/' | perl -e '$PERLT' > {}.uniq.seqs"

$cat PopA_001.uniq.seqs | head # What does this file look like?
```
![third image](/Exercises/Week05/Maggie/images/image3.png)

What is the range of unique sequences counts in this individual?

```
$cat PopA_001.uniq.seqs | sort -r | head
```
![fourth image](/Exercises/Week05/Maggie/images/image4.png)

Ok we saw that that individual had a lot of unique sequences with only 1 read and some with 9. We don't really want ones with only 1x coverage, and they are more likely to be errors. We can get rid of them by using a for loop to only search for 2-20 at the beginning of each line.
```
$cat *.uniq.seqs > uniq.seqs
 $for i in {2..20};
 $do
 $echo $i >> pfile
 $done
 $cat pfile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniq.seqs | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.data
 $rm pfile
```
Ok, we got everything above 1x coverage removed, but it's hard to see what's happening in each individual at the same time. Let's make a graph of the coverage.

```
$gnuplot << \EOF
$set terminal dumb size 120, 30
$set autoscale
$set xrange [2:20] # our x coverage should be between 2 and 20
$unset label
$set title "Number of Unique Sequences with More than X Coverage (Counted within individuals)"
$set xlabel "Coverage"
$set ylabel "Number of Unique Sequences"
$plot 'uniqseq.data' with lines notitle
$pause -1
$EOF
```
![fifth image](/Exercises/Week05/Maggie/images/image5.png)

Now to cut down the sequences even more, setting a cut off value of 4x.

```
$parallel --no-notice -j 8 mawk -v x=4 \''$1 >= x'\' ::: *.uniq.seqs | cut -f2 | perl -e 'while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}' > uniqCperindv
```
And because RAD loci should in theory be present and sequenced in ever individual, we want to restrict the data by the number of individuals the sequence is in.

```
$for ((i = 2; i <= 10; i++));
$do
$echo $i >> ufile
$done

$cat ufile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniqCperindv | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.peri.data
$rm ufile
```
Again we want to see what this looks like.
```
$gnuplot << \EOF
$set terminal dumb size 120, 30
$set autoscale
$unset label
$set title "Number of Unique Sequences present in more than X Individuals"
$set xlabel "Number of Individuals"
$set ylabel "Number of Unique Sequences"
$plot 'uniqseq.peri.data' with lines notitle
$pause -1
$EOF
```
![sixth image](/Exercises/Week05/Maggie/images/image6.png)

Now we can do a cut off again. Let's try 4 again

```
$mawk -v x=4 '$1 >= x' uniqCperindv > uniq.k.4.c.4.seqs
$wc -l uniq.k.4.c.4.seqs
```
7989 unique sequences!

How about three? That was where a dramatic shift was in the graph.
```
$mawk -v x=3 '$1 >= x' uniqCperindv > uniq.k.4.c.3.seqs
$wc -l uniq.k.4.c.3.seqs
```
8906 unique sequences!

Let's go forward with 4 for now. The next steps need the file to be in fasta format.

```
$cut -f2 uniq.k.4.c.4.seqs > totaluniqseq
$mawk '{c= c + 1; print ">Contig_" c "\n" $1}' totaluniqseq > uniq.fasta
$cat uniq.fasta | head
```

![seventh image](/Exercises/Week05/Maggie/images/image7.png)

That also added in the word contig (contiguous sequence). To assemble the reference first we only want the forward reads, so everything before the NNNNNNNs.

```
$sed -e 's/NNNNNNNNNN/\t/g' uniq.fasta | cut -f1 > uniq.F.fasta
```

Now we can cluster all our forward reads using the program CD-hit by 80% similarity to start. This makes clusters of sequences where the base pairs are 80% the same (or higher).

```
 $cd-hit-est -i uniq.F.fasta -o xxx -c 0.8 -T 0 -M 0 -g 1
```

CD-hit found 1234 clusters.

The second part of clustering is to break the clusters into smaller clusters, like looking for alleles. This is done in the program Rainbow, so first we need to convert the output into something Rainbow can look at.

```
$mawk '{if ($1 ~ /Cl/) clus = clus + 1; else  print $3 "\t" clus}' xxx.clstr | sed 's/[>Contig_,...]//g' | sort -g -k1 > sort.contig.cluster.ids
$paste sort.contig.cluster.ids totaluniqseq > contig.cluster.totaluniqseq
$sort -k2,2 -g contig.cluster.totaluniqseq | sed -e 's/NNNNNNNNNN/\t/g' > rcluster
$cut -f2 rcluster | uniq | wc -l  #1234
$cat rcluster | head
```
![eighth image](/Exercises/Week05/Maggie/images/image8.png)

Now to split the clusters with Rainbow

```
$rainbow div -i rcluster -o rbdiv.out
```

That was just with defaults. There are some flags you can add.

```
 $rainbow div -i rcluster -o rbdiv.out -f 0.5 -K 10 # -f is the minimum allele frequency to divide a cluster and -k is the minimum number of alleles to split
 ```

 We want to check that the divided clusters are good, and because we have paired end data we can use the reverse reads to check that clusters were divided as alleles from the same homologous loci.

 ```
 $rainbow merge -o rbasm.out -a -i rbdiv.out -r 2 # -r is the minimum number of reads to assemble
 ```
The rbasm.out contains both optimal and suboptimal contigs. We want only optimal, a sign of an optimal contig is that it has forward and paired end reads. The contigs with the most assembled paired end reads are output with the forward read contig. If there are two contigs with equal numbers of reads, the longer contig is used.

```
$cat rbasm.out <(echo "E") |sed 's/[0-9]*:[0-9]*://g' | mawk ' {
$if (NR == 1) e=$2;
$else if ($1 ~/E/ && lenp > len1) {c=c+1; print ">dDocent_Contig_" e "\n" seq2 "NNNNNNNNNN" seq1; seq1=0; seq2=0;lenp=0;e=$2;fclus=0;len1=0;freqp=0;lenf=0}
$else if ($1 ~/E/ && lenp <= len1) {c=c+1; print ">dDocent_Contig_" e "\n" seq1; seq1=0; seq2=0;lenp=0;e=$2;fclus=0;len1=0;freqp=0;lenf=0}
$else if ($1 ~/C/) clus=$2;
$else if ($1 ~/L/) len=$2;
$else if ($1 ~/S/) seq=$2;
$else if ($1 ~/N/) freq=$2;
$else if ($1 ~/R/ && $0 ~/0/ && $0 !~/1/ && len > lenf) {seq1 = seq; fclus=clus;lenf=len}
$else if ($1 ~/R/ && $0 ~/0/ && $0 ~/1/) {seq1 = seq; fclus=clus; len1=len}
$else if ($1 ~/R/ && $0 ~!/0/ && freq > freqp && len >= lenp || $1 ~/R/ && $0 ~!/0/ && freq == freqp && len > lenp) {seq2 = seq; lenp = len; freqp=freq}
$}' > rainbow.fasta
```

Now we can use CD-hit again to align and cluster the contigs by sequence similarity.

```
$cd-hit-est -i rainbow.fasta -o referenceRC.fasta -M 0 -T 0 -c 0.9 # The 0.9 clusters by 90% sequence similarity
```

This gives us 1235 loci!

What about 95%?

```
$cd-hit-est -i rainbow.fasta -o referenceRC95.fasta -M 0 -T 0 -c 0.95
```
This also gives 1235 loci!

There is a script for remaking the reference with just a few quick flags [HERE](https://github.com/jpuritz/dDocent/raw/master/scripts/remake_reference.sh)

```
$bash remake_reference.sh 4 3 0.95 PE 2 # I set the second cut off at 3 and clustered by 95% similarity
```
1234 loci


There were a lot of steps in the exercise which highlighted things the program dDocent does to make a reference, so why not try that way too.

Make a new directory so that you don't mess any of what you have already done up.

```
cd
mkdir ddocentRadRef
$cd /home/BIO594/DATA/
$cp -r Week5 /home/mschedl/ddocentRadRef
$cd
$cd ddocentRadRef
```
Run dDocent. All terminal prompts are **bold** and all my responses are in code

**80 individuals are detected. Is this correct? Enter yes or no and press [ENTER]**
```
yes
```
**Please enter the maximum number of processors to use for this analysis.**
```
80
```
**dDocent detects 503 gigabytes of maximum memory available on this system.
Please enter the maximum memory to use for this analysis in gigabytes
For example, to limit dDocent to ten gigabytes, enter 10
This option does not work with all distributions of Linux.  If runs are hanging at variant calling, enter 0
Then press [ENTER]**
```
0
```
**Do you want to quality trim your reads?**
```
no
```
**Do you want to perform an assembly?**
```
yes
```
**What type of assembly would you like to perform?  Enter SE for single end, PE for paired-end, RPE for paired-end sequencing for RAD protocols with random shearing, or OL for paired-end sequencing that has substantial overlap**
```
PE
```
**Reads will be assembled with Rainbow
CD-HIT will cluster reference sequences by similarity. The -c parameter (% similarity to cluster) may need to be changed for your taxa.
Would you like to enter a new c parameter now?**
```
yes
```
**Please enter new value for c. Enter in decimal form (For 90%, enter 0.9)**
```
0.95
```
**Do you want to map reads?  Type yes or no and press [ENTER]**
```
yes #although I do not think I need to do this just for creating a reference
```
**BWA will be used to map reads.  You may need to adjust -A -B and -O parameters for your taxa.
Would you like to enter a new parameters now?**
```
yes
```
**Please enter new value for A (match score).**
```
1
```
**Please enter new value for B (mismatch score).**
```
4
```
**Please enter new value for O (gap penalty)**
```
6
```
**Do you want to use FreeBayes to call SNPs?**
```
yes
```
**Please choose data cutoff.**
```
4 #this is what was used in the exercise
```
**Please choose second data cutoff.**
```
4 #again what was used in the above steps, although the graph looks different than the first one
```
![ninth image](/Exercises/Week05/Maggie/images/image9.png)

dDocent assembled 1235 contigs! Which makes sense because I used the same cut off values as above
![tenth image](/Exercises/Week05/Maggie/images/image10.png)

It also gave an error about mapping, but that is ok because I didn't actually need to map things.

With both of these references, the number of loci is
### 1235
