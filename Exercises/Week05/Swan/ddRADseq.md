# Take-home Exercise for Week 5

### Task 1: How many loci are there?
### Task 2: Post a `reference.fasta` file with your assembled reference
>>As attached

Using demultiplexed ddRADseq files in the `/home/BIO594/DATA/Week5/` directory:

* Transfer data to my working directory
```
$mkdir ddRADseq
$cp /home/BIO594/DATA/Week5/* ./ddRADseq/
$ls
```
* Create conda environment
```
 $conda create -n ddRADseq ddocent
 $activate ddRADseq
```
* RADseq Assembly (Following tutorial steps)

1. To create a set of unique reads with counts for each individual.
```
$ls *.F.fq.gz > namelist
$head namelist
$sed -i'' -e 's/.F.fq.gz//g' namelist

$AWK1='BEGIN{P=1}{if(P==1||P==2){gsub(/^[@]/,">");print}; if(P==4)P=0; P++}'
$AWK2='!/>/'
$AWK3='!/NNN/'
$PERLT='while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}'

$cat namelist | parallel --no-notice -j 8 "zcat {}.F.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.forward"
$cat namelist | parallel --no-notice -j 8 "zcat {}.R.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.reverse"
$cat namelist | parallel --no-notice -j 8 "paste -d '-' {}.forward {}.reverse | mawk '$AWK3' | sed 's/-/NNNNNNNNNN/' | perl -e '$PERLT' > {}.uniq.seqs"
```

2. To sum up the number the within individual coverage level of unique reads in our data set.
```
$cat *.uniq.seqs > uniq.seqs
$head uniq.seqs
$wc -l uniq.seqs
>>768913 uniq.seqs

$for i in {2..20}; do echo $i >> pfile; done
$head pfile
$cat pfile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniq.seqs | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.data
$rm pfile

#Take a look at the contents of uniqseq.data
$head uniqseq.data
```

3. To plot uniqseq.data to the terminal using gnuplot.
```
$gnuplot << \EOF
set terminal dumb size 120, 30
set autoscale
set xrange [2:20]
unset label
set title "Number of Unique Sequences with More than X Coverage (Counted within individuals)"
set xlabel "Coverage"
set ylabel "Number of Unique Sequences"
plot 'uniqseq.data' with lines notitle
pause -1
EOF
```

4. To choose a cutoff value which can captures as much of the diversity and <br/>
also eliminates sequences that are likely errors.
```
$parallel --no-notice -j 8 mawk -v x=4 \''$1 >= x'\' ::: *.uniq.seqs | cut -f2 | perl -e 'while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}' > uniqCperindv
$head uniqCperindv
$wc -l uniqCperindv
>>12699 uniqCperindv
```

5. To restrict data by the number of different individuals a sequence appears within.
```
$for ((i = 2; i <= 10; i++)); do echo $i >> ufile; done
$head ufile
$cat ufile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniqCperindv | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.peri.data
$head uniqseq.peri.data
```

6. Another cutoff value.
```
$mawk -v x=4 '$1 >= x' uniqCperindv > uniq.k.4.c.4.seqs
$wc -l uniq.k.4.c.4.seqs
>>7989 uniq.k.4.c.4.seqs
```

7. To convert sequences back into fasta format.
```
$cut -f2 uniq.k.4.c.4.seqs > totaluniqseq
$mawk '{c= c + 1; print ">Contig_" c "\n" $1}' totaluniqseq > uniq.fasta
$more uniq.fasta
```

