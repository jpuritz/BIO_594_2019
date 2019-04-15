# EpiRADseq Analysis of Juvenile Geoducks under Ocean Acidification Stress
BIO594: Using Genomic Techniques to Study the Evolution of Populations; Dr. Jon Puritz  

Author: EL Strand  
Last edited: 20190408  

All code, instructions, raw data, and final figures produced will be provided and explained on this document in an effort to enhance the presence of open data and reproducibability in science.

## Project Plan
### Project Summary
The Pacific Geoduck (*Panopea generosa*) is a critical contributer to the Pacific Northwest's ecosystem, aquaculture, and export fishery. However, climate change stressors continue to rapidly deconstruct once stable ecosystems, forcing organisms to either move environments (migrate), change their phenotype and response (acclimatize), and/or adapt to their new environment. This challenge is particularly difficult for sessile organisms that cannot simply move to another location, like the pacific geoduck, *P. generosa*, leaving acclimatizing and adapting as their only options. The main stressor for *P. generosa* and other Pacific Northwest bivalves is ocean acidifcation, the drop in pH level of the ocean due to excess CO<sub>2</sub> absorbed by the ocean from the atmosphere. This drop in pH level causes a depletion of carbonate concentration in the water, challenging a califying organism's ability to use calcium carboante to build and maintain their skeleton or shell.

In an effort to understand the molecular mechanims underlying an organism's potential to acclimatize, an ambient and low pH experiment was conducted on larval geoduck to test survival rates in both conditions and investigate methylation patterns of the genome. DNA methylation is a form of epigenetics that has been known to influence gene expression patterns, and thus is an important mechanism to evaluate when attempting to elucidate an organism's ability to change their phenotype in response to the environment. 


### Experimental Design
About 7 million geoduck larvae were exposed to acute pH stress with 2 treatments: ambient (7.9) and low (7.41) pH for 6 days. On the 7th day, the larvae from the low pH treatment were separated into two experimental conditions: low (7.41) and extreme low (7.00) pH for three days. Survivorship was tracked through the 10 days and molecular timepoints were taken at 0, 2, 4, 6, and 10 days. Molecular samples were stored in RNAlater and at -80°C. 

A summary of survivorship data and diagram of experimental design can be found here: [Trial 2 Preliminary Summary](https://safsoa.wordpress.com/2016/03/19/trial-2-preliminary-summary/)

This experiment was conducted by a research team led by Dr. Hollie Putnam and Dr. Steven Roberts at the University of Washington in 2016. This analysis includes EpiRADseq data files for 10 geoduck larvae samples from different pH treatments. 

## Molecular Analysis
#### DNA Extraction
In January of 2017, DNA extractions as well as quality and quantity assessment of extracted DNA was evaluted. DNA was quantified with qubit, and quality was assessed with gel electrophoresis. A full summary of protocols used and raw data can be found here: [Geoduck Larval DNA Extractions](https://hputnam.github.io/Putnam_Lab_Notebook/Geoduck_Larval_DNA_Extractions/). 

The following subset of samples were selected for EpiRADseq analysis: 2 samples (Epi-3, Epi-4) from Day 0 Ambeint pCO<sub>2</sub>, 3 samples (Epi-33, Epi-34, Epi-35) from Day 6 Ambient pCO<sub>2</sub>, 3 samples (Epi-29, Epi-30, Epi-32) from Day 6 High pCO<sub>2</sub>, 1 sample (Epi-60) from Day 10 Ambient pCO<sub>2</sub>, and 1 sample (Epi-66) from Day 10 High pCO<sub>2</sub>.  

> The EpiRADseq method allows for quantitive comparisons of patterns of genomewide methylation between samples, particularly in non-model organisms. This method samples loci (with next-generation sequencing) that are not methylated in order to identify changes in methylation states. Since the restriction enzyme used in EpiRADseq is methylation sensitive, unmethylated loci will result in no reads and methylated loci will result in reads. The result is a frequency of methylation occuring within the samples at a particular sampled locus. EpiRADseq allows researchers to identify differential methylation between samples and in this case, if there is any affect of pH treatment on methylation patterns between treatments. 

#### EpiRAD Library Prep
Libraries were created for the samples selected for EpiRADseq analysis using restriction enzymes PstI and HpaII. HpaII was chosen because it is methylation sensitive. A series of digestions, bead clean-ups, ligations, more bead clean-ups, size selection, qubit, PCR, final bead clean-ups and qubit quantifications were used to prep RAD libraries (see full protocol below). Agilent TapeStation was used to ensure fragment sizes selected by Pippin Prep were correct and consistent.

Note: These samples were sent for sequencing in the same order as other samples from the same lab. The follow links and protocols have the information regarding all samples sent, not just the EpiRADseq samples analyzed here.

A full summary of protocol used for RAD library prep can be found here: [Day 1 & 2](http://onsnetwork.org/jdimond/2016/08/02/rad-sequencing-days-12/), [Day 3 & 4](http://onsnetwork.org/jdimond/2016/08/04/radseq-day-3/), [Day 5](http://onsnetwork.org/jdimond/2016/08/08/radseq-day-5/), and [Library Prep Notes](http://onsnetwork.org/jdimond/2017/02/14/rad-library-prep/).

A full list of the samples from the RAD library prep and sequencing can be found here: [ddRAD/EpiRAD run](https://docs.google.com/spreadsheets/d/1zS7lGuESGLiRUs8qdDf1aYxaYBmNHnwx51YtsAs83O4/edit#gid=1930556752). 

Libraries were then sent to UC Berkeley for sequencing. The sequencing facility perfomed qPCR to confirm libraries were combined in equimolar ratios. 

#### Sequenced Data Files
Information regarding evaluating the data integrity of the received demultiplexed and non-demultiplexed data files can be found here: [Data Received](http://onsnetwork.org/kubu4/2017/02/27/data-received-jays-coral-radseq-and-hollies-geoduck-epi-radseq/). 


## Bioinformatic Analysis
### Initial Raw Data Analysis and Characterization
This step includes quantifying read counts and quality. Poor quality or too low of read counts will be excluded to improve overall data quality.

### Bioinformatic Processing
This step includes read trimming, adapter removal, reference assembly, read mapping, and read counts. Adapters need to be removed since they are not part of the organism's DNA sequence. The annotated genome for *P. generosa* has been published (and can be found here: [Geoduck Genome](https://robertslab.github.io/sams-notebook/2019/01/15/Annotation-Geoduck-Genome-with-MAKER-Submitted-to-Mox.html)) and will be used as a reference. All analysis will be done with a version of the `dDocent` pipeline.

### Population-level Analyses
This step includes 3 different analyses of the differential methylation across individuals placed in two different treatments. Final figures and tables will be produced in this section.  




