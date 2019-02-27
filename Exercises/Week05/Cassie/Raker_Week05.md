## Week 5 Exercise
#### Cassie Raker (with lots of help from)
###### Puritz, J. B., Hollenbeck, C. M., Gold, J. R. dDocent: a RADseq, variant-calling pipeline designed for population genomics of non-model organisms. PeerJ 2:e431

###### Puritz, J.B., Matz, M. V., Toonen, R. J., Weber, J. N., Bolnick, D. I., Bird, C. E. Comment: Demystifying the RAD fad. Molecular Ecology 23: 5937–5942. doi: 10.1111/mec.12965

.
### Get Data for Exercise and Prep Environment
###### Log onto KITT
```
ssh -p 2292 craker@kitt.uri.edu
```
###### Create directory for exercise and navigate to that directory
```
mkdir Week5.Ex
cd Week5.Ex
```

###### Create dDocent conda environment and activate it
```
conda create -n ddocent_env ddocent
conda activate ddocent_env
```

###### Copy data from class directory (data has already been demultiplexed)
```
cp /home/BIO594/DATA/Week5/*fq.gz .
```

### Reduce Data Set
###### Set shell variables for AWK
```
ls *.F.fq.gz > namelist
sed -i'' -e 's/.F.fq.gz//g' namelist
AWK1='BEGIN{P=1}{if(P==1||P==2){gsub(/^[@]/,">");print}; if(P==4)P=0; P++}'
AWK2='!/>/'
AWK3='!/NNN/'
PERLT='while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}'
```

###### Create set of forward reads
```
cat namelist | parallel --no-notice -j 8 "zcat {}.F.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.forward"
```
###### Same for PE reads
```
cat namelist | parallel --no-notice -j 8 "zcat {}.R.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.reverse"
```
###### Concate reads together
```
cat namelist | parallel --no-notice -j 8 "paste -d '-' {}.forward {}.reverse | mawk '$AWK3' | sed 's/-/NNNNNNNNNN/' | perl -e '$PERLT' > {}.uniq.seqs"
 ```
###### Within individual coverage level of unique reads
 ```
cat *.uniq.seqs > uniq.seqs
for i in {2..20};
do
echo $i >> pfile
done
cat pfile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniq.seqs | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.data
rm pfile
```
###### Plot uniqseq.data to the terminal
```
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
###### Examine plot to determine cutoff threshold
###### Cutoff at 4
```
parallel --no-notice -j 8 mawk -v x=4 \''$1 >= x'\' ::: *.uniq.seqs | cut -f2 | perl -e 'while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}' > uniqCperindv
wc -l uniqCperindv
```
###### There are now 12699 sequences
###### Reduce further by number of different individuals a sequence appears in
```
for ((i = 2; i <= 10; i++));
do
echo $i >> ufile
done

cat ufile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniqCperindv | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.peri.data
rm ufile
```
###### Plot the data again to determine further cutoffs
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
###### Cut off at 4 again (this worked well last time: it got rid of errors while preserving the diversity of the data!)
```
mawk -v x=4 '$1 >= x' uniqCperindv > uniq.k.4.c.4.seqs
wc -l uniq.k.4.c.4.seqs
```
###### There are now 7989 sequences

###### Convert back to fasta format
```
cut -f2 uniq.k.4.c.4.seqs > totaluniqseq
mawk '{c= c + 1; print ">Contig_" c "\n" $1}' totaluniqseq > uniq.fasta
```

### Assemble Reference Contigs
#### Find RAD loci
###### Extract forward reads
###### Changes 10N separator into a tab character and splits files
```
sed -e 's/NNNNNNNNNN/\t/g' uniq.fasta | cut -f1 > uniq.F.fasta
```
######
Use CD-hit along with rainbow to cluster all forward reads by 80% similarity
```
cd-hit-est -i uniq.F.fasta -o xxx -c 0.8 -T 0 -M 0 -g 1
```
###### Found 1234 clusters

###### Convert output of CD-hit to match ouput from the first phase of rainbow
```
mawk '{if ($1 ~ /Cl/) clus = clus + 1; else  print $3 "\t" clus}' xxx.clstr | sed 's/[>Contig_,...]//g' | sort -g -k1 > sort.contig.cluster.ids
paste sort.contig.cluster.ids totaluniqseq > contig.cluster.totaluniqseq
sort -k2,2 -g contig.cluster.totaluniqseq | sed -e 's/NNNNNNNNNN/\t/g' > rcluster
```
###### Count number of clusters in rcluster file
```
cut -f2 rcluster | uniq | wc -l
```
###### It's still 1234!
### There are 1234 loci

#### Split loci into alleles
###### Lower minimum frequency an allele needs to divide it into its own cluster (multiple individuals)
```
rainbow div -i rcluster -o rbdiv.out -f 0.5 -K 10
```
###### Merge divided clusters (PE) to double check
```
rainbow merge -o rbasm.out -a -i rbdiv.out -r 2
```
###### Use AWK to extract optimal contigs
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
###### Contigs aligned and clustered by sequence similarity using CD-hit
```
cd-hit-est -i rainbow.fasta -o referenceRC.fasta -M 0 -T 0 -c 0.9
```
###### Found 1235 clusters
### There are 1235 alleles

### Bash script (to double check and explore parameters)
```
curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/remake_reference.sh
```
###### Remaking the reference with different parameters
```
bash remake_reference.sh 4 4 0.90 PE 2
bash remake_reference.sh 5 5 0.95 PE 2
bash remake_reference.sh 2 7 0.70 PE 2
bash remake_reference.sh 1 1 0.99 PE 2
```
###### These found 1234, 1235, 1235, and 985 clusters, respectively
