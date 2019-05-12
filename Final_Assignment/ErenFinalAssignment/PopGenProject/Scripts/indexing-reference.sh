[erenada@bluewaves scripts]$ more indexing.sh 
#!/bin/bash
#SBATCH --job-name="indexing"
#SBATCH --time=99:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # processor core(s) per node
#SBATCH --mail-user="erenada@uri.edu"
#SBATCH --mail-type=END,FAIL
#SBATCH --output="out_index"
#SBATCH --error="out_index"
# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
cd $SLURM_SUBMIT_DIR

bwa index GRCh38_latest_genomic.fna
