# Impacts of sewage effluent on genomic diversity and connectivity of marine intertidal communities
#### _Background_
Coastal urban areas, home to over 50% of the population in the USA and over 60% of the population of the world, are a major source of marine pollution in coastal environments. This pollution enters the marine environment via either sewage effluent (wastewater) from wastewater treatment facilities, or runoff (stormwater) from rivers and municipal drainage systems. Stormwater and wastewater actively transport a variety of chemicals and substances that are known to be harmful to marine organisms. However, few studies have focused on the biphasic life cycle of marine organisms, that consists of a benthic, low migrating adult stage with low dispersal potential and a pelagic larval stage that spends highly variable amounts of time in the water column. Species with this life cycle are dependent on the early life stages for long-distance dispersal to increase gene flow across populations. One population connectivity study found that stormwater and wastewater are effective barriers to larval dispersal and significantly reduce gene flow between populations in a sea star species in coastal California (Puritz & Toonen 2011).

To characterize the evolutionary impacts of sewage effluent on other marine intertidal communities, an experiment was conducted on the mudflat fiddler crab (_Uca rapax_), a benthic, demersal species that is reliant on pelagic larvae for dispersal. The crabs were sampled near three different wastewater outfalls in the City of Corpus Christi, and at two control sites that are not likely influenced by sewage effluent. This study will determine if:

1.	Fiddler crab populations located near sewage effluent sources will have lower genetic diversity and heterozygosity compared to the control populations.
2.	Fiddler crab populations located near sewage effluent sources will have lower genetic connectivity compared to the control populations
3.	Candidate genes under selection in response to wastewater will have similar variant frequencies among populations near sewage effluent sources and different variant frequencies among control populations.

#### _Field Collections_

Individuals of _Uca rapax_ were sampled across 12 different sites within 5 localities ranging in proximity to wastewater outfall. Individuals from each site were collected, measured, photographed, and a back leg removed and stored in DNA preservation buffer.

#### _Laboratory methods_

Individuals of _Uca rapax_ were genotyped across tens of thousands of loci using restriction-site associated DNA tags (RADseq) and Illumina sequencing technology. The RADseq libraries were processed at the Marine Genomics Laboratory (MGL) at the Harte Research Institute.

#### _Data_

* Population: 12 populations from 5 different localities (10 near sewage effluent sources, 2 controls)
* The sequenced data files are located on KITT and can be accessed via

  PATH:  `/home/azyck/Fiddler_Crab`
* Size: 376 individuals (28-33 per population), 150bp sequences
* Sequences were previously demultiplexed with barcodes and individuals from a different species were removed (completed by Dr. Jon Puritz)


#### _Bioinformatic Analysis_
* Initial Raw Data Assessment and Characterization
   * Count the RAW reads
   * Examine quality of data (fastqc)
* Bioinformatic Processing - completed using dDocent 
   * Trimming adapters and low quality reads (fastp)
   * De Novo Reference Assembly (rainbow)
   * Read Mapping (FreeBayes)
   * SNP calling and filtering (VCFtools)
* Population-level Analyses
   * Outlier Detection Programs
   * Bayscan
   * Bayenv2
   * PCAadapt
   * Outflank
* Additional Anaylses
   * Spatial Principal Components Analysis (sPCA)
   * Pairwise Fst
   * Genetic diversity (observed and expected heterozygosity)
   * EEMS (https://www.nature.com/articles/ng.3464)
      
*Using the results from these 4 analyses, the data set will be divided in two categories: putatively neutral SNPs and SNPs putatively under selection.

#### _References_

Puritz, J. B., Hollenbeck, C. M., Gold, J. R. dDocent: a RADseq, variant-calling pipeline designed for population genomics of non-model organisms. PeerJ 2:e431

Puritz, J.B., Matz, M. V., Toonen, R. J., Weber, J. N., Bolnick, D. I., Bird, C. E. Comment: Demystifying the RAD fad. Molecular Ecology 23: 5937–5942. doi: 10.1111/mec.12965

Puritz, J. B. and Toonen, R. J. 2011. Coastal Pollution Limits Pelagic Larval Dispersal. Nature
Communications 2:228.
