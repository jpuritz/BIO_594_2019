```
conda activate Week9.Ex
less BSsnp.spid

#convert file type
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.recode.vcf -outputfile SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL -spid BSsnp.spid
```

Run BayeScan2
```
BayeScan2.1_linux64bits SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL -nbp 30 -thin 20
```

Run BayEnv
```
cut -f2 popmap > totalpop
cat totalpop | uniq -c > uniq.pop
#convert file type for BayEnv
java -jar /usr/local/bin/PGDSpider2-cli.jar -inputfile SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.recode.vcf -outputfile SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.BayEnv -spid SNPBayEnv.spid
bayenv2 -i SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.BayEnv -p 16 -k 100000 -r 63479 > matrix.out
bayenv2 -i SNP.DP3g98maf01_85INDoutFIL.NO2a.HWE.FIL.BayEnv -m matrix.out -e environ -p 16 -k 100000 -n 5 -t -r 429
```
