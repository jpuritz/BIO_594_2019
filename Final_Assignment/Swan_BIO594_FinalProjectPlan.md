## Gene expression profiling of human NK cells in HIV, HCV and HBV patients

Swan Tan

### Background Summary

There are two main types of immunity, i.e. innate and adaptive immunity. Innate immunity is usually regarded as our body first line defense mechanism. One of the components of human innate immune system is natural killer cells. </br>

>**What are natural killer cells?**</br>

Natural killer cells, also known as NK cells, are large granular lymphocytes (a type of white blood cell). NK cells respond quickly to a wide variety of pathological challenges. They play a major role in fighting tumours or cancerous cells, as well as useful in combating virally infected cells [(Caligiuri, 2008)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2481557/). </br>

NK cells are cytotoxic; small granules in their cytoplasm contain special proteins such as perforin and proteases known as granzymes. Upon release in close proximity to a cell slated for killing, perforin forms pores in the cell membrane of the target cell through which the granzymes and associated molecules can enter, inducing apoptosis. The distinction between apoptosis and cell lysis is important in immunology: -lysing a virus-infected cell would only release the virions, whereas apoptosis leads to destruction of the virus inside [(Science Daily)](https://www.sciencedaily.com/terms/natural_killer_cell.htm). </br>

NK cells serve to contain viral infections while the adaptive immune response is generating antigen-specific cytotoxic T cells that can clear the infection. Individuals with NK cell deficiency or abnormalitiy are more susceptible to viral infection. Studies reported that this immunological defect in some cases can lead to overwhelming fatal infection during childhood [(Caligiuri, 2008)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2481557/).</br>

>**Chronic human infections**</br>

Acute viral infection is usually accompanied by early production of infectious virions and rapid eradication of the virus by the host immune system [(Boeijen et. al, 2018)](https://jvi.asm.org/content/early/2018/08/31/JVI.00575-18.long). However, ineffective clearance of the virus can result in latent and even persistent infection within the host. In contrast to viruses like Epstein Barr virus (EBV), cytomegalovirus (CMV), or herpesviruses that may reinitiate replication after long periods of latency [(Traylen et. al, 2011)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3142679/pdf/nihms304451.pdf), three viruses have the capacity to persistently replicate resulting in considerable viral loads in the blood of immune competent individuals: human immunodeficiency virus (HIV), hepatitis C virus (HCV) and hepatitis B virus (HBV). Untreated patients with these diseases may harbor high viral loads for decades, which can be associated with variable degrees of immune activation or inflammation, but their antiviral host immune responses are insufficient to eradicate the virus [(Zuniga et. al, 2015)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4785831/).</br>

>**How studying NK cells relate to chronic diseases?**</br>

Manipulation of NK cells seems to hold promise in efforts to improve organ transplantation, promote antitumor immunotherapy and control inflammatory and autoimmune disorders [(Vivier et. al, 2008)](http://dx.doi.org/10.1038/ni1582). Hence, with sequencing techniques that have significantly improved and popularized, gene expression profiling of human NK cells could provide a better picture and important details necessary to uncover the origin of functional and phenotypical differences between viremic patients and healthy subjects [(Boeijen et. al, 2018)](https://jvi.asm.org/content/early/2018/08/31/JVI.00575-18.long). The results from this study could benefit and facilitate future in vitro manipulation experiments.</br>

### Goals
1.	To compare NK cell transcripts of viremic HIV, HCV and HBV untreated patients.
2.	To utilize the published sequencing datasets and apply a different transcriptomics analysis approach.

### Data Description
| **Information** | **Description** |
| ------------- | ------------- | 
| Assay type | RNA-Seq |
| Instrument | Illumina HiSeq 2500 |   
| Library selection | cDNA |
| Library source | Transcriptomic |
| DataSets series | [GSE125686](https://www.ncbi.nlm.nih.gov/gds/?term=GSE125686) |
| Sample type | SRA |
| Location | Patients recruited from outpatient clinic of the Erasmus MC Rotterdam |
| Number of subjects | Healthy control 1 (Asian): 8 </br> Healthy control 2 (Caucasian): 12 </br> HIV (Caucasian): 6 </br> Hepatitis C, HCV (Caucasian): 8 </br> Hepatitis B, HBV (Asian): 32 </br> Total: 66 |

### Analysis Plan - Transcriptome Pipeline
| **Step** | **Description** |
| ------------- | ------------- | 
| 1. Data acquisition | - gather transcriptome raw reads from NCBI </br> - Tool: SRA-toolkit |
| 2. Sequence reads pre-processing | - trim adapters and low quality score sequences </br> - measure GC content of reads </br> - Tool: Fastp |
| 3. Reads alignment | - align reads to human reference genome hg19 </br> - Tool: HISAT2 / SAM Tools |
| 4. Assembly | assemble and quantify reads </br> - Tool: StringTie |
| 5. Differential gene expression analysis | - to compare NK cells gene expression between disease infected patients and healthy individuals </br> - statistical testing </br> - Tool: DESeq2/ edgeR |
