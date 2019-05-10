## Final Assignment Project Plan
Population Structure and Gene Flow in *Acropora cervicornis*  
Author: E. Chille  

#### Brief Summary
Vital to Caribbean coral reef ecosystems, Acroporids provide numerous ecological functions including provision of food and complex habitat for commercially and recreationally important invertebrates and fishes. Since the 1980s, Acroporids have lost 80-98% of their 1970s-baseline population throughout their range, and where quantitative data is available, only 3% of the original population persists. After a major bleaching event in 2005, both *A. palmata* and *A. cervicornis* were listed in the ESA as threatened species with the key conservation objective of facilitating reproduction through conservation of substrate. Major threats to Acroporids include disease, temperature-induced bleaching, and physical damage from hurricanes, while moderate threats include physical anthropogenic damage, competition from coastal development, increased sedimentation, contaminants, and nutrients, sea level rise, and competition with macroalgae.   (Ctr. for Biological Diversity v. Nat’l Marine Fisheries Serv., 977 F. Supp. 2d 55, 2013). The persistence of Acroporids in the face of these stressors lies in their resistance and
resilience to disturbance. Recruitment and genetic connectivity between populations are key to maintaining the resistance and resilience of Acroporids by regulating standing genetic diversity (Drury, Paris, Kourafalou, & Lirman, 2018).

The goal of this analysis is to quantify genetic structure and gene flow between populations of *A. cervicornis* in the Caribbean to infer the resilience and resistance of this species to environmental and anthropogenic stressors.

