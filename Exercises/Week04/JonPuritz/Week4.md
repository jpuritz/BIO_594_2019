Week4
================
JonPuritz
2/20/2019

``` bash

cd ~/repos/BIO_594_2019/Exercises/Week04/JonPuritz
```

``` bash
source activate filter
```

``` bash
cp -r /home/BIO594/DATA/Week4/realdata/* .
```

``` bash
source activate filter
cd exome_capture
fastqc *
fastp --in1 CASE_J03.F.fq.gz --in2 CASE_J03.R.fq.gz --out1 CASE_J03.R1.fq.gz --out2 CASE_J03.R2.fq.gz --cut_by_quality5 20 --cut_by_quality3 20 --cut_window_size 5 --cut_mean_quality 15 -q 15 -u 50 -j CASE_J03.json -h CASE_J03.html --detect_adapter_for_pe
fastp --in1 Capture1.F.fq --in2 Capture1.R.fq --out1 Capture1.R1.fq.gz --out2 Capture1.R2.fq.gz --cut_by_quality5 20 --cut_by_quality3 20 --cut_window_size 5 --cut_mean_quality 15 -q 15 -u 50 -j Capture1.json -h Capture1.html --detect_adapter_for_pe
fastqc *.R1.fq.gz
fastqc *.R2.fq.gz
multiqc .
```

    ## Started analysis of Capture1.F.fq
    ## Approx 5% complete for Capture1.F.fq
    ## Approx 10% complete for Capture1.F.fq
    ## Approx 15% complete for Capture1.F.fq
    ## Approx 20% complete for Capture1.F.fq
    ## Approx 25% complete for Capture1.F.fq
    ## Approx 30% complete for Capture1.F.fq
    ## Approx 35% complete for Capture1.F.fq
    ## Approx 40% complete for Capture1.F.fq
    ## Approx 45% complete for Capture1.F.fq
    ## Approx 50% complete for Capture1.F.fq
    ## Approx 55% complete for Capture1.F.fq
    ## Approx 60% complete for Capture1.F.fq
    ## Approx 65% complete for Capture1.F.fq
    ## Approx 70% complete for Capture1.F.fq
    ## Approx 75% complete for Capture1.F.fq
    ## Approx 80% complete for Capture1.F.fq
    ## Approx 85% complete for Capture1.F.fq
    ## Approx 90% complete for Capture1.F.fq
    ## Approx 95% complete for Capture1.F.fq
    ## Approx 100% complete for Capture1.F.fq
    ## Analysis complete for Capture1.F.fq
    ## Started analysis of Capture1.R.fq
    ## Approx 5% complete for Capture1.R.fq
    ## Approx 10% complete for Capture1.R.fq
    ## Approx 15% complete for Capture1.R.fq
    ## Approx 20% complete for Capture1.R.fq
    ## Approx 25% complete for Capture1.R.fq
    ## Approx 30% complete for Capture1.R.fq
    ## Approx 35% complete for Capture1.R.fq
    ## Approx 40% complete for Capture1.R.fq
    ## Approx 45% complete for Capture1.R.fq
    ## Approx 50% complete for Capture1.R.fq
    ## Approx 55% complete for Capture1.R.fq
    ## Approx 60% complete for Capture1.R.fq
    ## Approx 65% complete for Capture1.R.fq
    ## Approx 70% complete for Capture1.R.fq
    ## Approx 75% complete for Capture1.R.fq
    ## Approx 80% complete for Capture1.R.fq
    ## Approx 85% complete for Capture1.R.fq
    ## Approx 90% complete for Capture1.R.fq
    ## Approx 95% complete for Capture1.R.fq
    ## Approx 100% complete for Capture1.R.fq
    ## Analysis complete for Capture1.R.fq
    ## Started analysis of CASE_J03.F.fq.gz
    ## Approx 5% complete for CASE_J03.F.fq.gz
    ## Approx 10% complete for CASE_J03.F.fq.gz
    ## Approx 15% complete for CASE_J03.F.fq.gz
    ## Approx 20% complete for CASE_J03.F.fq.gz
    ## Approx 25% complete for CASE_J03.F.fq.gz
    ## Approx 30% complete for CASE_J03.F.fq.gz
    ## Approx 35% complete for CASE_J03.F.fq.gz
    ## Approx 40% complete for CASE_J03.F.fq.gz
    ## Approx 45% complete for CASE_J03.F.fq.gz
    ## Approx 50% complete for CASE_J03.F.fq.gz
    ## Approx 55% complete for CASE_J03.F.fq.gz
    ## Approx 60% complete for CASE_J03.F.fq.gz
    ## Approx 65% complete for CASE_J03.F.fq.gz
    ## Approx 70% complete for CASE_J03.F.fq.gz
    ## Approx 75% complete for CASE_J03.F.fq.gz
    ## Approx 80% complete for CASE_J03.F.fq.gz
    ## Approx 85% complete for CASE_J03.F.fq.gz
    ## Approx 90% complete for CASE_J03.F.fq.gz
    ## Approx 95% complete for CASE_J03.F.fq.gz
    ## Approx 100% complete for CASE_J03.F.fq.gz
    ## Analysis complete for CASE_J03.F.fq.gz
    ## Started analysis of CASE_J03.R.fq.gz
    ## Approx 5% complete for CASE_J03.R.fq.gz
    ## Approx 10% complete for CASE_J03.R.fq.gz
    ## Approx 15% complete for CASE_J03.R.fq.gz
    ## Approx 20% complete for CASE_J03.R.fq.gz
    ## Approx 25% complete for CASE_J03.R.fq.gz
    ## Approx 30% complete for CASE_J03.R.fq.gz
    ## Approx 35% complete for CASE_J03.R.fq.gz
    ## Approx 40% complete for CASE_J03.R.fq.gz
    ## Approx 45% complete for CASE_J03.R.fq.gz
    ## Approx 50% complete for CASE_J03.R.fq.gz
    ## Approx 55% complete for CASE_J03.R.fq.gz
    ## Approx 60% complete for CASE_J03.R.fq.gz
    ## Approx 65% complete for CASE_J03.R.fq.gz
    ## Approx 70% complete for CASE_J03.R.fq.gz
    ## Approx 75% complete for CASE_J03.R.fq.gz
    ## Approx 80% complete for CASE_J03.R.fq.gz
    ## Approx 85% complete for CASE_J03.R.fq.gz
    ## Approx 90% complete for CASE_J03.R.fq.gz
    ## Approx 95% complete for CASE_J03.R.fq.gz
    ## Approx 100% complete for CASE_J03.R.fq.gz
    ## Analysis complete for CASE_J03.R.fq.gz
    ## WARNING: cut_by_quality5 is deprecated, please use cut_front instead.
    ## Detecting adapter sequence for read1...
    ## No adapter detected for read1
    ## 
    ## Detecting adapter sequence for read2...
    ## No adapter detected for read2
    ## 
    ## Read1 before filtering:
    ## total reads: 100000
    ## total bases: 14200000
    ## Q20 bases: 13547660(95.4061%)
    ## Q30 bases: 12612857(88.8229%)
    ## 
    ## Read1 after filtering:
    ## total reads: 98943
    ## total bases: 12912661
    ## Q20 bases: 12388225(95.9386%)
    ## Q30 bases: 11605394(89.8761%)
    ## 
    ## Read2 before filtering:
    ## total reads: 100000
    ## total bases: 14200000
    ## Q20 bases: 13431086(94.5851%)
    ## Q30 bases: 12488351(87.9461%)
    ## 
    ## Read2 aftering filtering:
    ## total reads: 98943
    ## total bases: 12912540
    ## Q20 bases: 12294591(95.2143%)
    ## Q30 bases: 11510998(89.1459%)
    ## 
    ## Filtering result:
    ## reads passed filter: 197886
    ## reads failed due to low quality: 1924
    ## reads failed due to too many N: 190
    ## reads failed due to too short: 0
    ## reads with adapter trimmed: 68058
    ## bases trimmed due to adapters: 2274483
    ## 
    ## Duplication rate: 5.1806%
    ## 
    ## Insert size peak (evaluated by paired-end reads): 147
    ## 
    ## JSON report: CASE_J03.json
    ## HTML report: CASE_J03.html
    ## 
    ## fastp --in1 CASE_J03.F.fq.gz --in2 CASE_J03.R.fq.gz --out1 CASE_J03.R1.fq.gz --out2 CASE_J03.R2.fq.gz --cut_by_quality5 20 --cut_by_quality3 20 --cut_window_size 5 --cut_mean_quality 15 -q 15 -u 50 -j CASE_J03.json -h CASE_J03.html --detect_adapter_for_pe 
    ## fastp v0.19.7, time used: 13 seconds
    ## WARNING: cut_by_quality5 is deprecated, please use cut_front instead.
    ## Detecting adapter sequence for read1...
    ## Illumina TruSeq Adapter Read 1: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA
    ## 
    ## Detecting adapter sequence for read2...
    ## Illumina TruSeq Adapter Read 2: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
    ## 
    ## Read1 before filtering:
    ## total reads: 100000
    ## total bases: 15000000
    ## Q20 bases: 14229580(94.8639%)
    ## Q30 bases: 13142251(87.615%)
    ## 
    ## Read1 after filtering:
    ## total reads: 98845
    ## total bases: 13843567
    ## Q20 bases: 13213922(95.4517%)
    ## Q30 bases: 12292158(88.7933%)
    ## 
    ## Read2 before filtering:
    ## total reads: 100000
    ## total bases: 15000000
    ## Q20 bases: 13842504(92.2834%)
    ## Q30 bases: 12603463(84.0231%)
    ## 
    ## Read2 aftering filtering:
    ## total reads: 98845
    ## total bases: 13861514
    ## Q20 bases: 12904064(93.0927%)
    ## Q30 bases: 11849090(85.4819%)
    ## 
    ## Filtering result:
    ## reads passed filter: 197690
    ## reads failed due to low quality: 2212
    ## reads failed due to too many N: 92
    ## reads failed due to too short: 6
    ## reads with adapter trimmed: 63595
    ## bases trimmed due to adapters: 1953932
    ## 
    ## Duplication rate: 3.95663%
    ## 
    ## Insert size peak (evaluated by paired-end reads): 157
    ## 
    ## JSON report: Capture1.json
    ## HTML report: Capture1.html
    ## 
    ## fastp --in1 Capture1.F.fq --in2 Capture1.R.fq --out1 Capture1.R1.fq.gz --out2 Capture1.R2.fq.gz --cut_by_quality5 20 --cut_by_quality3 20 --cut_window_size 5 --cut_mean_quality 15 -q 15 -u 50 -j Capture1.json -h Capture1.html --detect_adapter_for_pe 
    ## fastp v0.19.7, time used: 3 seconds
    ## Started analysis of Capture1.R1.fq.gz
    ## Approx 5% complete for Capture1.R1.fq.gz
    ## Approx 10% complete for Capture1.R1.fq.gz
    ## Approx 15% complete for Capture1.R1.fq.gz
    ## Approx 20% complete for Capture1.R1.fq.gz
    ## Approx 25% complete for Capture1.R1.fq.gz
    ## Approx 30% complete for Capture1.R1.fq.gz
    ## Approx 35% complete for Capture1.R1.fq.gz
    ## Approx 40% complete for Capture1.R1.fq.gz
    ## Approx 45% complete for Capture1.R1.fq.gz
    ## Approx 50% complete for Capture1.R1.fq.gz
    ## Approx 55% complete for Capture1.R1.fq.gz
    ## Approx 60% complete for Capture1.R1.fq.gz
    ## Approx 65% complete for Capture1.R1.fq.gz
    ## Approx 70% complete for Capture1.R1.fq.gz
    ## Approx 75% complete for Capture1.R1.fq.gz
    ## Approx 80% complete for Capture1.R1.fq.gz
    ## Approx 85% complete for Capture1.R1.fq.gz
    ## Approx 90% complete for Capture1.R1.fq.gz
    ## Approx 95% complete for Capture1.R1.fq.gz
    ## Analysis complete for Capture1.R1.fq.gz
    ## Started analysis of CASE_J03.R1.fq.gz
    ## Approx 5% complete for CASE_J03.R1.fq.gz
    ## Approx 10% complete for CASE_J03.R1.fq.gz
    ## Approx 15% complete for CASE_J03.R1.fq.gz
    ## Approx 20% complete for CASE_J03.R1.fq.gz
    ## Approx 25% complete for CASE_J03.R1.fq.gz
    ## Approx 30% complete for CASE_J03.R1.fq.gz
    ## Approx 35% complete for CASE_J03.R1.fq.gz
    ## Approx 40% complete for CASE_J03.R1.fq.gz
    ## Approx 45% complete for CASE_J03.R1.fq.gz
    ## Approx 50% complete for CASE_J03.R1.fq.gz
    ## Approx 55% complete for CASE_J03.R1.fq.gz
    ## Approx 60% complete for CASE_J03.R1.fq.gz
    ## Approx 65% complete for CASE_J03.R1.fq.gz
    ## Approx 70% complete for CASE_J03.R1.fq.gz
    ## Approx 75% complete for CASE_J03.R1.fq.gz
    ## Approx 80% complete for CASE_J03.R1.fq.gz
    ## Approx 85% complete for CASE_J03.R1.fq.gz
    ## Approx 90% complete for CASE_J03.R1.fq.gz
    ## Approx 95% complete for CASE_J03.R1.fq.gz
    ## Analysis complete for CASE_J03.R1.fq.gz
    ## Started analysis of Capture1.R2.fq.gz
    ## Approx 5% complete for Capture1.R2.fq.gz
    ## Approx 10% complete for Capture1.R2.fq.gz
    ## Approx 15% complete for Capture1.R2.fq.gz
    ## Approx 20% complete for Capture1.R2.fq.gz
    ## Approx 25% complete for Capture1.R2.fq.gz
    ## Approx 30% complete for Capture1.R2.fq.gz
    ## Approx 35% complete for Capture1.R2.fq.gz
    ## Approx 40% complete for Capture1.R2.fq.gz
    ## Approx 45% complete for Capture1.R2.fq.gz
    ## Approx 50% complete for Capture1.R2.fq.gz
    ## Approx 55% complete for Capture1.R2.fq.gz
    ## Approx 60% complete for Capture1.R2.fq.gz
    ## Approx 65% complete for Capture1.R2.fq.gz
    ## Approx 70% complete for Capture1.R2.fq.gz
    ## Approx 75% complete for Capture1.R2.fq.gz
    ## Approx 80% complete for Capture1.R2.fq.gz
    ## Approx 85% complete for Capture1.R2.fq.gz
    ## Approx 90% complete for Capture1.R2.fq.gz
    ## Approx 95% complete for Capture1.R2.fq.gz
    ## Analysis complete for Capture1.R2.fq.gz
    ## Started analysis of CASE_J03.R2.fq.gz
    ## Approx 5% complete for CASE_J03.R2.fq.gz
    ## Approx 10% complete for CASE_J03.R2.fq.gz
    ## Approx 15% complete for CASE_J03.R2.fq.gz
    ## Approx 20% complete for CASE_J03.R2.fq.gz
    ## Approx 25% complete for CASE_J03.R2.fq.gz
    ## Approx 30% complete for CASE_J03.R2.fq.gz
    ## Approx 35% complete for CASE_J03.R2.fq.gz
    ## Approx 40% complete for CASE_J03.R2.fq.gz
    ## Approx 45% complete for CASE_J03.R2.fq.gz
    ## Approx 50% complete for CASE_J03.R2.fq.gz
    ## Approx 55% complete for CASE_J03.R2.fq.gz
    ## Approx 60% complete for CASE_J03.R2.fq.gz
    ## Approx 65% complete for CASE_J03.R2.fq.gz
    ## Approx 70% complete for CASE_J03.R2.fq.gz
    ## Approx 75% complete for CASE_J03.R2.fq.gz
    ## Approx 80% complete for CASE_J03.R2.fq.gz
    ## Approx 85% complete for CASE_J03.R2.fq.gz
    ## Approx 90% complete for CASE_J03.R2.fq.gz
    ## Approx 95% complete for CASE_J03.R2.fq.gz
    ## Analysis complete for CASE_J03.R2.fq.gz
    ## [INFO   ]         multiqc : This is MultiQC v1.7
    ## [INFO   ]         multiqc : Template    : default
    ## [INFO   ]         multiqc : Searching '.'
    ## [INFO   ]          fastqc : Found 8 reports
    ## [INFO   ]         multiqc : Compressing plot data
    ## [INFO   ]         multiqc : Report      : multiqc_report.html
    ## [INFO   ]         multiqc : Data        : multiqc_data
    ## [INFO   ]         multiqc : MultiQC complete

## Adapter Content
![alt text](https://github.com/jpuritz/BIO_594_2019/blob/master/Exercises/Week04/JonPuritz/exome_capture/AdapterContent.png "Logo Title Text 1")

## Per bp Content
![alt text](https://github.com/jpuritz/BIO_594_2019/blob/master/Exercises/Week04/JonPuritz/exome_capture/BaseContent.png)
