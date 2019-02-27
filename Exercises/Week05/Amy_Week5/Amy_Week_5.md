# Zyck Week 5 Exercise
****

### Steps to finding the number of loci in the data set

Copied Week5 data into new directory `radseqdata`

`$ mkdir radseqdata`

Created conda environment with `radseqdata`

`$ conda create -n radseqdata ddocent`

Activated conda

`$ conda activate radseqdata`

### Assembly

The following steps were completed following the Assembly tutorial for dDocent

_Created a set of uniq reads with counts for each individuals_

`$  ls *.F.fq.gz > namelist`

`$  sed -i'' -e 's/.F.fq.gz//g' namelist`

`$  AWK1='BEGIN{P=1}{if(P==1||P==2){gsub(/^[@]/,">");print}; if(P==4)P=0; P++}'`

`$  AWK2='!/>/'`

`$  AWK3='!/NNN/'`

`$  PERLT='while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}'`

 _Setting forward reads for each individual. This sorts through fastq files and strips away the quality scores._

`$  cat namelist | parallel --no-notice -j 8 "zcat {}.F.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.forward"`

_The following does the same for the PE (paired end) reads. Setting reverse reads for each individual. This sorts through fastq files and strips away the quality scores._

`$ cat namelist | parallel --no-notice -j 8 "zcat {}.R.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.reverse"`

_The following concatentates the forward and PE reads together. There will be 10 N's in between the forward and reverse sequences. Then finds unique reads within the individual and counts the occurences (coverage)._

`$  cat namelist | parallel --no-notice -j 8 "paste -d '-' {}.forward | mawk '$AWK3' | sed 's/-/NNNNNNNNNN/' | perl -e
'$PERLT' > {}.uniq.seqs"`

_Summed up number within the individual coverage level of unique reads in the data set._
_This code uses a BASH loop to select the data above a certain copy # (2-20) and then print to a file._

`$  cat *.uniq.seqs > uniq.seqs`

`$  for i in {2..20};`

 `$ do`

 `$ echo $i >> pfile`

 `$ done`

 `$ cat pfile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniq.seqs | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.data`

 `$ rm pfile`

 _To view the data file that was created in the previous lines of code:_

` $ more uniqseq.data`

 _To plot the data in this file:_

` $ gnuplot << \EOF`

` $ set terminal dumb size 120, 30`

` $ set autoscale`

` $ set xrange [2:20]`

` $ unset label`

 `$ set title "Number of Unique Sequences with More than X Coverage (Counted within individuals)"`

` $ set xlabel "Coverage"`

` $ set ylabel "Number of Unique Sequences"`

` $ plot 'uniqseq.data' with lines notitle`

` $ pause -1`

` $ EOF`

_The following code chooses a cutoff value that needs to include as much diversity of the data as possible, but also eliminate noise and likely errors in sequencing. Used the cutoff value of ***4***_

`$ parallel --no-notice -j 8 mawk -v x=4 \''$1 >= x'\' ::: *.uniq.seqs | cut -f2 | perl -e 'while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}' > uniqCperindv`

`$ wc -l uniqCperindv`

Output: `7159 uniqCperindv`

_Restricting data by the number of different individuals a sequence appears within_

`$ for ((i = 2; i <= 10; i++));`

 `$ do`

` $ echo $i >> ufile`

 `$ done`

 `$ cat ufile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniqCperindv | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.peri.data`

` $ rm ufile`

_Plotted the edited data_

_Choosing another cutoff value. Set cutoff value to ***4***_

`$ mawk -v x=4 '$1 >= x' uniqCperindv > uniq.k.4.c.4.seqs`

`$ wc -l uniq.k.4.c.4.seqs `

Output: `5100 uniq.k.4.c.4.seqs`

_Convert sequences back into fasta format and add a header  (>Contig_) to each sequence._

`$ cut -f2 uniq.k.4.c.4.seqs > totaluniqseq`

