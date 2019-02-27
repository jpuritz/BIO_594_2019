Week 5 exercise
===============

*How many loci are there in the data set?*

*(The codes in this markdown is taken from dDocent assembly manual: [http://ddocent.com/assembly/](http://ddocent.com/assembly/)*

**1.**  Since our reads have been already demultiplexed, we can start directly to mapping. First, we create a set of forward & reverse reads for each individual. Then, we concatenate the forward and reverse reads together (10 Ns between them). And then find the unique reads within that individual and counts the occurrences (coverage).

       ls *.F.fq.gz > namelist
       sed -i'' -e 's/.F.fq.gz//g' namelist

       AWK1='BEGIN{P=1}{if(P==1||P==2){gsub(/^[@]/,">");print}; if(P==4)P=0; P++}'

       AWK2='!/>/'

       AWK3='!/NNN/'

       PERLT='while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}'

       cat namelist | parallel --no-notice -j 8 "zcat {}.F.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.forward"

       cat namelist | parallel --no-notice -j 8 "zcat {}.R.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.reverse"

       cat namelist | parallel --no-notice -j 8 "paste -d '-' {}.forward {}.reverse | mawk '$AWK3' | sed 's/-/NNNNNNNNNN/' | perl -e '$PERLT' > {}.uniq.seqs"


**2.** Next, we find the number the within individual coverage level of unique reads in the data set.

    cat *.uniq.seqs > uniq.seqs

    for i in {2..20};
    do
    echo $i >> pfile
    done

    cat pfile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniq.seqs | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.data

    rm pfile

**3**. To look of the contents of uniqseq.data

    more uniqseq.data

  _Output_:

    2	126508
    3	122492
    4	121026
    5	119357
    6	117552
    7	115633
    8	113606
    9	111449
    10	109143
    11	106710
    12	104198
    13	101560
    14	98723
    15	95844
    16	92812
    17	89829
    18	86728
    19	83535
    20	80401

**4**. To plot Number of Unique Sequences with More than X Coverage:

    gnuplot << \EOF
    set terminal dumb size 120, 30
    set autoscale
    set xrange [2:20]
    unset label
    set title "Number of Unique Sequences with More than X Coverage (Counted within individuals)"
    set xlabel "Coverage"
    set ylabel "Number of Unique Sequences"
    lot 'uniqseq.data' with lines notitle
    pause -1
    EOF

_Output looks like this_:

            Number of Unique Sequences with More than X Coverage (Counted within individuals)

    130000 +--------------------------------------------------------------------------------+
           |        +        +        +        +        +        +        +        +        |
    125000 |****                                                                          +-|
           |    ****                                                                        |
           |        *****                                                                   |
    120000 |-+           ****                                                             +-|
           |                 *****                                                          |
    115000 |-+                    ****                                                    +-|
           |                          *****                                                 |
    110000 |-+                             ****                                           +-|
           |                                   *****                                        |
    105000 |-+                                      ****                                  +-|
           |                                            *****                               |
           |                                                 ****                           |
    100000 |-+                                                   ****                     +-|
           |                                                         *                      |
    95000  |-+                                                        ****                +-|
           |                                                              *****             |
    90000  |-+                                                                 ***        +-|
           |                                                                      *         |
           |                                                                       *****    |
    85000  |-+                                                                          ***-|
           |        +        +        +        +        +        +        +        +       *|
    80000  +--------------------------------------------------------------------------------+
           2        4        6        8        10       12       14       16       18       20
                                               Coverage


**5.** We determine a cutoff value to eliminate the possible erroneous sequence (4)

    parallel --no-notice -j 8 mawk -v x=4 \''$1 >= x'\' ::: *.uniq.seqs | cut -f2 | perl -e 'while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}' > uniqCperindv
    wc -l uniqCperindv

_Output:_

    12699 uniqCperindv

**6.** Restricting data by the number of different individuals a sequence appears within:

    for ((i = 2; i <= 10; i++));
    do
    echo $i >> ufile
    done

    cat ufile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniqCperindv | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.peri.data


    rm ufile

**7.** Again we choose cutoff value (4)

    mawk -v x=4 '$1 >= x' uniqCperindv > uniq.k.4.c.4.seqs
    wc -l uniq.k.4.c.4.seqs

_Output_

    7989 uniq.k.4.c.4.seqs

**8.** Converting the sequences back into fasta format.

    cut -f2 uniq.k.4.c.4.seqs > totaluniqseq
    mawk '{c= c + 1; print ">Contig_" c "\n" $1}' totaluniqseq > uniq.fasta


**9.** Extracting the forward reads.

    sed -e 's/NNNNNNNNNN/\t/g' uniq.fasta | cut -f1 > uniq.F.fasta

**10.** Clustering all off the forward reads by 80% similarity.

    cd-hit-est -i uniq.F.fasta -o xxx -c 0.8 -T 0 -M 0 -g 1

**11.** Converting the output of CD-hit to match the output of the first phase of rainbow:

    mawk '{if ($1 ~ /Cl/) clus = clus + 1; else  print $3 "\t" clus}' xxx.clstr | sed 's/[>Contig_,...]//g' | sort -g -k1 > sort.contig.cluster.ids
    paste sort.contig.cluster.ids totaluniqseq > contig.cluster.totaluniqseq
    sort -k2,2 -g contig.cluster.totaluniqseq | sed -e 's/NNNNNNNNNN/\t/g' > rcluster

**12.** **Total number of loci:**

     cut -f2 rcluster | uniq | wc -l

_Output:_

    1234
