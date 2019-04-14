## Real dataset

### 1. Initialize working environment
```
conda activate Week9.Ex
less BSsnp.spid

#convert file type
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.recode.vcf -outputfile SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL -spid BSsnp.spid
```

### 2. Run BayeScan2
```
BayeScan2.1_linux64bits SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL -nbp 30 -thin 20
```

### 3. Run BayEnv
```
#to retrieve total number of unique population

cut -f2 popmap > totalpop
cat totalpop | uniq -c > uniq.pop

#convert file type for BayEnv
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.recode.vcf -outputfile SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.BayEnv -spid SNPBayEnv.spid

bayenv2 -i SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.BayEnv -p 16 -k 100000 -r 63479 > matrix.out

#This code generates 100,000 iterations. We only need the last one.

tail -5 matrix.out | head -4 > matrix

cat environ

#retrieve script for Bayes Factor calculation

ln -s /usr/local/bin/bayenv2 ./bayenv2

#Next, we calculate the Bayes Factor for each SNP for each environmental variable:

calc_bf.sh SNP.TRSdp5p05FHWEBayEnv.txt environ matrix 4 10000 2

#Convert the output into something suitable to input into R
paste <(seq 1 981) <(cut -f2,3 bf_environ.environ ) > bayenv.out

cat <(echo -e "Locus\tBF1\tBF2") bayenv.out > bayenv.final
```

### 4. PCA and DAPC using outlier free dataset
> R markdown

### 5. Analyses from Silliman et al
> R markdown