`$ mawk '{c= c + 1; print ">Contig_" c "\n" $1}' totaluniqseq > uniq.fasta`

### Assembly of reference contigs

_Extracting the forward reads by replacing the 10 N separater with a tap character and then splitting the files_

`$ sed -e 's/NNNNNNNNNN/\t/g' uniq.fasta | cut -f1 > uniq.F.fasta`

_Using CD-hit for more accurate clustering. Clustering all of the forward reads by 80% similarity._

`$ cd-hit-est -i uniq.F.fasta -o xxx -c 0.8 -T 0 -M 0 -g 1`

_Using `mawk` to convert the output of CD-hit to match the output of the first phase of rainbow_

`$ mawk '{if ($1 ~ /Cl/) clus = clus + 1; else  print $3 "\t" clus}' xxx.clstr | sed 's/[>Contig_,...]//g' | sort -g -k1 > sort.contig.cluster.ids`
` $ paste sort.contig.cluster.ids totaluniqseq > contig.cluster.totaluniqseq`

` $ sort -k2,2 -g contig.cluster.totaluniqseq | sed -e 's/NNNNNNNNNN/\t/g' > rcluster`

_Determining the actual number of clusters_

`$ cut -f2 rcluster | uniq | wc -l`

Output: ***1235***

_Splitting clusters into smaller clusters representing significant variants_

`$ rainbow div -i rcluster -o rbdiv.out`

_Adding parameters -f (to control the minimum frequency of an allele necessary to divide it into its own cluster) and -K (to control the minimum number of alleles to split regardless of frequency)_

`$ rainbow div -i rcluster -o rbdiv.out -f 0.5 -K 10`

_Step 3 of rainbow with parameter -r to set the minimum number of reads to assemble. r is set to 2_

`$ rainbow merge -o rbasm.out -a -i rbdiv.out -r 2`

_The rbasm output lists optimal and suboptimal contigs._

`$ cat rbasm.out <(echo "E") |sed 's/[0-9]*:[0-9]*://g' | mawk ' {`

` $ if (NR == 1) e=$2;`

`$ else if ($1 ~/E/ && lenp > len1) {c=c+1; print ">dDocent_Contig_" e "\n" seq2 "NNNNNNNNNN" seq1; seq1=0;
seq2=0;lenp=0;e=$2;fclus=0;len1=0;freqp=0;lenf=0}`

 `$ else if ($1 ~/E/ && lenp <= len1) {c=c+1; print ">dDocent_Contig_" e "\n" seq1; seq1=0; seq2=0;lenp=0;e=$2;fclus=0;len1=0;freqp=0;lenf=0}`

 `$ else if ($1 ~/C/) clus=$2;`

 `$ else if ($1 ~/L/) len=$2;`

 `$ else if ($1 ~/S/) seq=$2;`

 `$ else if ($1 ~/N/) freq=$2;`

 `$ else if ($1 ~/R/ && $0 ~/0/ && $0 !~/1/ && len > lenf) {seq1 = seq; fclus=clus;lenf=len}`

 `$ else if ($1 ~/R/ && $0 ~/0/ && $0 ~/1/) {seq1 = seq; fclus=clus; len1=len}`

 `$ else if ($1 ~/R/ && $0 ~!/0/ && freq > freqp && len >= lenp || $1 ~/R/ && $0 ~!/0/ && freq == freqp && len > lenp) {seq2 = seq; lenp = len; freqp=freq}`

` $ }' > rainbow.fasta`

_Use CD-hit to align and cluster contigs by sequencing similarity_

`$cd-hit-est -i rainbow.fasta -o referenceRC.fasta -M 0 -T 0 -c 0.9`

Using bash script remake_reference.sh

`$curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/remake_reference.sh`

_Remake a reference by calling the script along with a new cutoff value and similarity_

`$bash remake_reference.sh 4 4 0.90 PE 2`

Output: ***1235***

****
## How many loci are there in the data set?

## ***1235***
