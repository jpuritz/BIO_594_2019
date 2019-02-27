### Copying ddRADseq files that have already been demultiplexed to my working dir

    cp -r /home/BIO594/DATA/Week5/*fq.gz ./ 

### Checking out files

    ls -l

    ## total 1461292
    ## -rw-r--r--+ 1 mgomez mgomez       704 Feb 26 18:36 assemble.trim.log
    ## -rw-r--r--+ 1 mgomez mgomez      1254 Feb 26 18:36 cdhit.log
    ## -rw-r--r--+ 1 mgomez mgomez   2085395 Feb 26 18:36 contig.cluster.totaluniqseq
    ## -rw-r--r--+ 1 mgomez mgomez    249351 Feb 26 18:36 fastp.html
    ## -rw-r--r--+ 1 mgomez mgomez     64136 Feb 26 18:36 fastp.json
    ## -rw-r--r--+ 1 mgomez mgomez       369 Feb 26 18:36 index.log
    ## -rw-r--r--+ 1 mgomez mgomez      3500 Feb 26 18:36 kopt.data
    ## -rw-r--r--+ 1 mgomez mgomez      1577 Feb 26 18:36 kopt.log
    ## -rw-r--r--+ 1 mgomez mgomez     10974 Feb 26 21:39 MatiasEx5_1.Rmd
    ## -rw-r--r--+ 1 mgomez mgomez    808771 Feb 26 18:36 MatiasEx5.html
    ## -rw-r--r--+ 1 mgomez mgomez     10964 Feb 26 18:16 MatiasEx5.Rmd
    ## -rw-r--r--+ 1 mgomez mgomez       720 Feb 26 18:23 namelist
    ## -rw-r--r--+ 1 mgomez mgomez    337832 Feb 26 18:36 other.FR
    ## -rw-r--r--+ 1 mgomez mgomez         0 Feb 26 18:36 overlap.assembled.fastq
    ## -rw-r--r--+ 1 mgomez mgomez         0 Feb 26 18:36 overlap.discarded.fastq
    ## -rw-r--r--+ 1 mgomez mgomez         0 Feb 26 18:36 overlap.fasta
    ## -rw-r--r--+ 1 mgomez mgomez         0 Feb 26 18:36 overlap.loci.names
    ## -rw-r--r--+ 1 mgomez mgomez    316290 Feb 26 18:36 overlap.unassembled.forward.fastq
    ## -rw-r--r--+ 1 mgomez mgomez    342084 Feb 26 18:36 overlap.unassembled.reverse.fastq
    ## -rw-r--r--+ 1 mgomez mgomez      1250 Feb 26 18:36 plot.kopt.data
    ## -rwxr-xr-x+ 1 mgomez mgomez    261115 Feb 26 21:39 PopA_001.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6017427 Feb 26 18:23 PopA_001.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6480306 Feb 26 18:23 PopA_001.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    275538 Feb 26 21:39 PopA_001.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2451720 Feb 26 18:23 PopA_001.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    254770 Feb 26 21:39 PopA_002.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5851755 Feb 26 18:23 PopA_002.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6301890 Feb 26 18:23 PopA_002.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    270472 Feb 26 21:39 PopA_002.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2379557 Feb 26 18:23 PopA_002.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257369 Feb 26 21:39 PopA_003.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5914701 Feb 26 18:23 PopA_003.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6369678 Feb 26 18:23 PopA_003.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    272247 Feb 26 21:39 PopA_003.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2405456 Feb 26 18:23 PopA_003.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    263832 Feb 26 21:39 PopA_004.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6123546 Feb 26 18:23 PopA_004.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6594588 Feb 26 18:23 PopA_004.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    280410 Feb 26 21:39 PopA_004.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2556104 Feb 26 18:23 PopA_004.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    263717 Feb 26 21:39 PopA_005.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6128343 Feb 26 18:23 PopA_005.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6599754 Feb 26 18:23 PopA_005.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    279951 Feb 26 21:39 PopA_005.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2505327 Feb 26 18:23 PopA_005.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    258822 Feb 26 21:39 PopA_006.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5943951 Feb 26 18:23 PopA_006.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6401178 Feb 26 18:23 PopA_006.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    273846 Feb 26 21:39 PopA_006.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2446882 Feb 26 18:23 PopA_006.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257318 Feb 26 21:39 PopA_007.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5915052 Feb 26 18:23 PopA_007.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6370056 Feb 26 18:23 PopA_007.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    273164 Feb 26 21:39 PopA_007.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2428319 Feb 26 18:23 PopA_007.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    255227 Feb 26 21:39 PopA_008.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5847426 Feb 26 18:23 PopA_008.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6297228 Feb 26 18:23 PopA_008.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    269683 Feb 26 21:39 PopA_008.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2367876 Feb 26 18:23 PopA_008.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    258662 Feb 26 21:39 PopA_009.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5963139 Feb 26 18:23 PopA_009.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6421842 Feb 26 18:23 PopA_009.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    273652 Feb 26 21:39 PopA_009.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2423263 Feb 26 18:23 PopA_009.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    253804 Feb 26 21:39 PopA_010.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5812911 Feb 26 18:23 PopA_010.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6260058 Feb 26 18:23 PopA_010.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    269410 Feb 26 21:39 PopA_010.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2390990 Feb 26 18:23 PopA_010.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    253840 Feb 26 21:39 PopA_011.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5833737 Feb 26 18:23 PopA_011.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6282486 Feb 26 18:23 PopA_011.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    272337 Feb 26 21:39 PopA_011.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2375206 Feb 26 18:23 PopA_011.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    264591 Feb 26 21:39 PopA_012.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6113484 Feb 26 18:23 PopA_012.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6583752 Feb 26 18:23 PopA_012.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    283074 Feb 26 21:39 PopA_012.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2535802 Feb 26 18:23 PopA_012.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    255176 Feb 26 21:39 PopA_013.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5854212 Feb 26 18:23 PopA_013.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6304536 Feb 26 18:23 PopA_013.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    273445 Feb 26 21:39 PopA_013.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2411048 Feb 26 18:23 PopA_013.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257339 Feb 26 21:39 PopA_014.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5900778 Feb 26 18:23 PopA_014.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6354684 Feb 26 18:23 PopA_014.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    275479 Feb 26 21:39 PopA_014.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2415395 Feb 26 18:23 PopA_014.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    260571 Feb 26 21:39 PopA_015.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6023628 Feb 26 18:23 PopA_015.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6486984 Feb 26 18:23 PopA_015.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    279628 Feb 26 21:39 PopA_015.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2497150 Feb 26 18:23 PopA_015.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    261495 Feb 26 21:39 PopA_016.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6025266 Feb 26 18:23 PopA_016.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6488748 Feb 26 18:23 PopA_016.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    279479 Feb 26 21:39 PopA_016.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2484468 Feb 26 18:23 PopA_016.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    259285 Feb 26 21:39 PopA_017.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5996601 Feb 26 18:23 PopA_017.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6457878 Feb 26 18:23 PopA_017.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    277867 Feb 26 21:39 PopA_017.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2455262 Feb 26 18:23 PopA_017.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    254875 Feb 26 21:39 PopA_018.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5845554 Feb 26 18:23 PopA_018.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6295212 Feb 26 18:23 PopA_018.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    273860 Feb 26 21:39 PopA_018.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2406996 Feb 26 18:23 PopA_018.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    260329 Feb 26 21:39 PopA_019.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6016842 Feb 26 18:23 PopA_019.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6479676 Feb 26 18:23 PopA_019.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    279228 Feb 26 21:39 PopA_019.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2450936 Feb 26 18:23 PopA_019.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    260277 Feb 26 21:39 PopA_020.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5997888 Feb 26 18:23 PopA_020.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6459264 Feb 26 18:23 PopA_020.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    278145 Feb 26 21:39 PopA_020.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2458802 Feb 26 18:23 PopA_020.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    259215 Feb 26 21:39 PopB_001.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5963022 Feb 26 18:23 PopB_001.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6421716 Feb 26 18:23 PopB_001.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    274302 Feb 26 21:39 PopB_001.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2436986 Feb 26 18:23 PopB_001.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257510 Feb 26 21:39 PopB_002.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5937867 Feb 26 18:23 PopB_002.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6394626 Feb 26 18:23 PopB_002.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    272763 Feb 26 21:39 PopB_002.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2394537 Feb 26 18:23 PopB_002.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    261662 Feb 26 21:39 PopB_003.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6069492 Feb 26 18:23 PopB_003.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6536376 Feb 26 18:23 PopB_003.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    277990 Feb 26 21:39 PopB_003.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2440793 Feb 26 18:23 PopB_003.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    261767 Feb 26 21:39 PopB_004.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6031584 Feb 26 18:23 PopB_004.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6495552 Feb 26 18:23 PopB_004.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    277075 Feb 26 21:39 PopB_004.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2487550 Feb 26 18:23 PopB_004.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    256750 Feb 26 21:39 PopB_005.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5912712 Feb 26 18:23 PopB_005.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6367536 Feb 26 18:23 PopB_005.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    273399 Feb 26 21:39 PopB_005.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2468723 Feb 26 18:23 PopB_005.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    262932 Feb 26 21:39 PopB_006.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6095115 Feb 26 18:23 PopB_006.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6563970 Feb 26 18:23 PopB_006.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    279452 Feb 26 21:39 PopB_006.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2493363 Feb 26 18:23 PopB_006.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257314 Feb 26 21:39 PopB_007.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5912946 Feb 26 18:23 PopB_007.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6367788 Feb 26 18:23 PopB_007.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    273244 Feb 26 21:39 PopB_007.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2462366 Feb 26 18:23 PopB_007.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    258055 Feb 26 21:39 PopB_008.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5952492 Feb 26 18:23 PopB_008.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6410376 Feb 26 18:23 PopB_008.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    273482 Feb 26 21:39 PopB_008.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2399617 Feb 26 18:23 PopB_008.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    256509 Feb 26 21:39 PopB_009.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5909202 Feb 26 18:23 PopB_009.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6363756 Feb 26 18:23 PopB_009.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    272659 Feb 26 21:39 PopB_009.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2401885 Feb 26 18:23 PopB_009.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    253074 Feb 26 21:39 PopB_010.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5772546 Feb 26 18:23 PopB_010.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6216588 Feb 26 18:23 PopB_010.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    268097 Feb 26 21:39 PopB_010.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2411537 Feb 26 18:23 PopB_010.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257615 Feb 26 21:39 PopB_011.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5920668 Feb 26 18:23 PopB_011.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6376104 Feb 26 18:23 PopB_011.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    276159 Feb 26 21:39 PopB_011.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2473268 Feb 26 18:23 PopB_011.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    263081 Feb 26 21:39 PopB_012.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6094530 Feb 26 18:23 PopB_012.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6563340 Feb 26 18:23 PopB_012.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    281700 Feb 26 21:39 PopB_012.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2500493 Feb 26 18:23 PopB_012.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257858 Feb 26 21:39 PopB_013.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5930379 Feb 26 18:23 PopB_013.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6386562 Feb 26 18:23 PopB_013.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    276649 Feb 26 21:39 PopB_013.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2447632 Feb 26 18:23 PopB_013.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    260462 Feb 26 21:39 PopB_014.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5998005 Feb 26 18:23 PopB_014.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6459390 Feb 26 18:23 PopB_014.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    279200 Feb 26 21:39 PopB_014.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2482942 Feb 26 18:23 PopB_014.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    255873 Feb 26 21:39 PopB_015.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5890248 Feb 26 18:23 PopB_015.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6343344 Feb 26 18:23 PopB_015.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    274747 Feb 26 21:39 PopB_015.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2428315 Feb 26 18:23 PopB_015.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    259898 Feb 26 21:39 PopB_016.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5988060 Feb 26 18:23 PopB_016.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6448680 Feb 26 18:23 PopB_016.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    278896 Feb 26 21:39 PopB_016.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2489294 Feb 26 18:23 PopB_016.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    258838 Feb 26 21:39 PopB_017.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5980338 Feb 26 18:23 PopB_017.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6440364 Feb 26 18:23 PopB_017.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    278056 Feb 26 21:39 PopB_017.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2428857 Feb 26 18:23 PopB_017.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    252701 Feb 26 21:39 PopB_018.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5784012 Feb 26 18:23 PopB_018.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6228936 Feb 26 18:23 PopB_018.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    271762 Feb 26 21:39 PopB_018.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2370663 Feb 26 18:23 PopB_018.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    252377 Feb 26 21:39 PopB_019.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5754762 Feb 26 18:23 PopB_019.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6197436 Feb 26 18:23 PopB_019.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    270457 Feb 26 21:39 PopB_019.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2379805 Feb 26 18:23 PopB_019.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    258346 Feb 26 21:39 PopB_020.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5955300 Feb 26 18:23 PopB_020.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6413400 Feb 26 18:23 PopB_020.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    276892 Feb 26 21:39 PopB_020.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2442059 Feb 26 18:23 PopB_020.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    256668 Feb 26 21:39 PopC_001.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5906160 Feb 26 18:23 PopC_001.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6360480 Feb 26 18:23 PopC_001.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    272647 Feb 26 21:39 PopC_001.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2441792 Feb 26 18:23 PopC_001.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257381 Feb 26 21:39 PopC_002.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5917041 Feb 26 18:23 PopC_002.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6372198 Feb 26 18:23 PopC_002.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    272771 Feb 26 21:39 PopC_002.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2429573 Feb 26 18:23 PopC_002.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    263312 Feb 26 21:39 PopC_003.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6133257 Feb 26 18:23 PopC_003.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6605046 Feb 26 18:23 PopC_003.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    280032 Feb 26 21:39 PopC_003.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2508588 Feb 26 18:23 PopC_003.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    254852 Feb 26 21:39 PopC_004.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5834556 Feb 26 18:23 PopC_004.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6283368 Feb 26 18:23 PopC_004.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    269692 Feb 26 21:39 PopC_004.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2360518 Feb 26 18:23 PopC_004.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257703 Feb 26 21:39 PopC_005.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5948397 Feb 26 18:23 PopC_005.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6405966 Feb 26 18:23 PopC_005.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    273685 Feb 26 21:39 PopC_005.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2411561 Feb 26 18:23 PopC_005.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    254838 Feb 26 21:39 PopC_006.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5815017 Feb 26 18:23 PopC_006.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6262326 Feb 26 18:23 PopC_006.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    269957 Feb 26 21:39 PopC_006.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2405727 Feb 26 18:23 PopC_006.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    258107 Feb 26 21:39 PopC_007.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5938452 Feb 26 18:23 PopC_007.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6395256 Feb 26 18:23 PopC_007.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    273485 Feb 26 21:39 PopC_007.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2424296 Feb 26 18:23 PopC_007.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    255422 Feb 26 21:39 PopC_008.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5851287 Feb 26 18:23 PopC_008.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6301386 Feb 26 18:23 PopC_008.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    271798 Feb 26 21:39 PopC_008.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2388477 Feb 26 18:23 PopC_008.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    254402 Feb 26 21:39 PopC_009.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5824260 Feb 26 18:23 PopC_009.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6272280 Feb 26 18:23 PopC_009.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    270509 Feb 26 21:39 PopC_009.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2420451 Feb 26 18:23 PopC_009.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257645 Feb 26 21:39 PopC_010.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5942664 Feb 26 18:23 PopC_010.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6399792 Feb 26 18:23 PopC_010.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    274407 Feb 26 21:39 PopC_010.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2443081 Feb 26 18:23 PopC_010.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    258391 Feb 26 21:39 PopC_011.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5944536 Feb 26 18:23 PopC_011.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6401808 Feb 26 18:23 PopC_011.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    276825 Feb 26 21:39 PopC_011.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2421485 Feb 26 18:23 PopC_011.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    260572 Feb 26 21:39 PopC_012.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6005610 Feb 26 18:23 PopC_012.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6467580 Feb 26 18:23 PopC_012.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    279462 Feb 26 21:39 PopC_012.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2490588 Feb 26 18:23 PopC_012.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    256271 Feb 26 21:39 PopC_013.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5901714 Feb 26 18:23 PopC_013.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6355692 Feb 26 18:23 PopC_013.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    275604 Feb 26 21:39 PopC_013.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2435428 Feb 26 18:23 PopC_013.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    260638 Feb 26 21:39 PopC_014.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6036849 Feb 26 18:23 PopC_014.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6501222 Feb 26 18:23 PopC_014.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    279713 Feb 26 21:39 PopC_014.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2452986 Feb 26 18:23 PopC_014.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    256257 Feb 26 21:39 PopC_015.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5899725 Feb 26 18:23 PopC_015.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6353550 Feb 26 18:23 PopC_015.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    276006 Feb 26 21:39 PopC_015.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2413334 Feb 26 18:23 PopC_015.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    255461 Feb 26 21:39 PopC_016.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5873049 Feb 26 18:23 PopC_016.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6324822 Feb 26 18:23 PopC_016.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    274788 Feb 26 21:39 PopC_016.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2440519 Feb 26 18:23 PopC_016.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    260435 Feb 26 21:39 PopC_017.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6012045 Feb 26 18:23 PopC_017.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6474510 Feb 26 18:23 PopC_017.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    279107 Feb 26 21:39 PopC_017.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2500991 Feb 26 18:23 PopC_017.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    259353 Feb 26 21:39 PopC_018.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5985018 Feb 26 18:23 PopC_018.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6445404 Feb 26 18:23 PopC_018.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    277636 Feb 26 21:39 PopC_018.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2432643 Feb 26 18:23 PopC_018.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257272 Feb 26 21:39 PopC_019.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5908851 Feb 26 18:23 PopC_019.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6363378 Feb 26 18:23 PopC_019.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    275671 Feb 26 21:39 PopC_019.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2424017 Feb 26 18:23 PopC_019.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    259046 Feb 26 21:39 PopC_020.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5959044 Feb 26 18:23 PopC_020.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6417432 Feb 26 18:23 PopC_020.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    277497 Feb 26 21:39 PopC_020.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2457550 Feb 26 18:23 PopC_020.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257391 Feb 26 21:39 PopD_001.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5900544 Feb 26 18:23 PopD_001.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6354432 Feb 26 18:23 PopD_001.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    273269 Feb 26 21:39 PopD_001.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2450953 Feb 26 18:23 PopD_001.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    264015 Feb 26 21:39 PopD_002.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6111612 Feb 26 18:23 PopD_002.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6581736 Feb 26 18:23 PopD_002.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    279081 Feb 26 21:39 PopD_002.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2520840 Feb 26 18:23 PopD_002.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    263732 Feb 26 21:39 PopD_003.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6105528 Feb 26 18:23 PopD_003.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6575184 Feb 26 18:23 PopD_003.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    279945 Feb 26 21:39 PopD_003.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2520811 Feb 26 18:23 PopD_003.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    261170 Feb 26 21:39 PopD_004.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6024798 Feb 26 18:23 PopD_004.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6488244 Feb 26 18:23 PopD_004.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    275914 Feb 26 21:39 PopD_004.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2461611 Feb 26 18:23 PopD_004.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    256646 Feb 26 21:39 PopD_005.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5907915 Feb 26 18:23 PopD_005.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6362370 Feb 26 18:23 PopD_005.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    272443 Feb 26 21:39 PopD_005.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2396087 Feb 26 18:23 PopD_005.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    259065 Feb 26 21:39 PopD_006.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5978700 Feb 26 18:23 PopD_006.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6438600 Feb 26 18:23 PopD_006.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    274121 Feb 26 21:39 PopD_006.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2420965 Feb 26 18:23 PopD_006.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    259066 Feb 26 21:39 PopD_007.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5962905 Feb 26 18:23 PopD_007.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6421590 Feb 26 18:23 PopD_007.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    274892 Feb 26 21:39 PopD_007.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2504022 Feb 26 18:23 PopD_007.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    257284 Feb 26 21:39 PopD_008.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5907915 Feb 26 18:23 PopD_008.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6362370 Feb 26 18:23 PopD_008.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    273216 Feb 26 21:39 PopD_008.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2398871 Feb 26 18:23 PopD_008.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    261763 Feb 26 21:39 PopD_009.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6067971 Feb 26 18:23 PopD_009.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6534738 Feb 26 18:23 PopD_009.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    278783 Feb 26 21:39 PopD_009.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2501249 Feb 26 18:23 PopD_009.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    259047 Feb 26 21:39 PopD_010.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5970861 Feb 26 18:23 PopD_010.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6430158 Feb 26 18:23 PopD_010.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    274550 Feb 26 21:39 PopD_010.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2451443 Feb 26 18:23 PopD_010.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    259586 Feb 26 21:39 PopD_011.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5979285 Feb 26 18:23 PopD_011.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6439230 Feb 26 18:23 PopD_011.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    277432 Feb 26 21:39 PopD_011.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2429362 Feb 26 18:23 PopD_011.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    259039 Feb 26 21:39 PopD_012.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5979402 Feb 26 18:23 PopD_012.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6439356 Feb 26 18:23 PopD_012.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    278180 Feb 26 21:39 PopD_012.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2424777 Feb 26 18:23 PopD_012.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    261278 Feb 26 21:39 PopD_013.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6040242 Feb 26 18:23 PopD_013.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6504876 Feb 26 18:23 PopD_013.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    280309 Feb 26 21:39 PopD_013.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2489286 Feb 26 18:23 PopD_013.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    258363 Feb 26 21:39 PopD_014.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5967585 Feb 26 18:23 PopD_014.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6426630 Feb 26 18:23 PopD_014.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    277498 Feb 26 21:39 PopD_014.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2408779 Feb 26 18:23 PopD_014.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    258081 Feb 26 21:39 PopD_015.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5959629 Feb 26 18:23 PopD_015.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6418062 Feb 26 18:23 PopD_015.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    277757 Feb 26 21:39 PopD_015.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2433408 Feb 26 18:23 PopD_015.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    254755 Feb 26 21:39 PopD_016.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5836779 Feb 26 18:23 PopD_016.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6285762 Feb 26 18:23 PopD_016.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    272701 Feb 26 21:39 PopD_016.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2401667 Feb 26 18:23 PopD_016.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    258589 Feb 26 21:39 PopD_017.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5956821 Feb 26 18:23 PopD_017.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6415038 Feb 26 18:23 PopD_017.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    277561 Feb 26 21:39 PopD_017.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2456277 Feb 26 18:23 PopD_017.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    258127 Feb 26 21:39 PopD_018.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5951322 Feb 26 18:23 PopD_018.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6409116 Feb 26 18:23 PopD_018.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    276407 Feb 26 21:39 PopD_018.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2405214 Feb 26 18:23 PopD_018.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    265879 Feb 26 21:39 PopD_019.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   6175377 Feb 26 18:23 PopD_019.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6650406 Feb 26 18:23 PopD_019.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    284962 Feb 26 21:39 PopD_019.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2549005 Feb 26 18:23 PopD_019.uniq.seqs
    ## -rwxr-xr-x+ 1 mgomez mgomez    255280 Feb 26 21:39 PopD_020.F.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   5865327 Feb 26 18:23 PopD_020.forward
    ## -rw-r--r--+ 1 mgomez mgomez   6316506 Feb 26 18:23 PopD_020.reverse
    ## -rwxr-xr-x+ 1 mgomez mgomez    274401 Feb 26 21:39 PopD_020.R.fq.gz
    ## -rw-r--r--+ 1 mgomez mgomez   2397579 Feb 26 18:23 PopD_020.uniq.seqs
    ## -rw-r--r--+ 1 mgomez mgomez    337832 Feb 26 18:36 rainbow.fasta
    ## -rw-r--r--+ 1 mgomez mgomez    553550 Feb 26 18:36 rbasm.out
    ## -rw-r--r--+ 1 mgomez mgomez   2054896 Feb 26 18:36 rbdiv.out
    ## -rw-r--r--+ 1 mgomez mgomez   2013494 Feb 26 18:36 rcluster
    ## -rw-r--r--+ 1 mgomez mgomez    340302 Feb 26 18:36 reference.fasta
    ## -rw-r--r--+ 1 mgomez mgomez     40695 Feb 26 18:36 reference.fasta.amb
    ## -rw-r--r--+ 1 mgomez mgomez     50340 Feb 26 18:36 reference.fasta.ann
    ## -rw-r--r--+ 1 mgomez mgomez    314312 Feb 26 18:36 reference.fasta.bwt
    ## -rw-r--r--+ 1 mgomez mgomez     46654 Feb 26 18:36 reference.fasta.fai
    ## -rw-r--r--+ 1 mgomez mgomez    337832 Feb 26 18:36 reference.fasta.original
    ## -rw-r--r--+ 1 mgomez mgomez     58300 Feb 26 18:36 reference.fasta.original.clstr
    ## -rw-r--r--+ 1 mgomez mgomez     78561 Feb 26 18:36 reference.fasta.pac
    ## -rw-r--r--+ 1 mgomez mgomez    157168 Feb 26 18:36 reference.fasta.sa
    ## -rw-r--r--+ 1 mgomez mgomez     17002 Feb 26 18:23 ReferenceOpt.sh
    ## -rw-r--r--+ 1 mgomez mgomez    336839 Feb 26 18:23 referenceRC.fasta
    ## -rw-r--r--+ 1 mgomez mgomez     58303 Feb 26 18:23 referenceRC.fasta.clstr
    ## -rw-r--r--+ 1 mgomez mgomez     14906 Feb 26 18:23 remake_reference.sh
    ## -rw-r--r--+ 1 mgomez mgomez     72167 Feb 26 18:36 sort.contig.cluster.ids
    ## -rw-r--r--+ 1 mgomez mgomez    337832 Feb 26 18:36 totalover.fasta
    ## -rw-r--r--+ 1 mgomez mgomez   2013228 Feb 26 18:36 totaluniqseq
    ## -rw-r--r--+ 1 mgomez mgomez   7243474 Feb 26 18:36 totaluniqseqrm
    ## -rw-r--r--+ 1 mgomez mgomez   3230660 Feb 26 18:23 uniqCperindv
    ## -rw-r--r--+ 1 mgomez mgomez   2179890 Feb 26 18:36 uniq.fasta
    ## -rw-r--r--+ 1 mgomez mgomez   1101375 Feb 26 18:36 uniq.F.fasta
    ## -rw-r--r--+ 1 mgomez mgomez   2179890 Feb 26 18:36 uniq.full.fasta
    ## -rw-r--r--+ 1 mgomez mgomez   2034320 Feb 26 18:36 uniq.k.4.c.4.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1870744 Feb 26 18:24 uniq.k.4.c.5.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1724440 Feb 26 18:25 uniq.k.4.c.6.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1603790 Feb 26 18:25 uniq.k.4.c.7.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1491776 Feb 26 18:26 uniq.k.4.c.8.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   2022315 Feb 26 18:26 uniq.k.5.c.4.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1853659 Feb 26 18:27 uniq.k.5.c.5.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1707609 Feb 26 18:27 uniq.k.5.c.6.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1587721 Feb 26 18:28 uniq.k.5.c.7.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1474691 Feb 26 18:28 uniq.k.5.c.8.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   2007517 Feb 26 18:29 uniq.k.6.c.4.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1835559 Feb 26 18:30 uniq.k.6.c.5.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1688493 Feb 26 18:30 uniq.k.6.c.6.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1567335 Feb 26 18:31 uniq.k.6.c.7.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1457099 Feb 26 18:31 uniq.k.6.c.8.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1990680 Feb 26 18:32 uniq.k.7.c.4.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1814912 Feb 26 18:32 uniq.k.7.c.5.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1670386 Feb 26 18:33 uniq.k.7.c.6.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1548720 Feb 26 18:33 uniq.k.7.c.7.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1433150 Feb 26 18:34 uniq.k.7.c.8.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1971548 Feb 26 18:34 uniq.k.8.c.4.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1796288 Feb 26 18:35 uniq.k.8.c.5.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1651254 Feb 26 18:35 uniq.k.8.c.6.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1526794 Feb 26 18:36 uniq.k.8.c.7.seqs
    ## -rw-r--r--+ 1 mgomez mgomez   1414018 Feb 26 18:36 uniq.k.8.c.8.seqs
    ## -rw-r--r--+ 1 mgomez mgomez       175 Feb 26 18:23 uniqseq.data
    ## -rw-r--r--+ 1 mgomez mgomez        65 Feb 26 18:23 uniqseq.peri.data
    ## -rw-r--r--+ 1 mgomez mgomez 195413055 Feb 26 18:23 uniq.seqs
    ## -rw-r--r--+ 1 mgomez mgomez    169348 Feb 26 18:36 xxx
    ## -rw-r--r--+ 1 mgomez mgomez    363979 Feb 26 18:36 xxx.clstr

Following the Assembly tutorial in <http://ddocent.com/assembly/> First,
we are going to create a set of unique reads with counts for each
individual

    ls *.F.fq.gz > namelist
    sed -i'' -e 's/.F.fq.gz//g' namelist
    AWK1='BEGIN{P=1}{if(P==1||P==2){gsub(/^[@]/,">");print}; if(P==4)P=0; P++}'
    AWK2='!/>/'
    AWK3='!/NNN/'
    PERLT='while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}'

    cat namelist | parallel --no-notice -j 8 "zcat {}.F.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.forward"
    cat namelist | parallel --no-notice -j 8 "zcat {}.R.fq.gz | mawk '$AWK1' | mawk '$AWK2' > {}.reverse"
    cat namelist | parallel --no-notice -j 8 "paste -d '-' {}.forward {}.reverse | mawk '$AWK3' | sed 's/-/NNNNNNNNNN/' | perl -e '$PERLT' > {}.uniq.seqs"

Let’s sum up the number the within individual coverage level of unique
reads in our data set

    cat *.uniq.seqs > uniq.seqs
    for i in {2..20};
    do 
    echo $i >> pfile
    done
    cat pfile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniq.seqs | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.data
    rm pfile

Take a look at the contents of uniqseq.data

    less uniqseq.data

    ## 2    126508
    ## 3    122492
    ## 4    121026
    ## 5    119357
    ## 6    117552
    ## 7    115633
    ## 8    113606
    ## 9    111449
    ## 10   109143
    ## 11   106710
    ## 12   104198
    ## 13   101560
    ## 14   98723
    ## 15   95844
    ## 16   92812
    ## 17   89829
    ## 18   86728
    ## 19   83535
    ## 20   80401

Plot of number of Unique Sequences with More than X Coverage (Counted
within individuals)

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

    ## 
    ##                       Number of Unique Sequences with More than X Coverage (Counted within individuals)
    ## 
    ##   130000 ++----------+-----------+-----------+-----------+----------+-----------+-----------+-----------+----------++
    ##          +           +           +           +           +          +           +           +           +           +
    ##   125000 ******                                                                                                    ++
    ##          |     ******                                                                                               |
    ##          |           ******                                                                                         |
    ##   120000 ++                ******                                                                                  ++
    ##          |                       ******                                                                             |
    ##   115000 ++                            ******                                                                      ++
    ##          |                                   ******                                                                 |
    ##   110000 ++                                        ******                                                          ++
    ##          |                                               ******                                                     |
    ##   105000 ++                                                    *****                                               ++
    ##          |                                                          ******                                          |
    ##          |                                                                ******                                    |
    ##   100000 ++                                                                     *****                              ++
    ##          |                                                                           *                              |
    ##    95000 ++                                                                           ******                       ++
    ##          |                                                                                  ******                  |
    ##    90000 ++                                                                                       *****            ++
    ##          |                                                                                             *            |
    ##          |                                                                                              ******      |
    ##    85000 ++                                                                                                   *****++
    ##          +           +           +           +           +          +           +           +           +          *+
    ##    80000 ++----------+-----------+-----------+-----------+----------+-----------+-----------+-----------+----------+*
    ##          2           4           6           8           10         12          14          16          18          20
    ##                                                           Coverage

Now we need to choose a cutoff value. We want to choose a value that
captures as much of the diversity of the data as possible while
simultaneously eliminating sequences that are likely errors. Let’s try 4

    parallel --no-notice -j 8 mawk -v x=4 \''$1 >= x'\' ::: *.uniq.seqs | cut -f2 | perl -e 'while (<>) {chomp; $z{$_}++;} while(($k,$v) = each(%z)) {print "$v\t$k\n";}' > uniqCperindv
    wc -l uniqCperindv

    ## 12699 uniqCperindv

We’ve now reduced the data to assemble down to 12699 sequences! But, we
can go even further. Let’s now restrict data by the number of different
individuals a sequence appears within.

    for ((i = 2; i <= 10; i++));
    do
    echo $i >> ufile
    done

    cat ufile | parallel --no-notice "echo -n {}xxx && mawk -v x={} '\$1 >= x' uniqCperindv | wc -l" | mawk  '{gsub("xxx","\t",$0); print;}'| sort -g > uniqseq.peri.data
    rm ufile

Plot of Number of Unique Sequences present in more than X Individuals

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

    ## 
    ##                                 Number of Unique Sequences present in more than X Individuals
    ## 
    ##   11000 ++------------+------------+-------------+------------+-------------+------------+-------------+-----------++
    ##         +             +            +             +            +             +            +             +            +
    ##         |                                                                                                           |
    ##         *****                                                                                                       |
    ##   10000 ++   **                                                                                                    ++
    ##         |      ***                                                                                                  |
    ##         |         ***                                                                                               |
    ##         |            *                                                                                              |
    ##    9000 ++            *****                                                                                        ++
    ##         |                  ****                                                                                     |
    ##         |                      ***                                                                                  |
    ##    8000 ++                        *                                                                                ++
    ##         |                          ***********                                                                      |
    ##         |                                     ***                                                                   |
    ##         |                                        **********                                                         |
    ##    7000 ++                                                 ***                                                     ++
    ##         |                                                     ***********                                           |
    ##         |                                                                ***                                        |
    ##         |                                                                   **********                              |
    ##    6000 ++                                                                            ***                          ++
    ##         |                                                                                **************             |
    ##         |                                                                                              **********   |
    ##         +             +            +             +            +             +            +             +         ***+
    ##    5000 ++------------+------------+-------------+------------+-------------+------------+-------------+-----------+*
    ##         2             3            4             5            6             7            8             9            10
    ##                                                     Number of Individuals

Again, we need to choose a cutoff value. We want to choose a value that
captures as much of the diversity of the data as possible while
simultaneously eliminating sequences that have little value on the
population scale. Let’s try 4.

    mawk -v x=4 '$1 >= x' uniqCperindv > uniq.k.4.c.4.seqs
    wc -l uniq.k.4.c.4.seqs

    ## 7989 uniq.k.4.c.4.seqs

Now we have reduced the data down to only 7989 sequences!

Let’s quickly convert these sequences back into fasta format We can do
this with two quick lines of code:

    cut -f2 uniq.k.4.c.4.seqs > totaluniqseq
    mawk '{c= c + 1; print ">Contig_" c "\n" $1}' totaluniqseq > uniq.fasta

With this, we have created our reduced data set and are ready to start
assembling reference contigs.

First, let’s extract the forward reads.

    sed -e 's/NNNNNNNNNN/\t/g' uniq.fasta | cut -f1 > uniq.F.fasta

For example, first step of rainbow clusters reads together using a
spaced hash to estimate similarity in the forward reads only. dDocent
now improves this by using clustering by alignment via the program
CD-hit to achieve more accurate clustering. Custom AWK code then
converts the output of CD-hit to match the input of the 2nd phase of
rainbow.

    cd-hit-est -i uniq.F.fasta -o xxx -c 0.8 -T 0 -M 0 -g 1

    ## ================================================================
    ## Program: CD-HIT, V4.6 (+OpenMP), Jan 11 2018, 15:28:37
    ## Command: cd-hit-est -i uniq.F.fasta -o xxx -c 0.8 -T 0 -M 0 -g
    ##          1
    ## 
    ## Started: Tue Feb 26 21:39:40 2019
    ## ================================================================
    ##                             Output                              
    ## ----------------------------------------------------------------
    ## total number of CPUs in the system is 80
    ## Actual number of CPUs to be used: 80
    ## 
    ## total seq: 7989
    ## longest and shortest : 116 and 116
    ## Total letters: 926724
    ## Sequences have been sorted
    ## 
    ## Approximated minimal memory consumption:
    ## Sequence        : 1M
    ## Buffer          : 80 X 12M = 972M
    ## Table           : 2 X 16M = 33M
    ## Miscellaneous   : 4M
    ## Total           : 1012M
    ## 
    ## Table limit with the given memory limit:
    ## Max number of representatives: 248606
    ## Max number of word counting entries: 6715988
    ## 
    ## 
    # comparing sequences from          0  to       7238
    ## .......---------- new table with     1234 representatives
    ## 
    # comparing sequences from       7238  to       7989
    ## ....................---------- new table with        0 representatives
    ## 
    ##      7989  finished       1234  clusters
    ## 
    ## Apprixmated maximum memory consumption: 1014M
    ## writing new database
    ## writing clustering information
    ## program completed !
    ## 
    ## Total CPU time 4.94

This code clusters all off the forward reads by 80% similarity. This
might seem low, but other functions of rainbow will break up clusters
given the number and frequency of variants, so it’s best to use a low
value at this step. This code then converts the output of CD-hit to
match the output of the first phase of rainbow.

    mawk '{if ($1 ~ /Cl/) clus = clus + 1; else  print $3 "\t" clus}' xxx.clstr | sed 's/[>Contig_,...]//g' | sort -g -k1 > sort.contig.cluster.ids
    paste sort.contig.cluster.ids totaluniqseq > contig.cluster.totaluniqseq
    sort -k2,2 -g contig.cluster.totaluniqseq | sed -e 's/NNNNNNNNNN/\t/g' > rcluster

Use the more, head, and/or tail function to examine the output file
(rcluster). It’s important to note that the numbers are not totally
sequential and that there may not be 1000 clusters. Try the command
below to get the exact number.

    cut -f2 rcluster | uniq | wc -l 

    ## 1234

The next step of rainbow is to split clusters formed in the first step
into smaller clusters representing significant variants. Think of it in
this way. The first clustering steps found RAD loci, and this step is
splitting the loci into alleles. This also helps to break up over
clustered sequences.

    rainbow div -i rcluster -o rbdiv.out 

The output of the div process is similar to the previous output with the
exception that the second column is now the new divided cluster\_ID
(this value is numbered sequentially) and there was a column added to
the end of the file that holds the original first cluster ID The
parameter -f can be set to control what is the minimum frequency of an
allele necessary to divide it into its own cluster Since this is from
multiple individuals, we want to lower this from the default of 0.2.

    rainbow div -i rcluster -o rbdiv.out -f 0.5 -K 10

The third part of the rainbow process is to used the paired end reads to
merge divided clusters. This helps to double check the clustering and
dividing of the previous steps all of which were based on the forward
read. The logic is that if divided clusters represent alleles from the
same homolgous locus, they should have fairly similar paired end reads
as well as forward. Divided clusters that do not share similarity in the
paired-end read represent cluster paralogs or repetitive regions. After
the divided clusters are merged, all the forward and reverse reads are
pooled and assembled for that cluster.

    rainbow merge -o rbasm.out -a -i rbdiv.out

A parameter of interest to add here is the -r parameter, which is the
minimum number of reads to assemble. The default is 5 which works well
if assembling reads from a single individual. However, we are assembling
a reduced data set, so there may only be one copy of a locus. Therefore,
it’s more appropriate to use a cutoff of 2.

    rainbow merge -o rbasm.out -a -i rbdiv.out -r 2

The rbasm output lists optimal and suboptimal contigs. Previous versions
of dDocent used rainbow’s included perl scripts to retrieve optimal
contigs. However, as of version 2.0, dDocent uses customized AWK code to
extract optimal contigs for RAD sequencing.

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

Though rainbow is fairly accurate with assembly of RAD data, even with
high levels of INDEL polymorphism. It’s not perfect and the resulting
contigs need to be aligned and clustered by sequence similarity. We can
use the program cd-hit to do this.

The -M and -T flags instruct the program on memory usage (-M) and number
of threads (-T). Setting the value to 0 uses all available. The real
parameter of significan is the -c parameter which sets the percentage of
sequence similarity to group contigs by. The above code uses 90%. Try
using 95%, 85%, 80%, and 99%. Since this is simulated data, we know the
real number of contigs, 1000. By choosing an cutoffs of 4 and 4, we are
able to get the real number of contigs, no matter what the similarty
cutoff.

    cd-hit-est -i rainbow.fasta -o referenceRC.fasta -M 0 -T 0 -c 0.9

    ## ================================================================
    ## Program: CD-HIT, V4.6 (+OpenMP), Jan 11 2018, 15:28:37
    ## Command: cd-hit-est -i rainbow.fasta -o referenceRC.fasta -M 0
    ##          -T 0 -c 0.9
    ## 
    ## Started: Tue Feb 26 21:39:42 2019
    ## ================================================================
    ##                             Output                              
    ## ----------------------------------------------------------------
    ## total number of CPUs in the system is 80
    ## Actual number of CPUs to be used: 80
    ## 
    ## total seq: 1235
    ## longest and shortest : 370 and 230
    ## Total letters: 310771
    ## Sequences have been sorted
    ## 
    ## Approximated minimal memory consumption:
    ## Sequence        : 0M
    ## Buffer          : 80 X 12M = 970M
    ## Table           : 2 X 16M = 33M
    ## Miscellaneous   : 4M
    ## Total           : 1009M
    ## 
    ## Table limit with the given memory limit:
    ## Max number of representatives: 248606
    ## Max number of word counting entries: 10919121
    ## 
    ## 
    # comparing sequences from          0  to         15
    ## ---------- new table with       15 representatives
    ## 
    # comparing sequences from         15  to         29
    ## ..............---------- new table with       14 representatives
    ## 
    # comparing sequences from         29  to         43
    ## ..............---------- new table with       14 representatives
    ## 
    # comparing sequences from         43  to         57
    ## ..............---------- new table with       14 representatives
    ## 
    # comparing sequences from         57  to         71
    ## ..............---------- new table with       14 representatives
    ## 
    # comparing sequences from         71  to         85
    ## ..............---------- new table with       14 representatives
    ## 
    # comparing sequences from         85  to         99
    ## ..............---------- new table with       14 representatives
    ## 
    # comparing sequences from         99  to        112
    ## .............---------- new table with       13 representatives
    ## 
    # comparing sequences from        112  to        125
    ## .............---------- new table with       13 representatives
    ## 
    # comparing sequences from        125  to        138
    ## .............---------- new table with       13 representatives
    ## 
    # comparing sequences from        138  to        151
    ## .............---------- new table with       13 representatives
    ## 
    # comparing sequences from        151  to        164
    ## .............---------- new table with       13 representatives
    ## 
    # comparing sequences from        164  to        177
    ## .............---------- new table with       13 representatives
    ## 
    # comparing sequences from        177  to        189
    ## ............---------- new table with       12 representatives
    ## 
    # comparing sequences from        189  to        201
    ## ............---------- new table with       12 representatives
    ## 
    # comparing sequences from        201  to        213
    ## ............---------- new table with       12 representatives
    ## 
    # comparing sequences from        213  to        225
    ## ............---------- new table with       12 representatives
    ## 
    # comparing sequences from        225  to        237
    ## ............---------- new table with       12 representatives
    ## 
    # comparing sequences from        237  to       1235
    ## .....................---------- new table with      998 representatives
    ## 
    ##      1235  finished       1235  clusters
    ## 
    ## Apprixmated maximum memory consumption: 1010M
    ## writing new database
    ## writing clustering information
    ## program completed !
    ## 
    ## Total CPU time 11.82

This simple bash script called remake\_reference.sh that will automate
the process of remaking the reference with a cutoff of 20 copies of a
unique sequence to use for assembly and a final clustering value of 90%.
It will output the number of reference sequences and create a new,
indexed reference with the given parameters.

    curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/remake_reference.sh

    ##   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
    ##                                  Dload  Upload   Total   Spent    Left  Speed
    ## 
      0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
    100   150  100   150    0     0    541      0 --:--:-- --:--:-- --:--:--   541
    ## 
    100 14906  100 14906    0     0  40103      0 --:--:-- --:--:-- --:--:-- 40103

You can remake a reference by calling the script along with a new cutoff
value and similarity.

    bash remake_reference.sh 4 4 0.90 PE 2

    ## 1235

What you choose for a final number of contigs will be something of a
judgement call. However, we could try to heuristically search the
parameter space to find an optimal value. Download the script to
automate this process

Take a look at the script ReferenceOpt.sh. This script uses different
loops to assemble references from an interval of cutoff values and c
values from 0.8-0.98.

    curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/ReferenceOpt.sh
    bash ReferenceOpt.sh 4 8 4 8 PE 16

Let’s examine the reference a bit.

    bash remake_reference.sh 4 4 0.90 PE 2
    head reference.fasta

    ## 1235
    ## >dDocent_Contig_1
    ## NAATTCATGGGATTCCCTGAGAGCACGAACGTCATTTACATCTAATACTCATTGGCACGTCATGCATTGGCAAAGACGAGTAGTTAGTGATAACGCCTAATCACCACGTCAACTGAANNNNNNNNNNGTGGGGTAGCGGGATAGTAAGCCCCCTGGATTGTCCTATTGACTGCGAAGACAAATAGCAGAGGTTCATACGCTCGGTCCTTTGCGCAGAGGACGGACGATTCGGACGCTATCCTAATTTTGCCGN
    ## >dDocent_Contig_2
    ## NAATTCGTTTGCCCACGGCTTCCACTAAAAGTTGCCCGCAGAACGGATCACTCCAGTATATGCTGCAGTTTGGATGTGAGAGCGGATAGTTTTGCTAATCATCCACGGGCCGTTAGTNNNNNNNNNNCGTAAGGCATCGGATTTACACGGTATACGTCCGATGCATTGCTTGTACCCACGTCCGAATTCATCGACGTGCGCACTCCTGATTATAACTTAACAATAGTCATAACGCCGGGCTCCCTGGTTCCGN
    ## >dDocent_Contig_3
    ## NAATTCACGGCTATCAACTAGGATGGTGGTTACTATTAGTGAGTGCTGTGTATTTCCGCTGCCGTCACTTGCAAGGCAGTAAACCCTTGGTGGCACGTGTAATCCAGCGTATGCAATNNNNNNNNNNCCTGGCCATAGTATTGCTCTAGCATAAAACAAGAGTTATGTATCTTGCCTTCCGGCTAGTCACCTATAGTGATTTGAGCTATTGAAAAGTCACGTTGACTGGAGGTAGAGAGTGGAATACTTCCGN
    ## >dDocent_Contig_4
    ## NAATTCAGCAACTCAAGTAATTCTGTGACTGCCACACCTTTCACCTGTAAGGCACTCGCGTACATCATTAGATCTTATTTGAAAGACCTGGCGTCGCCAATGTTGTCCGCAATAATCNNNNNNNNNNTGCGTACTCACGTTGTTATATAATGCAGCCGTCACACAATTTCGTGGATCGGCTACGGTGCGGGACTGAGACATACGTACGGTCAATAGGAGTAATAATCGCTTCATCATGATACTGGCTGTCCGN
    ## >dDocent_Contig_5
    ## NAATTCTCTGGCATTAATACCTTTATTTCTTTCCCGGAATTTGGTCCATACGCCAAAACCACATTAACTTTACACAGACCATGTCCTCGACGGTCGAATTTAGACAAATTTCTAGTGNNNNNNNNNNCCGTTATTGAACCGAACTATCCTGTTTGATTCGGGGCCTTGGATTTTGACTGGCGTAAGTGCACCGAATTTATAGTATACAATTTTTCACGGGGTAGACGAGTGCGATATCGATCGAGTGAACCGN

We can use simple shell commands to query this data. Find out how many
lines in the file (this is double the number of sequences)

    wc -l reference.fasta

    ## 2470 reference.fasta

Find out how many sequences there are directly by counting lines that
only start with the header character “&gt;”

    mawk '/>/' reference.fasta | wc -l 

    ## 1235

We can test that all sequences follow the expected format.

    mawk '/^NAATT.*N*.*CCGN$/' reference.fasta | wc -l
    grep '^NAATT.*N*.*CCGN$' reference.fasta | wc -l

    ## 1235
    ## 1235

So there are 1235 loci
