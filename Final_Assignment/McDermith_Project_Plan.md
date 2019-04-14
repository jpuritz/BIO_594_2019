# Final Project Plan

Project Summary
 In low iron marine environments phytoplankton may be able to use compounds produced by bacteria that increase the bioavailability of iron. These iron-binding secondary compounds are known as siderophores. Siderophores are widely produced by many bacteria in a variety of environments including both aquatic and terrestrial habitats. This proposed project aims to analyze a possible mutualistic relationship between bacteria and phytoplankton in the North Atlantic, a well-known iron-limited environment, through genome analysis. I intend to analyze the genome of _ _Salegentibacter _ _ sp., a bacterium isolated from the North Atlantic, to look for genes used to produce secondary compounds such as siderophores. This project will further our understanding of how organisms adapt to low iron environments. 
 
 Goals
 I will trim, assemble and annotate a bacterial genome in command line. This work will aim to identify genes used in siderophore production in a genome sequence of the bacterium Salegentibacter. I will also compare this genome analysis to published _ _Salegentibacter_ _ sp. genomes.  

Data
The type of data is a paired end whole genome Illumina sequence and is accessible from a Jenkins Lab computer. Each read contains approximately 2,600,000 nucleotides.

Methods
1. FastQc will be used to analyze the initial quality of my sequence.
2. Trimmomatic will be used to trim sequence primers and low quality nucleotides. The quality of the trimmed sequences will be analyzed with FastQc.
3. Velvet will be used for the assembly.
4. BUSCO will be used to assess the assembly quality. 
5. Scaffolds will be ordered to a known Salegentibacter genome using a BLAST database and Mauve.
6. Annotation will be done using Prokka. 
