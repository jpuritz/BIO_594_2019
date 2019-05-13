# __*D. antillarum* transcriptome analysis__
#### Author: Cassie Raker
#### Last updated: May 10, 2019

#### Data uploaded and analyzed on KITT

###### accessing KITT account
###### original data files located in /RAID_STORAGE2/Shared_Data/Prada_Data/
```
ssh -p -Y XXXX craker@kitt.uri.edu
```
###### Prepare a working directory with data
Make a directory
```
mkdir diadema
cd diadema
```
Create a conda environment
```
conda create -n diadema
conda activate diadema
```
Create symbolic links to data
```
ln /home/Shared_Data/Prada_Data/*.fastq.gz .
```

##### Quality Analysis using FastQC
FastQC is used to identify any problems with reads, such as low quality or contamination from TruSeq adapters.
```
conda install fastqc
mkdir fastqc_results
cd fastqc_results
fastqc /home/craker/diadema/*.fastq.gz
```
Generate a multiqc report
```
conda install multiqc
multiqc .
scp -P XXXX craker@kitt.uri.edu:/home/craker/diadema/fastqc_results/multiqc_report.html /Users/cassieraker/Desktop/Urchin2/fastqc
```
Mean Quality Scores from MultiQC report
![mean quality scores](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Raker_final_assignment/Images/fastqc_meanqualityscores.png)

###### Summarize results
```
cat */summary.txt > /home/craker/diadema/fastqc_results/fastqc_summaries.txt
grep FAIL fastqc_summaries.txt | wc -l
```
47 FastQC tests failed

##### Quality control using fastp
fastp is used to trim low quality reads, remaining adapter sequences, etc.
```
conda install fastp
```
Run fastp on one file
```
fastp --in1 DA-HI-A_S79_L007_R1_001.fastq.gz \
--out1 DA-HI-A_S79_L007_R1_001.fastq.gz.clean \
--cut_front 20 --cut_tail 20 --cut_window_size 5 \
--cut_mean_quality 15 -q 15 -w 16 \
--adapter_sequence=AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
--adapter_sequence_r2=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
```
Loop fastp to run on all files
```
for filename in *.fastq.gz
> do
> fastp --in1 ${filename} --out1 ${filename}.clean \
> --cut_front 20 --cut_tail 20 --cut_window_size 5 \
> --cut_mean_quality 15 -q 15 -w 16 --trim_front1 14 \
> --adapter_sequence=AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --adapter_sequence_r2=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
> done
```
Quality scores post fastp trimming

![fastp quality scores](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Raker_final_assignment/Images/fastp_quality.png)

Base contents post fastp trimming

![fastp base contents](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Raker_final_assignment/Images/fastp_base_contents.png)

##### de novo transcriptome with Trinity
Without a reference transcriptome, Trinity can be used to do *de novo* transcriptome analysis.

Install Trinity
```
wget https://github.com/trinityrnaseq/trinityrnaseq/archive/Trinity-v2.8.4.zip
unzip Trinity-v2.8.4.zip
cd trinityrnaseq-Trinity-v2.8.4/
make
make plugins
export TRINITY_HOME=/home/craker/diadema/trinityrnaseq-Trinity-v2.8.4
```

test Trinity
```
cd sample_data/test_Trinity_Assembly/
./runMe.sh
```

run Trinity on all clean files, using --full_cleanup option to delete uneeded files at the end of the analysis to save space
```
/home/craker/diadema/trinityrnaseq-Trinity-v2.8.4/Trinity \
--seqType fq --max_memory 50G \
--single DA-HI-A_S79_L007_R1_001_clean.fq,\
DA-HI-B_S80_L007_R1_001_clean.fq,\
DA-HI-C_S81_L007_R1_001_clean.fq,\
DA-LOW-A_S72_L007_R1_001_clean.fq,\
DA-LOW-B_S73_L007_R1_001_clean.fq,\
DA-LOW-C_S74_L007_R1_001_clean.fq,\
DA-LOW-D_S75_L007_R1_001_clean.fq,\
DA-MED-A_S76_L007_R1_001_clean.fq,\
DA-MED-B_S77_L007_R1_001_clean.fq,\
DA-MED-D_S78_L007_R1_001_clean.fq,\
OADA0006_S16_L002_R1_001_clean.fq,\
OADA0049_S25_L003_R1_001_clean.fq,\
OADA0058_S19_L002_R1_001_clean.fq,\
OADA0071_S53_L005_R1_001_clean.fq,\
OADA0081_S67_L006_R1_001_clean.fq,\
OADA0085_S24_L002_R1_001_clean.fq,\
OADA0101_S18_L002_R1_001_clean.fq,\
OADA0102_S33_L003_R1_001_clean.fq,\
OADA0116_S26_L003_R1_001_clean.fq,\
OADA0139_S17_L002_R1_001_clean.fq,\
OADA0174_S20_L002_R1_001_clean.fq \
--CPU 20 --full_cleanup
```

calculate number of clusters
```
cat da.trinity.fasta | grep '>' | wc -l
645371 clusters
```

##### Transdecoder and CD-Hit
Both of these programs are used to further group clusters.