8. To start assembling reference contigs by first extracting the forward reads.
```
$sed -e 's/NNNNNNNNNN/\t/g' uniq.fasta | cut -f1 > uniq.F.fasta
$head uniq.F.fasta

#Using clustering by alignment via the program CD-hit to achieve more accurate clustering
$cd-hit-est -i uniq.F.fasta -o xxx -c 0.8 -T 0 -M 0 -g 1
$head xxx
$head xxx.clstr

#This code clusters all off the forward reads by 80% similarity.
$mawk '{if ($1 ~ /Cl/) clus = clus + 1; else  print $3 "\t" clus}' xxx.clstr | sed 's/[>Contig_,...]//g' | sort -g -k1 > sort.contig.cluster.ids
$head sort.contig.cluster.ids
$paste sort.contig.cluster.ids totaluniqseq > contig.cluster.totaluniqseq
$head contig.cluster.totaluniqseq
$sort -k2,2 -g contig.cluster.totaluniqseq | sed -e 's/NNNNNNNNNN/\t/g' > rcluster

#To examine the output rcluster file
$head rcluster
$head sort.contig.cluster.ids
$cut -f2 rcluster | uniq | wc -l
>>1234
```

9. Rainbow is to split clusters formed in the first step into smaller clusters representing significant variants. <br/>
Think of it in this way: The first clustering steps found RAD loci, and this step is splitting the loci into alleles. <br/>
This also helps to break up over clustered sequences.
```
$rainbow div -i rcluster -o rbdiv.out
$head rbdiv.out

#The parameter -f can be set to control what is the minimum frequency of an allele necessary
to divide it into its own cluster. Since this is from multiple individuals, we want to lower 
this from the default of 0.2.
$rainbow div -i rcluster -o rbdiv.out -f 0.5 -K 10

#To use the paired end reads to merge divided clusters. 
$rainbow merge -o rbasm.out -a -i rbdiv.out

#To add -r parameter (the minimum number of reads to assemble)
$rainbow merge -o rbasm.out -a -i rbdiv.out -r 2

#rbasm output lists optimal and suboptimal contigs
$cat rbasm.out <(echo "E") |sed 's/[0-9]*:[0-9]*://g' | mawk ' {
if (NR == 1) e=$2;
else if ($1 ~/E/ && lenp > len1) {c=c+1; print ">dDocent_Contig_" e "\n" seq2 "NNNNNNNNNN" seq1; seq1=0; seq2=0;lenp=0;e=$2;fclus=0;len1=0;freqp=0;lenf=0}
else if ($1 ~/E/ && lenp <= len1) {c=c+1; print ">dDocent_Contig_" e "\n" seq1; seq1=0; seq2=0;lenp=0;e=$2;fclus=0;len1=0;freqp=0;lenf=0}
else if ($1 ~/C/) clus=$2;
else if ($1 ~/L/) len=$2;
else if ($1 ~/S/) seq=$2;
else if ($1 ~/N/) freq=$2;
else if ($1 ~/R/ && $0 ~/0/ && $0 !~/1/ && len > lenf) {seq1 = seq; fclus=clus;lenf=len}
else if ($1 ~/R/ && $0 ~/0/ && $0 ~/1/) {seq1 = seq; fclus=clus; len1=len}
else if ($1 ~/R/ && $0 ~!/0/ && freq > freqp && len >= lenp || $1 ~/R/ && $0 ~!/0/ && freq == freqp && len > lenp) {seq2 = seq; lenp = len; freqp=freq}
}' > rainbow.fasta
```

10. Program cd-hit to perform alignment and clustering by sequence similarity
```
$cd-hit-est -i rainbow.fasta -o referenceRC.fasta -M 0 -T 0 -c 0.9
>>1235 clusters
$curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/remake_reference.sh

#Remake a reference by calling the script along with a new cutoff value and similarity.
$cat remake_reference.sh
$bash remake_reference.sh 4 4 0.90 PE 2
>>1235

$bash ReferenceOpt.sh 4 8 4 8 PE 16
>>Average contig number = 1234.27
The top three most common number of contigs
X	Contig number
191	1234
52	1235
6	1236
The top three most common number of contigs (with values rounded)
X	Contig number
250	1200
```

11. To use simple shell commands to query data.
```
$wc -l reference.fasta
>>2470 reference.fasta

$mawk '/>/' reference.fasta | wc -l
>>1235 

#To test all sequences follow the expected format
$mawk '/^NAATT.*N*.*CCGN$/' reference.fasta | wc -l
>>1235
$grep '^NAATT.*N*.*CCGN$' reference.fasta | wc -l
>>1235
```

#### How many loci are there?
#### 1235
