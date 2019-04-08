## Week 5 Exercise 

Emma Strand  
BIO594 J.Puritz  
Last edited: 20190226

### How many loci are there?

I've placed some files in the `/home/BIO594/DATA/Week5/` directory.  They are ddRADseq files that have already been demultiplexed.  

Using your new RADSeq assembly skills:

* Post a markdown document to this directory showing your efforts to answer the question: 
	* How many loci are there in the data set?

* Post a `reference.fasta` file with your assembled reference

* You can use the material from class or anything else you might find at [dDocent.com](dDocent.com)

*The following steps were completed for this assignment. All information found from dDocent.com; designed and created by J.Purtiz.*  

**Downloading and running dDocent after Miniconda has been downloaded:**

Downloading dDocent  
`$ conda install ddocent` 

Adding the correct channels. We had defaults, conda-forge, and bioconda already added from previous assignments/exercises.  
`$ conda config --add channels r`  
`$ conda config --add channels defaults`  
`$ conda config --add channels conda-forge`  
`$ conda config --add channels bioconda`

Creating a dDocent nvironment in conda.  
`$ conda create -n ddcocent_env ddocent`

Activating the dDocent environment.  
`$ source activate ddocent_env`

Running dDocent.  
`$ dDocent`

**The examples for this assignment have already been demultiplexed, but if they hadn't, see** [http://ddocent.com/assembly/][reference-ddocent.com]  
[reference-ddocent.com]:http://ddocent.com/assembly/.

Creating a set of unique reads with counts for each individual. The following lines of code also set variables for the AWK and perl code commands.  
`$ ls *.F.fq.gz > namelist`  
`$ sed -i'' -e 's/.F.fq.gz//g' namelist`  
`$ AWK1='BEGIN{P=1}{if(P==1||P==2){gsub(/^[@]/,">");print}; if(P==4)P=0; P++}'`  
`$ AWK2='!/>/'`  
`$ AWK3='!/NNN/'`  
`$ PERLT='while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}'`


Setting forward reads for each individual. This sorts through fastq files and strips away the quality scores.
`$ cat namelist | parallel --no-notice -j 8 "zcat {}.F.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.forward"`

The following does the same for the PE (paired end) reads. Setting reverse reads for each individual. This sorts through fastq files and strips away the quality scores.
`$ cat namelist | parallel --no-notice -j 8 "zcat {}.R.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.reverse"`

The following concatentates the forward and PE reads together. There will be 10 N's in between the forward and reverse sequences. Then finds unique reads within the individual and counts the occurences (coverage). 
`$ cat namelist | parallel --no-notice -j 8 "paste -d '-' {}.forward {}.reverse | mawk '$AWK3' | sed 's/-/NNNNNNNNNN/' | perl -e '$PERLT' > {}.uniq.seqs"`


Sequences with small coverage levels within an individual are probably sequencing errors. In the assembly, it is therefore best to eliminate reads with low copy numbers to delete the noise.  

The follwing code sums up the # within individual coverage level of unique reads and uses a BASH loop to select the data above a certain copy # (2-20) and then print to a file.

`$ cat *.uniq.seqs > uniq.seqs`  
`$ for i in {2..20};`  
`$ do`  
`$ echo $i >> pfile`  
`$ done`
`$ cat pfile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniq.seqs | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.data`
`$ rm pfile`

To view the data file that was created in the previous lines of code:  
`$ more uniqseq.data`

To plot the data in this file: 

`$  gnuplot << \EOF`  
`$  set terminal dumb size 120, 30`  
`$  set autoscale`  
`$  set xrange [2:20]`  
`$  unset label`  
`$  set title "Number of Unique Sequences with More than X Coverage (Counted within individuals)"`  
`$  set xlabel "Coverage"`  
`$  set ylabel "Number of Unique Sequences"`  
`$  plot 'uniqseq.data' with lines notitle`  
`$  pause -1`  
`$  EOF`

The following code chooses a cutoff value. This value needs to include as much diversity of the data as possible, but also eliminate noise and likely errors in sequencing. 4 is a common value to use.  

`$ parallel --no-notice -j 8 mawk -v x=4 \''$1 >= x'\' ::: *.uniq.seqs | cut -f2 | perl -e 'while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}' > uniqCperindv`
`$ wc -l uniqCperindv`

The following code restricts the data by # of different individuals a sequence appears within.  
`$ for ((i = 2; i <= 10; i++));`
`$ do`
`$ echo $i >> ufile`
`$ done`

`$ cat ufile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniqCperindv | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.peri.data`
`$ rm ufile`

The following plots the edited data.  

`$ gnuplot << \EOF`  
`$ set terminal dumb size 120, 30`  
`$ set autoscale`  
`$ unset label`  
`$ set title "Number of Unique Sequences present in more than X Individuals"`  
`$ set xlabel "Number of Individuals"`  
`$ set ylabel "Number of Unique Sequences"`  
`$ plot 'uniqseq.peri.data' with lines notitle`  
`$ pause -1`  
`$ EOF`

The following code chooses a cuffoff value again.  
`$ mawk -v x=4 '$1 >= x' uniqCperindv > uniq.k.4.c.4.seqs`  
`$ wc -l uniq.k.4.c.4.seqs`

The following code converts the sequences back into FASTA format and adds a header (>Contig_) to each sequence.  
`$ cut -f2 uniq.k.4.c.4.seqs > totaluniqseq`
`$ mawk '{c= c + 1; print ">Contig_" c "\n" $1}' totaluniqseq > uniq.fasta`

Addressing potential Illumina adapters could be necessary at this step in the protocol. 

**All previous steps were concentrated on reducing the data set, and the following code is focused on assembling reference contigs.**

Extracting forward reads by replacing the 10 N separater with a tap character and then splitting the files:  
`$ sed -e 's/NNNNNNNNNN/\t/g' uniq.fasta | cut -f1 > uniq.F.fasta`

The following assembly is done by a combination of CD-hit and Rainbow programs.  
Clustering all of the forward reads by 80% similarity. 
`$ cd-hit-est -i uniq.F.fasta -o xxx -c 0.8 -T 0 -M 0 -g 1`

Converting output of CD-hit to match first phase of rainbow:
`$ mawk '{if ($1 ~ /Cl/) clus = clus + 1; else  print $3 "\t" clus}' xxx.clstr | sed 's/[>Contig_,...]//g' | sort -g -k1 > sort.contig.cluster.ids`
`$ paste sort.contig.cluster.ids totaluniqseq > contig.cluster.totaluniqseq`
`$ sort -k2,2 -g contig.cluster.totaluniqseq | sed -e 's/NNNNNNNNNN/\t/g' > rcluster`

The output looks like:
` Read_ID	Cluster_ID	Forward_Read	Reverse_Read`

To produce the exact number of clusters:  
`$ cut -f2 rcluster | uniq | wc -l`

This first step of rainbow that identified the number of clusters, which we can think of as the number of loci. The output of the last command will produce the answer we are looking for in this assignment.

**The command line run for the exercise.**  
$ mkdir week5data  
$ conda create -n week5data ddocent  
$ conda activate week5data  
$ 