###### Transdecoder
```
conda install transdecoder
TransDecoder.LongOrfs -t da.trinity.fasta
TransDecoder.Predict -t da.trinity.fasta
```
###### CD-hit
```
conda install cd-hit
cd-hit-est -i ./da.trinity.fasta.transdecoder_dir/longest_orfs.cds -o cdhit89 -n 8 -c 0.89 -M 96000 -T 20 -d 0
```
calculate number of clusters
```
cat cdhit89 | grep '>' | wc -l
65628 clusters
```
run TransDecoder on cd-hit output
```
TransDecoder.LongOrfs -t cdhit89
TransDecoder.Predict -t cdhit89
```
rename best fasta file (so it's easy to find later)
```
mv cdhit89.transdecoder.pep.fasta diadema.best.fasta
```

##### Blast files using Trinnotate
Trinnotate is used to annotate files.

Install Trinnotate
```
wget https://github.com/Trinotate/Trinotate/archive/Trinotate-v3.1.1.zip
unzip Trinotate-v3.1.1.zip
cd Trinotate-Trinotate-v3.1.1/
chmod 755 Trinotate
/home/craker/data/Trinotate-Trinotate-v3.1.1/admin/Build_Trinotate_Boilerplate_SQLite_db.pl  Trinotate
makeblastdb -in uniprot_sprot.pep -dbtype prot
gunzip Pfam-A.hmm.gz
hmmpress Pfam-A.hmm
```

BLAST
```
blastx -query /home/craker/data/Trinity.fasta -db /home/craker/data/Trinotate-Trinotate-v3.1.1/uniprot_sprot.pep -num_threads 20 -max_target_seqs 1 -outfmt 6 -evalue 1e-3 > blastx.outfmt6
blastp -query /home/craker/data/cdhit89.transdecoder.pep -db /home/craker/data/Trinotate-Trinotate-v3.1.1/uniprot_sprot.pep -num_threads 20 -max_target_seqs 1 -outfmt 6 -evalue 1e-3 > blastp.outfmt6
```

##### OrthoFinder
The *Diadema antillarum* data was compared to sequences from *Strongylocentrotous purpuratus*. Data for *S. purpuratus* was downloaded from EchinoBase.org.

Download *Diadema antillarum* data to personal computer, and then moved to KITT
```
scp -P XXXX ~/Desktop/Diadema/SPU_peptide.fasta.zip craker@kitt.uri.edu:/home/craker/diadema/
unzip SPU_peptide.fasta.zip
```

Install OrthoFinder
```
wget https://github.com/davidemms/OrthoFinder/releases/download/v2.3.1-beta/OrthoFinder-2.3.1_source.tar.gz
tar xvzf OrthoFinder-2.3.1_source.tar.gz
```
Test OrthoFinder
```
cd OrthoFinder-2.3.1_source/orthofinder
orthofinder -f ExampleData -S diamond
```
Copy fasta files to OrthoFinder directory
```
mkdir DAfastas
cp /home/craker/diadema/diadema.best.fasta ./DAfastas/
cp /home/craker/diadema/ortho_fastas/SPU_peptide.fasta ./DAfastas/
```
###### Run OrthoFinder
```
orthofinder -f ./DAfastas/ -t 20
```

##### Trinity transcript quantification
Necessary to perform further downstream analysis.

Install necessary programs
```
conda install salmon
conda install rsem
conda install bowtie2
```
Created a tab delimited text file of samples (da_samples.txt)

Prepare the reference and run alignment and abundance estimation
```
/home/craker/diadema/trinityrnaseq-Trinity-v2.8.4/util/align_and_estimate_abundance.pl \
--transcripts da.trinity.fasta --est_method salmon --aln_method bowtie2 \
--prep_reference --trinity_mode --samples_file da_samples.txt --seqType fq
```

Create matrices (test with two files)
```
/home/craker/diadema/trinityrnaseq-Trinity-v2.8.4/util/abundance_estimates_to_matrix.pl \
--est_method salmon \
--gene_trans_map da.trinity.fasta.gene_trans_map \
--out_prefix salmon \
--name_sample_by_basedir \
pH_high_rep1/quant.sf.genes \
pH_high_rep2/quant.sf.genes
```
At this point I kept getting the same error message, and was not able to fix it:
```
Error, no TPM value specified for transcript [TRINITY_DN0_c0_g1_i2] of gene [TRINITY_DN0_c0_g1] for sample pH_high_rep1 at /home/craker/diadema/trinityrnaseq-Trinity-v2.8.4/util/abundance_estimates_to_matrix.pl line 322.
```
These matrix files, specifically the salmon.isoforms.count.matrix file, would have been used to run DESeq2, and complete my gene expression analysis.

##### DESeq2
DESeq2 can actually be run from Trinity scripts, as long as the proper R packages are installed. To install the proper R packages:
```
% R
 > source("http://bioconductor.org/biocLite.R")
 > biocLite('edgeR')
 > biocLite('limma')
 > biocLite('DESeq2')
 > biocLite('ctc')
 > biocLite('Biobase')
 > install.packages('gplots')
 > install.packages('ape')
 ```
 DESeq2 is then run using this script:
 ```
 $TRINITY_HOME/Analysis/DifferentialExpression/run_DE_analysis.pl
 ```
 I planned to run it like this:
 ```
 $TRINITY_HOME/Analysis/DifferentialExpression/run_DE_analysis.pl \
 --matrix salmon.isoforms.count.matrix \
 --method DESeq2 --samples_file da_samples.txt
 ```
Results of this script would include volcano plots to visualize the data.

To extract and cluster differentially expressed transcripts, I would use this script:
```
$TRINITY_HOME/Analysis/DifferentialExpression/analyze_diff_expr.pl
```
and run it like this:
```
cd DESeq2_outdir

$TRINITY_HOME/Analysis/DifferentialExpression/analyze_diff_expr.pl \
--matrix TMM.EXPR.matrix
```
Results of this script would include a correlation heatmap.

From here one could do further analysis, such as GO-enrichment, depending on the results.
