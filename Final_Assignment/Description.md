# Final Assignment for BIO 594

The final assignment for class is to produce a set of completely open and reproducible population genomic analyses, from raw data to final analysis.

![alt text](https://i2.wp.com/media.giphy.com/media/11JTxkrmq4bGE0/giphy.gif?zoom=2&resize=399%2C307&ssl=1)

## Important Deadlines

|Date| What's Due|
|---|-----|
|04/10/18| Project Plan|
|04/17/18| In class work|
|04/24/18| In class work|
|05/10/18| **FINAL PROJECT DUE**|

## Project Requirements

### Data
You are welcome to use any data set that you would like.  The only exception being a data set that already has published results; however, it is acceptable to analyze a published dataset using a different set of analyses.  If you don't have a good data set to work with, Dr. Puritz can provide you with a small RADseq data set or simulated data set.

**This is meant to be as useful to you as possible, and you're strongly encouraged to work on actual data**

### Analyses
Computational work can be performed on any computer.  It is greatly preferred that whole data sets are not loaded onto KITT, but this can be arranged if necessary.  

The scope of analysis can be anything that was covered in class or any other population-level analysis (assuming pre-approval from Dr. Puritz).  Possible data sets include: RADseq, RNAseq, Exome Capture, Methylation analysis, WGS, etc.  Possible analytical topics include: detecting natural selection, characterizing neutral population structure and/or connectivity, parentage analysis, calculating effective population size, admixture, transcriptome characterization and annotation, differential expression, phylogenomcis, GWAS, differential analysis of genome methylation, etc.

#### Required Elements
* **Initial Raw Data Assesment and Characterization**
  * Read counts
  * Read quality
* **Bioinformatic Processing**
  * **Read Trimming and Adapter Removal**
  * ***De Novo* Reference Assembly**
    * If required.  It is perfectly acceptable to use an existing reference
  * **Read Mapping**
  * **Variant Calling or Read Counts**
    * Whatever the final product is for your population analyses
* **Population-level Analyses**
  * 3 different analyses are required with publication quality figures and/or tables
    * Analysis type will vary by study goal
* **Documentation**
  * **ALL** code, configuration files, and additional data must be included to fully reproduce your analyses on any computing system.
  * In this repository folder, create a single directory with your name and include:
    * Final markdown file
      * This file should include the code for the entire project from raw data to final analysis
      * File should be properly formatted in markdown with embedded images of critical figures and tables of final data
    * Final data file
      * For example for a SNP based project, this should be your final filtered VCF file used in subsequent analysis
    * All other data needed to repeat all analyses
      * Custom configuration files
      * Adapter/barcodes
      * Sample metadata 
      * Anything else that might be needed

### Project Plan

For your project plan, post a document in this repository folder.  It should include the following elements:
* Brief Summary
  * Describe the project/system, and highlight the basic goals of the analysis
* Data description
  * Summarize the type of data, the location, and the size of the data set
* Analysis Plan
  * Briefly outline your analysis plan with a one-line justification for each step.
  
### Grading Rubric

* Project Plan and Approval (10 points)
  * A detailed outline of the proposed data set and analyses must be submitted and approved by Dr. Puritz by 4/11/18
* Analysis (20 points)
  * All bioinformatic analyses are properly completed
  * Appropriate population genomic analyses are utilized and properly completed
* Documentation (20 points)
  * All work must be fully documented and repeatable on the class Github account

