# **BIO594 Spring 2019: Final Project**
#### Cassie Raker


### Summary
The sea urchin *Diadema antillarum* used to be a common species in the Caribbean, but has faced serious decline in recent years. While its genome has never been fully sequenced, other similar species have been sequenced and can be used to compare and identify functional genomic groups. By combining our knowledge of other urchin species with RNA-seq of *D. antillarum*, we can identify what genes are important to stress response. RNA-seq is the best choice to analyze changes in gene expression over different treatments.

### Data
Adult and larvae *D. antillarum* were exposedto high (7.9), medium (7.6), and low (7.2) pH conditions before RNA extractions. Samples were sequenced using Illumina HiSeq 4000 100bp SR (single-end reads). Read sets will be transferred to the URI kitt server for analysis.

### Analysis Methods
1. Asses quality of reads using **FastQC**
2. Trim reads for quality and trim adapters using **fastp**
3. *de novo* transcriptome assembly using **Trinity**
4. Identify candidate coding regions using **TransDecoder**
5. Cluster sequences and reduce data **CDHit**
6. Annotate reads using **Trinnotate**
7. Find orthologs using **Orthofinder**
8. Use **DESeq2** to identify differential gene expression

### Future Analysis
Compare *D. antillarum* to two other urchin species (other species being analyzed by other investigators)

### Navigation
**Raker_project_plan.md**: original outline for the project
**da_md.md**: markdown file of steps taken to analyze *D. antillarum* data
**Data**: directory containing tab delimited text file grouping samples by pH treatment, MultiQC report, fastp output
**Orthofinder_results**: directory containing .csv files describing orthogroups
**Images**: directory containing images used in da_md.md

### References

###### FastQC
https://www.bioinformatics.babraham.ac.uk/projects/fastqc/

###### MultiQC
MultiQC: Summarize analysis results for multiple tools and samples in a single report
Philip Ewels, Måns Magnusson, Sverker Lundin and Max Käller
Bioinformatics (2016)
doi: 10.1093/bioinformatics/btw354
PMID: 27312411

###### Fastp
Shifu Chen, Yanqing Zhou, Yaru Chen, Jia Gu; fastp: an ultra-fast all-in-one FASTQ preprocessor, Bioinformatics, Volume 34, Issue 17, 1 September 2018, Pages i884–i890, https://doi.org/10.1093/bioinformatics/bty560

###### Trinity
Grabherr MG, Haas BJ, Yassour M, Levin JZ, Thompson DA, Amit I, Adiconis X, Fan L, Raychowdhury R, Zeng Q, Chen Z, Mauceli E, Hacohen N, Gnirke A, Rhind N, di Palma F, Birren BW, Nusbaum C, Lindblad-Toh K, Friedman N, Regev A. Full-length transcriptome assembly from RNA-seq data without a reference genome. Nat Biotechnol. 2011 May 15;29(7):644-52. doi: 10.1038/nbt.1883. PubMed PMID: 21572440.

###### TransDecoder
Haas & Papanicolaou et al., manuscript in prep.  http://transdecoder.github.io

###### CDHit
Weizhong Li, Lukasz Jaroszewski & Adam Godzik. Clustering of highly homologous sequences to reduce the size of large protein databases. Bioinformatics (2001) 17:282-283, PDF, Pubmed

###### Trimmomatic
Bolger, A. M., Lohse, M., & Usadel, B. (2014). Trimmomatic: A flexible trimmer for Illumina Sequence Data. Bioinformatics, btu170.

###### DESeq2
Love, M.I., Huber, W., Anders, S. (2014) Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2. Genome Biology, 15:550. 10.1186/s13059-014-0550-8
