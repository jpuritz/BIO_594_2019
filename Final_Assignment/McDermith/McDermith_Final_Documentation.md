# A Genome Analysis of *Salegentibacter* sp.
This analysis will cover the following:
1. Data assessment using FastQC
2. Trimmomatic
3. *De Novo* assembly using Velvet
4. Ordering contigs using Abcas
5. Genome annotation using Prokka
<br> <br>

Bash scripts were used for many of the analyses and can be found in the Scripts folder.
### 1. FastQc
FastQc was used to asses the initial quality of the genome sequence.
The raw data files for this data set are BJ1_S5_L001_R1_001.fastq.gz BJ1_S5_L001_R2_001.fastq.gz.

> module load FastQC/0.11.5-Java-1.8.0_92
cd /data3/jenkinslab/emcdermith/McDermithFinalAssignment/RawData/
<br> fastqc BJ1_S5_L001_R1_001.fastq.gz BJ1_S5_L001_R2_001.fastq.gz

The HTML for the FastQc of the raw reads can be viewed in the Figures folder.

### 2. Trimmomatic
 Trimmomatic was used to trim low quality reads and adaptor sequences.

  Trimmomatic was run using a bash script called Trimmomatic.sh which can be found in the Scripts folder.
	The adaptors were removed using the appropriate adaptor files. In this case, NexteraPE-PE.fa was used. <br> SLIDINGWINDOW:4:15 means that if between a window of 4 bases there is a quality score below 15 the sequence will be cut. The slidingwindow begins at the 5' end. <br>
	LEADING:3 removes any bases with a quality score below 3 at the start of the read.
	TRAILING:3 removes any bases with a quality score below 3 at the end of the read.
	MINLEN:36 removes read if it is less than 36 bp in length.

Output files were renamed trimmed_R1_paired.fq.gz  trimmed_R1_unpaired.fq.gz  trimmed_R2_paired.fq.gz  trimmed_R2_unpaired.fq.gz

Trimmed reads were assessed for quality using FastQc

>	module load FastQC/0.11.5-Java-1.8.0_92
	cd /data3/jenkinslab/emcdermith/McDermithFinalAssignment/Trimmomatic/
	fastqc trimmed_R1_paired.fq.gz trimmed_R2_paired.fq.gz

The HTML for the FastQc of the trimmed reads can be found in the Figures folder.

### 3. Velvet
Before running Velvet trimmed files must be interleaved. I used the shuffleSequences_fastq.pl script which can be found within the Velvet package or in my Scripts folder.
>perl shuffleSequences_fastq.pl ../Trimmomatic/trimmed_R1_paired.fq.gz ../Trimmomatic/trimmed_R2_paired.fq.gz new_interleaved_R1R2_fq.gz

This created an interleaved file called new_interleaved_R1R2_fq.gz which can now be used in the assembly.

I had trouble with velvet assembling zipped files. Velvet was not able to read the entire zipped file. To solve this I unzipped the files and interleaved the unzipped files.

> gzip -d *_paired.fq.gz <br>
perl shuffleSequences_fastq.pl ../Trimmomatic/trimmed_R1_paired.fq ../Trimmomatic/trimmed_R2_paired.fq new_interleaved_R1R2_fq

This produced an interleaved unzipped file called new_interleaved_R1R2_fq that was used in the assembly.

To assemble with velvet you first run velveth and then veletg.

Running velveth:
> module load velvet/1.2.10 <br>
velveth auto 45,51,2 -shortPaired -fastq -interleaved new_interleaved_R1R2_fq

This runs hash lengths between 45 and 51 in increments of 2. <br>
Each analysis created it's own directory with 3 output files prodcued by velveth. For example, in this analysis directories auto_45  auto_47  auto_49 were created. Within each directory are Log,  Roadmaps and  Sequences files.

