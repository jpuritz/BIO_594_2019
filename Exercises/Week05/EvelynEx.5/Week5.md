
## Week5 Exercise

### create a directory and copy files 
```
mkdir Week5
cd Week5
cp /home/BIO594/DATA/Week5/* ./
```
### Activate ref_seq environment
```
conda activate ref_seq
```

### this command enables you to observe the sequence in an individual
```
less PopA_016.F.fq.gz
```
#### This code set shell variables to use awk and perl codes. It creates set of forward reads, strips off all quality scores and sequence identifies, creates reverse reads and concatenate forward and reverse reads and counts the uniq reads within the individual and find the coverage of each unique read.

```
ls *.F.fq.gz > namelist
sed -i'' -e 's/.F.fq.gz//g' namelist
AWK1='BEGIN{P=1}{if(P==1||P==2){gsub(/^[@]/,">");print}; if(P==4)P=0; P++}'
AWK2='!/>/'
AWK3='!/NNN/'
PERLT='while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}'

cat namelist | parallel --no-notice -j 8 "zcat {}.F.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.forward"
cat namelist | parallel --no-notice -j 8 "zcat {}.R.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.reverse"
cat namelist | parallel --no-notice -j 8 "paste -d '-' {}.forward {}.reverse | mawk '$AWK3' | sed 's/-/NNNNNNNNNN/' | perl -e '$PERLT' > {}.uniq.seqs"
```
### To begin Assembly
### sequences within individuals with very low coverage  could be sequencing errors and so will be remove from the assembly.
#### We begin by selecting a range of coverage of each unique sequence in each individual.
#### This code prints all the unique sequences in each individual and assigns all of them to a variable. it then selects unique sequences within a coverage range of 2 to 20
```
cat *.uniq.seqs > uniq.seqs
for i in {2..20};
do
echo $i >> pfile
done
cat pfile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniq.seqs | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.data
rm pfile
```
#### Unique sequences within range of coverage selected

```
cov   sequence
2	    126508
3	    122492
4	    121026
5	    119357
6	    117552
7	    115633
8	    113606
9	    111449
10	  109143
11	  106710
12	  104198
13	  101560
14	  98723
15	  95844
16	  92812
17	  89829
18	  86728
19	  83535
20	  80401
```
### Representing the coverage and the sequences on a graph
```
code
gnuplot << \EOF
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
```
Number of Unique Sequences with More than X Coverage (Counted within individuals)

130000 +-+---------+-----------+-----------+-----------+----------+-----------+-----------+-----------+---------+-+
+           +           +           +           +          +           +           +           +           +
125000 ******                                                                                                   +-+
|     ******                                                                                               |
|           ******                                                                                         |
120000 +-+               ******                                                                                 +-+
|                       ******                                                                             |
115000 +-+                           ******                                                                     +-+
|                                   ******                                                                 |
110000 +-+                                       ******                                                         +-+
|                                               ******                                                     |
105000 +-+                                                   *****                                              +-+
|                                                          ******                                          |
|                                                                ******                                    |
100000 +-+                                                                    *****                             +-+
|                                                                           *                              |
95000 +-+                                                                          ******                      +-+
|                                                                                  ******                  |
90000 +-+                                                                                      *****           +-+
|                                                                                             *            |
|                                                                                              ******      |
85000 +-+                                                                                                  *****-+
+           +           +           +           +          +           +           +           +          *+
80000 +-+---------+-----------+-----------+-----------+----------+-----------+-----------+-----------+---------+-*
2           4           6           8           10         12          14          16          18          20
Coverage
```
#### Unique sequences with a coverage of four (4) is selected

```
parallel --no-notice -j 8 mawk -v x=4 \''$1 >= x'\' ::: *.uniq.seqs | cut -f2 | perl -e 'while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}' > uniqCperindv
wc -l uniqCperindv
```
##### 12699 unique sequences within coverage of 4

### The unique sequences or loci should be present in atleast most of the individuals, a cut off value is selected for how many individuals a sequence should be present in.
```
for ((i = 2; i <= 10; i++));
do
echo $i >> ufile
done
cat ufile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniqCperindv | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.peri.data
rm ufile
```
#### choosing a range from 2 to 10 individual a unique sequence should be present it
```
cat uniqseq.peri.data
cov   sequence
2	    10222
3	    8906
4	    7989
5	    7345
6	    6769
7	    6294
8	    5853
9	    5433
10	  5114
```
### Again plotting the data above,
```
gnuplot << \EOF
set terminal dumb size 120, 30
set autoscale
unset label
set title "Number of Unique Sequences present in more than X Individuals"
set xlabel "Number of Individuals"
set ylabel "Number of Unique Sequences"
plot 'uniqseq.peri.data' with lines notitle
pause -1
EOF
```
```