#### Data description
The data for this study will be obtained through NCBI BioProject 473816: [Genome-wide survey of Caribbean Acroporids](https://www.ncbi.nlm.nih.gov/bioproject?LinkName=sra_bioproject&from_uid=5628611). Five *A. cervicornis* nubbins were collected from four regions in the Caribbean including Florida, the U.S. Virgin Islands, Belize, and Curacao (Kitchen et al., 2019).

Genomic DNA was extracted from each coral tissue using the Qiagen DNeasy kit (Qiagen, Valencia, CA) according to the manufacturer’s protocol. DNA quality was assessed using gel electrophoresis and quantity was assesed with Qubit 2.0 fluorometry (Thermo Fisher, Waltham, MA). Whole-genome Sequence library construction and sequencing was completed by the Pennsylvania State University Genomics Core Facility. Paired-end short insert sequencing libraries were constructed using 100 ng sample DNA and the TruSeq DNA Nano kit (Illumina, San Diego, CA). Libraries were pooled with ten samples of *A. palamata* and sequenced on the Illumina HiSeq 2500 Rapid Run (Illumina, San Diego, CA) over four lanes (Kitchen et al., 2019). Reads are 150bp paired-end with an insert size of 350 nt.

##### Samples, Origin, and Accession Number in NCBI:
|Index|Sample ID|Region|Reef|Latitude|Longitude|Collection Date|SRA Accession|
|---|---|---|---|---|---|---|---|
|1|CFL4927|Florida|CRF|25.2155|-80.60778|22-Nov-11|SRR7235993|
|2|CFL4923|Florida|CRF|25.16472|-80.59389|22-Nov-11|SRR7235994|
|3|CFL4928|Florida|CRF|25.03222|-80.50417|22-Nov-11|SRR7235992|
|4|CFL4959|Florida|CRF|24.9225|-81.12417|22-Nov-11|SRR7235991|
|5|CFL4960|Florida|CRF (Grassy Key)|24.71182|-80.94595|22-Nov-11|SRR7235990|
|6|CVI13714|USVI|Hans Lollik|18.40191|-64.9063|29-Oct-15|SRR7235998|
|7|CVI13696|USVI|Botany|18.3569|-65.03515|27-Oct-15|SRR7235989|
|8|CVI13712|USVI|Botany|18.3569|-65.03515|28-Oct-15|SRR7235999|
|9|CVI13738|USVI|Sapphire|18.3333|-64.8499|30-Oct-15|SRR7236021|
|10|CVI13758|C1456|USVI	Flat Key|18.31701|-64.9892|31-Oct-15|SRR7236022|
|11|CBE13837|Belize|Glovers Atoll|16.88806|-87.75973|8-Nov-15|SRR7236028|
|12|CBE13827|Belize|Glovers Atoll|16.88806|-87.75973|8-Nov-15|SRR7236033|
|13|CBE13786|Belize|South Carrie Bow Cay|16.80132|-88.0825|6-Nov-15|SRR7236032|
|14|CBE13792|Belize|Sandbores|16.77913|-88.11755|7-Nov-15|SRR7236031|
|15|CBE13797|Belize|Sandbores|16.77913|-88.11755|7-Nov-15|SRR7236034|
|16|CCU13903|Curacao|SeaAquarium|12.0842|-68.8966|2-Feb-16|SRR7236029|
|17|CCU13901|Curacao|SeaAquarium|12.0842|-68.8966|2-Feb-16|SRR7236030|
|18|CCU13905|Curacao|SeaAquarium|12.0842|-68.8966|2-Feb-16|SRR7236037|
|19|CCU13917|Curacao|Directors Bay|12.066|-68.85997|4-Feb-16|SRR7236036|
|20|CCU13925|Curacao|East Point|12.04069|-68.78301|5-Feb-16|SRR7235996|

Table 1. Samples, Origin, and Accession Number in NCBI. Adapted from Table 1, Kitchen et al., 2019.

#### Analysis Outline
1. Download genomic data from NCBI using SRA-toolkit
2. Initial raw data assesment and characterization using FastQC and MultiQC
3. Trim reads using Trimmomatic
4. Align reads to reference genome ([*A. digitifera*](https://www.ncbi.nlm.nih.gov/nuccore/NW_015441057.1?report=fasta)) using BWA MEM
5. Call and filter SNPs using dDocent (**CODE MAY NEED TO BE ALTERED**)
6. Scan VCF for neutral loci and loci under selection using BayeScan v.2.1 and pcadapt
7. Examine genomic structure using PCA analysis and pairwise Fst on neutral loci
8. Evaluate summary statistics in neutral loci including observed heterozygosity, expected heterozygosity, overall FST, and FIS uring the basic.stats function in the R package hierfstat
9. Use Treemix and Admixture to evaluate population connectivity

#### Navigation
- Chille_Final_Assignment_Documentation.md
- MultiQC_results
    - fastqc_adapter_content_plot.png
    - fastqc_per_base_sequence_quality_plot.png
    - fastqc_per_sequence_gc_content_plot.png
    - fastqc_per_sequence_quality_scores_plot.png
    - fastqc_sequence_counts_plot.png
    - multiqc_report.html
- Scripts
    - bwa.sh
- Supporting_files
    - popmap
    - SraAccListp.txt

#### References
Ctr. for Biological Diversity v. Nat'l Marine Fisheries Serv., 977 F. Supp. 2d 55, 2013 U.S. Dist. LEXIS 148920, 2013 WL 5615059 (United States District Court for the District of Puerto Rico, October 23, 2013, Filed). Retrieved from <https://advance-lexis-com.uri.idm.oclc.org/api/document?collection=cases&id=urn:contentItem:59KG-JKC1-F04F-50BK-00000-00&context=1516831>.

Drury, C., Paris, C. B., Kourafalou, V. H., & Lirman, D. (2018). Dispersal capacity and genetic relatedness in Acropora cervicornis on the Florida Reef Tract. *Coral Reefs*, 37(2), 585–596. <https://doi.org/10.1007/s00338-018-1683-0>


Kitchen, S. A., Ratan, A., Bedoya-Reina, O. C., Burhans, R., Fogarty, N. D., Miller, W., & Baums, I. B. (2019). Genomic variants among threatened Acropora corals. *G3: Genes, Genomes, Genetics*, g3-400125. <https://doi.org/10.1534/g3.119.400125>