I tried using a script avaliable through Velvet to estimate the expected k-mer coverage to use in the velvetg step. I used velvet-estimate-exp_cov.pl script which can be found in my Scripts folder.
> perl velvet-estimate-exp_cov.pl /data3/jenkinslab/emcdermith/McDermithFinalAssignment/VelvetOptimiser/auto_49/stats.txt <br>

Below is the output: <br>
     1 |  28259 | ************************************************************ <br>
     2 |    188 |                                                             
     3 |     11 |                                                             
     4 |      1 |                                                             
     5 |      1 |                                                             
     6 |      2 |                                                             
    10 |      1 |                                                             
    31 |      1 |                                                             
    62 |      1 |                                                             
    90 |      1 |                                                             
    96 |      1 |                                                             
   105 |      1 |                                                             
   106 |      1 |                                                             
   117 |      1 |                                                             
   124 |      1 |                                                             
   126 |      1 |                                                             
   128 |      1 |                                                             
   136 |      1 |                                                             
   142 |      1 |                                                             
   144 |      1 |                                                             
   146 |      1 |                                                             
   155 |      1 |                                                             
   162 |      1 |                                                             
   163 |      1 |                                                             
   167 |      2 |                                                             
   168 |      1 |                                                             
   169 |      2 |                                                             
   170 |      2 |                                                             
   171 |      2 |                                                             
   173 |      2 |                                                             
   174 |      2 |                                                             
   175 |      2 |                                                             
   176 |      2 |                                                             
   177 |      4 |                                                             
   178 |      3 |                                                             
   179 |      3 |                                                             
   180 |      6 |                                                             
   182 |      4 |                                                             
   183 |      4 |                                                             
   184 |      4 |                                                             
   185 |      6 |                                                             
   186 |      6 |                                                             
   187 |      6 |                                                             
   188 |      8 |                                                             
   189 |      8 |                                                             
   190 |     14 |                                                             
   191 |      9 |                                                             
   192 |     10 |                                                             
   193 |      9 |                                                             
   194 |     13 |                                                             
   195 |     16 |                                                             
   196 |     22 |                                                             
   197 |     17 |                                                             
   198 |     21 |                                                             
   199 |     21 |                                                             
   200 |     15 |                                                             
   201 |     18 |                                                             
   202 |     33 |                                                             
   203 |     26 |                                                             
   204 |     31 |                                                             
   205 |     23 |                                                             
   206 |     30 |                                                             
   207 |     47 |                                                             
   208 |     39 |                                                             
   209 |     40 |                                                             
   210 |     48 |                                                             
   211 |     55 |                                                             
   212 |     53 |                                                             
   213 |     48 |                                                             
   214 |     75 |                                                             
   215 |     50 |                                                             
   216 |     58 |                                                             
   217 |     63 |                                                             
   218 |     55 |                                                             
   219 |     61 |                                                             
   220 |     92 |                                                             
   221 |     75 |                                                             
   222 |     83 |                                                             
   223 |     73 |                                                             
   224 |     77 |                                                             
   225 |     98 |                                                             
   226 |     63 |                                                             
   227 |     84 |                                                             
   228 |    118 |                                                             
   229 |     87 |                                                             
   230 |    100 |                                                             
   231 |     88 |                                                             
   232 |     83 |                                                             
   233 |    114 |                                                             
   234 |    111 |                                                             
   235 |    107 |                                                             
   236 |     89 |                                                             
   237 |    112 |                                                             
   238 |    107 |                                                             
   239 |     95 |                                                             
   240 |    134 |                                                             
   241 |    125 |                                                             
   242 |    122 |                                                             
   243 |    134 |                                                             
   244 |    133 |                                                             
   245 |    134 |                                                             
   246 |    139 |                                                             
   247 |    122 |                                                             
   248 |    121 |                                                             
   249 |    123 |                                                             
   250 |    102 |                                                             
   251 |    108 |                                                             
   252 |    135 |                                                             
   253 |    118 |                                                             
   254 |    132 |                                                             
   255 |    115 |                                                             
   256 |    121 |                                                             
   257 |    129 |                                                             
   258 |    127 |                                                             
   259 |    123 |                                                             
   260 |    128 |                                                             
   261 |    141 |                                                             
   262 |    133 |                                                             
   263 |    134 |                                                             
   264 |    125 |                                                             
   265 |    106 |                                                             
   266 |    113 |                                                             
   267 |    119 |                                                             
   268 |    114 |                                                             
   269 |    117 |                                                             
   270 |    128 |                                                             
   271 |    132 |                                                             
   272 |    134 |                                                             
   273 |    119 |                                                             
   274 |    124 |                                                             
   275 |    102 |                                                             
   276 |    119 |                                                             
   277 |    116 |                                                             
   278 |    100 |                                                             
   279 |    108 |                                                             
   280 |    100 |                                                             
   281 |     95 |                                                             
   282 |     99 |                                                             
   283 |    109 |                                                             
   284 |     87 |                                                             
   285 |     82 |                                                             
   286 |     91 |                                                             
   287 |     85 |                                                             
   288 |     94 |                                                             
   289 |     90 |                                                             
   290 |     83 |                                                             
   291 |     95 |                                                             
   292 |     88 |                                                             
   293 |     78 |                                                             
   294 |     69 |                                                             
   295 |     71 |                                                             
   296 |     55 |                                                             
   297 |     83 |                                                             
   298 |     83 |                                                             
   299 |     82 |                                                             
   300 |     67 |                                                             
   301 |     65 |                                                             
   302 |     61 |                                                             
   303 |     68 |                                                             
   304 |     71 |                                                             
   305 |     74 |                                                             
   306 |     75 |                                                             
   307 |     64 |                                                             
   308 |     59 |                                                             
   309 |     58 |                                                             
   310 |     58 |                                                             
   311 |     57 |                                                             
   312 |     64 |                                                             
   313 |     54 |                                                             
   314 |     43 |                                                             
   315 |     60 |                                                             
   316 |     53 |                                                             
   317 |     40 |                                                             
   318 |     48 |                                                             
   319 |     47 |                                                             
   320 |     42 |                                                             
   321 |     49 |                                                             
   322 |     45 |                                                             
   323 |     34 |                                                             
   324 |     37 |                                                             
   325 |     36 |                                                             
   326 |     29 |                                                             
   327 |     42 |                                                             
   328 |     27 |                                                             
   329 |     41 |                                                             
   330 |     15 |                                                             
   331 |     34 |                                                             
   332 |     26 |                                                             
   333 |     20 |                                                             
   334 |     15 |                                                             
   335 |     16 |                                                             
   336 |     21 |                                                             
   337 |     25 |                                                             
   338 |     21 |                                                             
   339 |     16 |                                                             
   340 |     16 |                                                             
   341 |     18 |                                                             
   342 |     21 |                                                             
   343 |     13 |                                                             
   344 |     12 |                                                             
   345 |     18 |                                                             
   346 |     17 |                                                             
   347 |     12 |                                                             
   348 |     13 |                                                             
   349 |     11 |                                                             
   350 |     11 |                                                             
   351 |     18 |                                                             
   352 |     12 |                                                             
   353 |     13 |                                                             
   354 |      8 |                                                             
   355 |      8 |                                                             
   356 |      8 |                                                             
   357 |      5 |                                                             
   358 |     10 |                                                             
   359 |      8 |                                                             
   360 |      8 |                                                             
   361 |      5 |                                                             
   362 |      3 |                                                             
   363 |      8 |                                                             
   364 |      5 |                                                             
   365 |      8 |                                                             
   366 |      4 |                                                             
   367 |      4 |                                                             
   368 |      5 |                                                             
   369 |      2 |                                                             
   370 |      2 |                                                             
   371 |      3 |                                                             
   372 |      7 |                                                             
   373 |      2 |                                                             
   374 |      1 |                                                             
   375 |      2 |                                                             
   376 |      4 |                                                             
   377 |      3 |                                                             
   379 |      5 |                                                             
   380 |      2 |                                                             
   381 |      2 |                                                             
   382 |      2 |                                                             
   384 |      1 |                                                             
   385 |      1 |                                                             
   386 |      1 |                                                             
   387 |      3 |                                                             
   389 |      3 |                                                             
   390 |      1 |                                                             
   393 |      1 |                                                             
   394 |      1 |                                                             
   397 |      3 |                                                             
   399 |      2 |                                                             
   402 |      1 |                                                             
   403 |      1 |                                                             
   407 |      1 |                                                             
   410 |      1 |                                                             
   433 |      1 |                                                             
   451 |      1 |                                                             
   538 |      1 |                                                             
