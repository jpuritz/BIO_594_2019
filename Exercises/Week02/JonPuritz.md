1.  `cat /home/BIO594/Exercises/sneaky`

2.  `awk 'print $3' /home/BIO594/Exercises/Week_2/out.idepth | head -5`

3.  `awk 'NR==19' /home/BIO594/Exercises/Week_2/out.idepth`

4.  `awk '$3 > 20.1' /home/BIO594/Exercises/Week_2/out.idepth | wc -l`

5.  `awk '$3 > 20.1 && $3 < 20.25' /home/BIO594/Exercises/Week_2/out.idepth | wc -l`

6.  `awk '{ sum = sum + $3 } END { print sum/NR}' /home/BIO594/Exercises/Week_2/out.idepth`	
