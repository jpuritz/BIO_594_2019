[erenada@bluewaves scripts]$ more eas-trim.sh 
#!/bin/bash
#SBATCH --job-name="fastp-EAS"
#SBATCH --time=999:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu"
#SBATCH --mail-type=END,FAIL
#SBATCH --output="out_fastp-EAS"
#SBATCH --error="out_fastp-EAS"
# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

cd /data3/schwartzlab/eren/humandata/newfull

fastp -w 16 -h AMR01.html -i AMR01.RawLeft.fastq.gz  -I AMR01.RawRight.fastq.gz -o TrimmedReads/AMR01.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/AMR01.Right.fq.gz

fastp -w 16 -h AMR02.html -i AMR02.RawLeft.fastq.gz  -I AMR02.RawRight.fastq.gz -o TrimmedReads/AMR02.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/AMR02.Right.fq.gz

fastp -w 16 -h AMR03.html -i AMR03.RawLeft.fastq.gz  -I AMR03.RawRight.fastq.gz -o TrimmedReads/AMR03.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/AMR03.Right.fq.gz

fastp -w 16 -h AMR04.html -i AMR04.RawLeft.fastq.gz  -I AMR04.RawRight.fastq.gz -o TrimmedReads/AMR04.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/AMR04.Right.fq.gz

fastp -w 16 -h AMR05.html -i AMR05.RawLeft.fastq.gz  -I AMR05.RawRight.fastq.gz -o TrimmedReads/AMR05.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/AMR05.Right.fq.gz

fastp -w 16 -h EAS01.html -i EAS01.RawLeft.fastq.gz  -I EAS01.RawRight.fastq.gz -o TrimmedReads/EAS01.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/EAS01.Right.fq.gz

fastp -w 16 -h EAS02.html -i EAS02.RawLeft.fastq.gz  -I EAS02.RawRight.fastq.gz -o TrimmedReads/EAS02.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/EAS02.Right.fq.gz

fastp -w 16 -h EAS03.html -i EAS03.RawLeft.fastq.gz  -I EAS03.RawRight.fastq.gz -o TrimmedReads/EAS03.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/EAS03.Right.fq.gz

fastp -w 16 -h EAS04.html -i EAS04.RawLeft.fastq.gz  -I EAS04.RawRight.fastq.gz -o TrimmedReads/EAS04.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/EAS04.Right.fq.gz

fastp -w 16 -h EAS05.html -i EAS05.RawLeft.fastq.gz  -I EAS05.RawRight.fastq.gz -o TrimmedReads/EAS05.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/EAS05.Right.fq.gz

fastp -w 16 -h SOA01.html -i SOA01.RawLeft.fastq.gz  -I SOA01.RawRight.fastq.gz -o TrimmedReads/SOA01.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/SOA01.Right.fq.gz

fastp -w 16 -h SOA02.html -i SOA02.RawLeft.fastq.gz  -I SOA02.RawRight.fastq.gz -o TrimmedReads/SOA02.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/SOA02.Right.fq.gz

fastp -w 16 -h SOA03.html -i SOA03.RawLeft.fastq.gz  -I SOA03.RawRight.fastq.gz -o TrimmedReads/SOA03.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/SOA03.Right.fq.gz

fastp -w 16 -h SOA04.html -i SOA04.RawLeft.fastq.gz  -I SOA04.RawRight.fastq.gz -o TrimmedReads/SOA04.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/SOA04.Right.fq.gz

fastp -w 16 -h SOA05.html -i SOA05.RawLeft.fastq.gz  -I SOA05.RawRight.fastq.gz -o TrimmedReads/SOA05.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/SOA05.Right.fq.gz

fastp -w 16 -h eur01.html -i EUR01.RawLeft.fastq.gz  -I EUR01.RawRight.fastq.gz -o TrimmedReads/EUR01.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/EUR01.Right.fq.gz

fastp -w 16 -h eur02.html -i EUR02.RawLeft.fastq.gz  -I EUR02.RawRight.fastq.gz -o TrimmedReads/EUR02.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/EUR02.Right.fq.gz

fastp -w 16 -h eur03.html -i EUR03.RawLeft.fastq.gz  -I EUR03.RawRight.fastq.gz -o TrimmedReads/EUR03.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/EUR03.Right.fq.gz

fastp -w 16 -h eur04.html -i EUR04.RawLeft.fastq.gz  -I EUR04.RawRight.fastq.gz -o TrimmedReads/EUR04.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/EUR04.Right.fq.gz

fastp -w 16 -h eur05.html -i EUR05.RawLeft.fastq.gz  -I EUR05.RawRight.fastq.gz -o TrimmedReads/EUR05.Left
.fq.gz -O /data3/schwartzlab/eren/humandata/newfull/TrimmedReads/EUR05.Right.fq.gz