Predicted expected coverage: 1
velvetg parameters: -exp_cov 1 -cov_cutoff 0 <br>

Next, velvetg was run. <br>
Running velvetg:
Instead of using the expected coverage I calculated I decided on using -exp_cov auto. By using this velvetg will automatically estimate the expected kmer coverage (note this is different from the actual read coverage), the insert sizes of the individual paired-end and mate-pair runs and the coverage cut off, a parameter that is used to filter low coverage contigs from your assembly.


> velvetg auto_45 -exp_cov auto <br>
	For auto_45 Final graph has 391722 nodes and n50 of 45, max 872, total 10690707, using 4058652/5006058 reads

> velvetg auto_47 -exp_cov auto <br>
For auto_47 Final graph has 375127 nodes and n50 of 47, max 870, total 10744285, using 3972675/5006058 reads

> velvetg auto_49 -exp_cov auto <br>
For auto _49 Final graph has 361337 nodes and n50 of 49, max 868, total 10828749, using 3919900/5006058 reads

Velvetg outputs the following files: <br>
contigs.fa,  Graph2,  LastGraph,  Log,  PreGraph,  Roadmaps,  Sequences and  stats.txt <br>
Since the N50 was getting better with higher hash length I ran the assembly using hash lengths of 51 and 53.
> velveth auto 51,55,2 -shortPaired -fastq -interleaved new_interleaved_R1R2_fq <br>
velvetg auto_51 -exp_cov auto <br>
Final graph has 353142 nodes and n50 of 51, max 814, total 11071237, using 3799730/5006058 reads

