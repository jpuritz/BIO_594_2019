## Project Plan
#### NOTE: Analysis is performed from a thesis submitted to URI in 2018 by Tejashree Modak(Gomez-Chiarri lab) on Eastern Oyster Larval transcriptomes in response to probiotics and pathogenic bacteria.

### Summary
Vibrio spp. are common pathogens which causes diseases in a wide variety of aquatic species including oysters, the pathogen vibrio tubiashii RE22 causes vibriosis in oysters larvae leading to mortality in the oysters thereby affecting the oyster hatcheries.The pathogens are able to cause immunosuppresion of the hosts as a means of pathogenesis. Several studies have characterised changes in gene expression patterns of the oyster larvae in responds to vibrio infection. (Hasegawa et al.,2008).

### AIM
#### To identify differential expressed immune genes in oyster larvae upon exposure to the pathogen vibrio tubiashii RE22

### Analysis Plan

### Initial Raw Data Assessment
The Eastern oyster reference genome, three transcriptomes data each following challenge of oyster larvae with RE22 and three Transcriptome data for control samples will be obtained  from ncbi SRA database using the function fastq-dump from SRA Toolkits on the cluster.

#### Bioinformatic Processing
 1. Preprocessing of raw reads and quality checking 
##### a. FASTQC to check the overall quality of the reads
##### b. Fastp for read trimming and adaptor sequence checking and trimming
 2. Align transcriptome reads obtained to the reference genome.
##### a. HISAT2
 3. Read Assembly and quantification will be performed using
##### a. Stringtie
 4. Compare depth of sequencing of samples
##### a. Samtools

### Analysis
 5. Differential gene expression analysis using
##### a. DESeq2 in R studio
 6. Mapping of differentially expressed genes(DEG) to ncbi protein non-redundant using
##### a. BLASTx
 7. Mapping DEG to Gene Ontology Terms
##### a. BLAST2GO

#### References
 Hasegawa, Lind, Boin, Hase, 2008. The Extracellular Metalloprotease of Vibrio tubiashii Is a Major Virulence Factor for Pacific Oyster (Crassostrea gigas) Larvae. Applied and Environmental Microbiology 74, 4101–4110.
