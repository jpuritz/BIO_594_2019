# **BIO594 Spring 2019: Final Project**
#### Cassie Raker

## Project Plan
### Summary
The sea urchin *Diadema antillarum* used to be a common species in the Caribbean, but has faced serious decline in recent years. While its genome has never been fully sequenced, other similar species have been sequenced and can be used to compare and identify functional genomic groups. By combining our knowledge of other urchin species with RNA-seq of *D. antillarum*, we can identify what genes are important to stress response. RNA-seq is the best choice to analyze changes in gene expression over different treatments.

### Data
Adult and larvae *D. antillarum* were exposedto high (7.9), medium (7.6), and low (7.2) pH conditions before RNA extractions. Samples were sequenced using Illumina HiSeq 4000 100bp SR (single-end reads). Read sets will be transferred to the URI kitt server for analysis.

### Analysis Methods
1. Asses quality of reads using **FastQC**
2. Trim reads for quality and trim adapters using **fastp**
3. Use **SortMeRNA** to filter out any remaining rRNA
4. *de novo* transcriptome assembly using **Trinity**
5. Identify candidate coding regions using **TransDecoder**
6. Cluster sequences and reduce data **CDHit**
7. Annotate reads using **Trinnotate**
8. Find orthologs using **Orthofinder**
9. Use **DESeq2** to identify differential gene expression
10. Compare *D. antillarum* to two other urchin species (other species being analyzed by other investigators)