> velvetg auto_53 -exp_cov auto <br>
Final graph has 345503 nodes and n50 of 53, max 812, total 11432921, using 3632011/5006058 reads

### 4. Contigs were ordered using Abacas
Contigs from the auto_49 assembly were used for the rest of the analysis. These contigs were ordered against a reference genome downloaded from NCBI. A genome of Salegentibacter salinarum was downloaded from NCBI. The file can be found here: <https://https://www.ncbi.nlm.nih.gov/nuccore/NZ_LT670848.1?report=fasta>
> module load ABACAS/1.3.2 <br>
module load  MUMmer/3.23 <br>
abacas.1.3.2.pl -r SalegentibactersalegensstrainACAM48.fasta -q contigs.fa -p 'nucmer' -m -b -o orderedcontigs.fa

-m produces a list of ordered and orientated contigs in a multi-fasta format. <br>
-b produces a multi-fasta file of all unmapped contigs. <br>
Running Abcas produced the following files: <br>
 orderedcontigs.fa.bin orderedcontigs.fa.contigsInbin.fas orderedcontigs.fa.crunch      orderedcontigs.fa.MULTIFASTA.fa orderedcontigs.fa.fasta       orderedcontigs.fa.tab orderedcontigs.fa.gaps        SalegentibactersalegensstrainACAM48.fasta orderedcontigs.fa.gaps.stats orderedcontigs.fa.gaps.tab unused_contigs.out