Number of Unique Sequences present in more than X Individuals

11000 +-+-----------+------------+-------------+------------+-------------+------------+-------------+----------+-+
+             +            +             +            +             +            +             +            +
|                                                                                                           |
*****                                                                                                       |
10000 +-+  **                                                                                                   +-+
|      ***                                                                                                  |
|         ***                                                                                               |
|            *                                                                                              |
9000 +-+           *****                                                                                       +-+
|                  ****                                                                                     |
|                      ***                                                                                  |
8000 +-+                       *                                                                               +-+
|                          ***********                                                                      |
|                                     ***                                                                   |
|                                        **********                                                         |
7000 +-+                                                ***                                                    +-+
|                                                     ***********                                           |
|                                                                ***                                        |
|                                                                   **********                              |
6000 +-+                                                                           ***                         +-+
|                                                                                **************             |
|                                                                                              **********   |
+             +            +             +            +             +            +             +         ***+
5000 +-+-----------+------------+-------------+------------+-------------+------------+-------------+----------+-*
2             3            4             5            6             7            8             9            10
Number of Individuals
```
#### A cut off value of the number of individual is chosing and should capture much of the unique sequences.
```
mawk -v x=4 '$1 >= x' uniqCperindv > uniq.k.4.c.4.seqs
wc -l uniq.k.4.c.4.seqs
this leaves us with 7989 unique sequences
```
#### Next, the unique sequences with the selected cut off values will now be collapsed into fasta format and assign the header (contig) for the next steps in our denovo Assembly

```
cut -f2 uniq.k.4.c.4.seqs > totaluniqseq
mawk '{c= c + 1; print ">Contig_" c "\n" $1}' totaluniqseq > uniq.fasta
```
#### The forward reads from each of of the contigs are extracted
```
sed -e 's/NNNNNNNNNN/\t/g' uniq.fasta | cut -f1 > uniq.F.fasta
```
#### the program CD-hit is used to cluster the forward reads  by 80% similarity
```
cd-hit-est -i uniq.F.fasta -o xxx -c 0.8 -T 0 -M 0 -g 1
```
##### 1234  clusters out of 7989 sequences were obtained with CD-hit program
#### Next is to use the program Rainbow to break the previous clusters into sort of alleles.
##### To use the program Rainbow, we need to convert the output of CD-hit

 ```
 mawk '{if ($1 ~ /Cl/) clus = clus + 1; else  print $3 "\t" clus}' xxx.clstr | sed 's/[>Contig_,...]//g' | sort -g -k1 > sort.contig.cluster.ids
paste sort.contig.cluster.ids totaluniqseq > contig.cluster.totaluniqseq
sort -k2,2 -g contig.cluster.totaluniqseq | sed -e 's/NNNNNNNNNN/\t/g' > rcluster
```
#### Next, we use rainbow to cluster using the flags -f (this will set the minimum allele frequency to divide a cluster) and -k flag tells the number of cluster to split

```
rainbow div -i rcluster -o rbdiv.out -f 0.5 -K 10
```
#### Next is to use paired end reads to merge the divided clusters. This is to check that the divided clusters using the Rainbow program are alleles from the same homologous locus.
```
rainbow merge -o rbasm.out -a -i rbdiv.out -r 2
```
#### Next is to obtain assembled contigs containing forward and PE reads, also output the longest contig between two contigs with equal reads.
```
cat rbasm.out <(echo "E") |sed 's/[0-9]*:[0-9]*://g' | mawk ' {
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
#### Next, CD-hit is used again to  cluster the contigs by sequence similarity of 90%.
```
cd-hit-est -i rainbow.fasta -o referenceRC.fasta -M 0 -T 0 -c 0.9
```
### 1235 loci have been assembled denovo from this data set