### 5. Annotation using Prokka
> prokka --listdb <br>
[13:01:12] Looking for databases in: /Users/emilymcdermith/prokka/db <br>
[13:01:12] * Kingdoms: Archaea Bacteria Bacteria Bacteria Mitochondria Viruses <br>
[13:01:12] * Genera: Enterococcus Escherichia Staphylococcus <br>
[13:01:12] * HMMs: HAMAP <br>
[13:01:12] * CMs: Bacteria Viruses <br>

Shown above are the databases that were used for the annotation.

> prokka contigs.fa --outdir prokka_annotation

In the new directory, prokka_annotation the following files were made: <br>
PROKKA_05092019.err	PROKKA_05092019.fsa	PROKKA_05092019.sqn
PROKKA_05092019.faa	PROKKA_05092019.gbk	PROKKA_05092019.tbl
PROKKA_05092019.ffn	PROKKA_05092019.gff	PROKKA_05092019.tsv
PROKKA_05092019.fna	PROKKA_05092019.log	PROKKA_05092019.txt

Below is a description of what each file contains. <br>
.faa = Protein FASTA file of the translated CDS sequences. <br>
.ffn = Nucleotide FASTA file of all the prediction transcripts (CDS, rRNA, tRNA, tmRNA, misc_RNA) <br>
.fna = Nucleotide FASTA file of the input contig sequences. <br>
.gbk = This is a standard Genbank file derived from the master .gff. If the input to prokka was a multi-FASTA, then this will be a multi-Genbank, with one record for each sequence. <br>
.gff = This is the master annotation in GFF3 format, containing both sequences and annotations. It can be viewed directly in Artemis or IGV. <br>
.log = Contains all the output that Prokka produced during its run. This is a record of what settings you used, even if the --quiet option was enabled. <br>
.tbl = Feature Table file, used by "tbl2asn" to create the .sqn file. <br>
.tsv = Tab-separated file of all features: locus_tag,ftype,len_bp,gene,EC_number,COG,product. <br>
.txt = Statistics relating to the annotated features found. <br>


Below is a view of the some of the proteins that were identified in the PROKKA_05092019.faa file.
MSNEDEIRFSYFLRPTYDFRMEILSYADQIKVVEPESLKSELKKELKRCIGNYE <br>
>MEFHBKPL_00241 Rubredoxin <br>
MKRYECIVCGWIYDEALGCPEEGIAPGTKWEDIPDDWTCPECGVGKLDFEMLEL <br>
>MEFHBKPL_00242 hypothetical protein <br>
MAGWRPVLLLSANKVTYVIDLIKEKSSQYTSVNLTMKIAVIC <br>
>MEFHBKPL_00243 Phospho-N-acetylmuramoyl-pentapeptide-transferase <br>
MGSYKLRGQRIFRMAPIHHHYELKGWPEPRVIVRFWIITIILVLIGLATLKVR <br>
>MEFHBKPL_00244 Septum site-determining protein MinC <br>
MLGNISAGAEVIADGSIHIYGALRGRAIAGAKGDESAQIFCNKLDPELLSINGTYILSDA
VQSQFINTQAHINCINNKLEITKFD <br>
>MEFHBKPL_00245 3-hydroxy-3-isohexenylglutaryl-CoA/hydroxy-methylglutaryl-CoA l$
MAGLGGCPYAKGATGNVATEDVVYMLHGMGISTGIDLDKLVVAGERNSEFLKRPNGSNVA
RAIINKRQS <br>
>MEFHBKPL_00246 Elongation factor P--(R)-beta-lysine ligase <br>
MYFKGIELANGFHELADAQEQLRRFKADNDKRKTMDLPAQPIDYHLIDALTAGFPDCAGV
ALGIDRLVMLATNANSLDEVIAFPTPRA <br>
>MEFHBKPL_00247 hypothetical protein <br>
