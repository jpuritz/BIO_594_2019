#!/bin/bash

###BIO 594- Using genomic techniques to examine the evolution of populations ###

###Exercise 1: Understanding advanced UNIX command line programs

###GOALS###

##	1.	Learn to use the commands: head, tail,cat, cut, paste, wc, less

##	2.	Learn the power of the AWK programming language 

##	3.	Use AWK to subsample a file

###########

##	This file is executable.  Simply type Linux.Ex [Step_Number] to skip to different steps without opening the whole file.
##	Instead of [Step_Number], the commands [next], [last], and [prev] can also be used to navigate
## 	Command lines start with a "$"



#1 Let's get started.  First let's create a working directory.


#c#1	$mkdir D1W


#2 Let's change into that directory


#c#2	$cd D1W


#3 Let's copy some data to work with from the COURSE_DATA folder


#c#3	$cp /home/BIO594/Exercises/Week_2/out.idepth /home/BIO594/Exercises/Week_2/cov.stats .


#4 You can check to make sure the files are there with the command "ls"


#c#4	$ls


#4 You should see


#4 cov.stats  out.idepth


#5 The first command that we will learn to use is the command "head"

#5 By default "head" prints out the first 10 lines of a file

#5 Let's try with the out.idepth file.


#c#5	$head out.idepth


#5 You should see

#5 INDV    N_SITES MEAN_DEPTH

#5 PopA_01 8343    19.7475

#5 PopA_02 8481    19.8769

#5 PopA_03 8453    20.2284

#5 PopA_04 8591    19.4391

#5 PopA_05 8448    20.4425

#5 PopA_06 8242    19.9695

#5 PopA_07 8362    20.069

#5 PopA_08 8454    20.1047

#5 PopA_09 8341    20.2223


#6 You can also control the number of lines "head" outputs by inputing a number


#c#6	$head -3 out.idepth


#6 You should see

#6

#6 INDV    N_SITES MEAN_DEPTH

#6 PopA_01 8533    19.7475

#6 PopA_02 8681    19.8769


#6 Here, the -3 parameter is telling head to only print the first three lines


#7 To find out more about head, you can read the manual


#c#7	$man head


#8 A similar command is called "tail"

#8 By default, "tail" prints out the last 10 lines of a file


#c#8	$tail out.idepth


#8 You should see

#8

#8 PopB_11	8382	19.8635

#8 PopB_12	8419	19.9222

#8 PopB_13	8302	19.512

#8 PopB_14	8370	20.2419

#8 PopB_15	8302	19.4478

#8 PopB_16	8457	19.4999

#8 PopB_17	8468	19.5711

#8 PopB_18	8350	19.2867

#8 PopB_19	8344	19.4911

#8 PopB_20	8309	19.6092


#9 tail can also print out a set number of lines like head using a dash and a number


#c#9	tail -2 out.idepth


#9 PopB_11	8382	19.8635

#9 PopB_12	8419	19.9222


#10 The entire file can be printed out with the command "cat"

#10 This is short for the word concatenate, which means to link things together 

#10 You can use it to string two files together, but when only given one file, it prints the whole file to the screen


#c#10 	$cat out.idepth


#10 INDV    N_SITES MEAN_DEPTH

#10 PopA_01	8343	19.7475

#10 PopA_02	8481	19.8769

#10 PopA_03	8453	20.2284

#10 PopA_04	8591	19.4391

#10 PopA_05	8448	20.4425

#10 PopA_06	8242	19.9695

#10 PopA_07	8362	20.069

#10 PopA_08	8454	20.1047

#10 PopA_09	8341	20.2223

#10 PopA_10	8431	19.8415

#10 PopA_11	8393	19.9734

#10 PopA_12	8255	19.8267

#10 PopA_13	8408	20.6407

#10 PopA_14	8361	19.704

#10 PopA_15	8354	19.7558

#10 PopA_16	8284	19.8937

#10 PopA_17	8243	20.0626

#10 PopA_18	8428	19.7718

#10 PopA_19	8365	19.5988

#10 PopA_20	8342	20.1082

#10 PopB_01	8350	20.0589

#10 PopB_02	8398	19.3328

#10 PopB_03	8322	20.0357

#10 PopB_04	8479	19.4696

#10 PopB_05	8273	19.3201

#10 PopB_06	8379	19.6667

#10 PopB_07	8392	20.2092

#10 PopB_08	8382	20.2733

#10 PopB_09	8262	20.2642

#10 PopB_10	8464	19.972

#10 PopB_11	8382	19.8635

#10 PopB_12	8419	19.9222

#10 PopB_13	8302	19.512

#10 PopB_14	8370	20.2419

#10 PopB_15	8302	19.4478

#10 PopB_16	8457	19.4999

#10 PopB_17	8468	19.5711

#10 PopB_18	8350	19.2867

#10 PopB_19	8344	19.4911

#10 PopB_20	8309	19.6092


#10 Now you can see all lines of the file


#11 How could we use head, tail, and cat to create a single file that is only the first and last line of out.idepth?

#11 Simply put, we can used head to create a file for the first line, tail to create a file with the last line, and cat to link them together


#c#11	$head -1 out.idepth > firstline

#c#11	$tail -1 out.idepth > lastline

#c#11	$cat firstline lastline


#11 Your output should be

#11 INDV    N_SITES MEAN_DEPTH

#11	PopB_20 8309	19.6092


#12 head, tail, and cat sample and manipulate text files by line, but you can also manipulate text files by column.  

#12 The command "cut" will sample columns by number

#12	For example


#c#12	head -3 out.idepth | cut -f1 


#12 Gives you the first column of the first three lines

#12 INDV

#12 PopA_01

#12 PopA_02


#13 You can use cut to sample more than one column and the do not have to be sequential

#13 Compare the outputs of these three commands


#c#13	$head -3 out.idepth | cut -f1-3

#c#13	$head -3 out.idepth | cut -f1,2

#c#13	$head -3 out.idepth | cut -f1,3


#13 You can see that the first command prints all three columns.  The second prints column 1 and column 2.  The third prints column 1 and column 3.


#14 In contrast, the command paste will take two files and paste them into separate columns of one file.

#14	For example, we can create a file of only columns 1 and 3 from out.idepth as follows


#c#14	$cut -f1 out.idepth > c1

#c#14	$cut -f3 out.idepth > c2

#c#14	$paste c1 c2 | head -5


#14 You should see

#14

#14 INDV    MEAN_DEPTH

#14 PopA_01 19.7475

#14 PopA_02 19.8769

#14 PopA_03 20.2284

#14 PopA_04 19.4391


#15 Another handy tool is "wc"

#15	wc is short for word count, and that is exactly what this tool does.  It counts lines, words, and bytes of a file


#c#15	$wc out.idepth


#15 The output is

#15	41 123 860 out.idepth


#15 This states that the file out.idepth has 41 lines, 123 words, and 862 bytes


#16 Usually, wc is most useful for counting lines, and you can restrict the output to lines only with the "-l" parameter


#c#16	$wc -l out.idepth


#16	41 out.idepth


#17	Additionally, you can remove the file from output by piping in the text file instead of entering it as input


#c#17	$cat out.idepth | wc -l


#17 41


#17 See that, a quick and easy way to get the number of lines in a file


#18 You have already been exposed to the tool "grep" in this course.  It's very useful for searching through text files.

#18	Another tool that does this is called "awk"

#18	In fact, AWK is actually it's own programming language.  It's old but it can be incredibly useful for parsing text files.

#18

#18 For example, awk can quickly match patterns with a regular expression, just like grep.

#18 If I want to match all the lines that have "PopA_01" in out.idepth, here's the command:


#c#18	$awk '/PopA_01/' out.idepth


#18 The output is

#18 PopA_01	8343	19.7475


#18 The format of the command is to put the regular expression (search term) within single quotes and forward slashes


#19 The awk command also recognizes columns in your data

#19 It marks columns by using a $

#19

#19 This can be very useful for sorting and manipulating data

#19 I can use awk to find samples in the file out.idepth that have a Mean_Depth greater than 20.


#c#19	$awk '$3 > 20' out.idepth


#19 The output should look like


#19 INDV	N_SITES	MEAN_DEP

#19 PopA_03	8453	20.2284

#19 PopA_05	8448	20.4425

#19 PopA_07	8362	20.069

#19 PopA_08	8454	20.1047

#19 PopA_09	8341	20.2223

#19 PopA_13	8408	20.6407

#19 PopA_17	8243	20.0626

#19 PopA_20	8342	20.1082

#19 PopB_01	8350	20.0589

#19 PopB_03	8322	20.0357

#19 PopB_07	8392	20.2092

#19 PopB_08	8382	20.2733

#19 PopB_09	8262	20.2642

#19 PopB_14	8370	20.2419

#19

#19 You'll notice that this also printed the first line of the file with

#19 the column names.  This is because column three on that line is not an number, so it is still printed


#20 Awk can also find exact matches.  Say you want to find the sample with exactly a mean depth of 20.1392


#c#20	$awk '$3 == 20.0589' out.idepth


#20 That outputs:

#20 PopB_01	8350	20.0589


#21 AWK is an incredibly powerful language.  It understands basic math and you can use it to find basic summary statistics of a file

#21	We can use awk to calculate the sum of one of the data columns.  Let's do the N_SITES column.


#c#21	$awk '{sum=sum+$2} END {print sum}' out.idepth


#21 This outputs:

#21 334983

#21

#21 Note how in the line of code that the $2 is directing awk to look only at column 2, the N_SITES column.


#22 We can also use awk to calculate the average of one of the data columns. We do this by dividing the sum by the number of observations.

#22 AWK automatically keeps track of the number of lines in a file that it process using the NR variable.

#22 We can alter our command from above to easily calculate the average


#c#22	$awk '{sum=sum+$2} END {print sum/NR}' out.idepth


#22 This outputs:

#22 8170.32


#23 There's one more simple tool I'd like to introduce you to, called gzip.
#23 gzip is a utility to compress files, saving space on your hard drive.
#23 To compress any file, simply type "gzip file name"
#23 The original file name will be appended by a .gz

#23
#23 Let's try an example

#c#23	$gzip out.idepth

#23 Note that the terminal doesn't output anything.  It will only output errors
#23 Running the "ls" command shows what changed.

#c#23	$ls out*

#23 The file is now named out.idepth.gz and is compressed.

#24 While files are compressed they cannot be read directly by UNIX tools

#c#24	$head -1 out.idepth.gz

#24 The output is garbage because the file was compressed.

#24 #Vout.idepth=?9?0
#24                 E?p?K??P
#24                         BM?f?_M?????????/???~?^?g?????????:<~?N?M??'?Yp4???\??~Dڌ??

#24 To use them with UNIX tools you can utilize the tool zcat
#24 zcat is just like cat except that it works on gzipped files

#c#24	$zcat out.idepth.gz | head -2

#24 This outputs:
#24 INDV	N_SITES	MEAN_DEPTH
#24 PopA_01	8343	19.7475

#25 To permanently uncompress a file, use the tool gunzip

#c#25	$gunzip out.idepth.gz
#c#25	$ls out*

#25 Now the file is backed to its uncompressed original form
#25 out.idepth


#26 Congratulations you have finished this exercise!!!!

#26

#26 I highly recommend that you take the time to learn more about AWK!

#26 Please take a look at these websites as references:

#26 http://www.thegeekstuff.com/2010/01/awk-introduction-tutorial-7-awk-print-examples/

#26 http://www.grymoire.com/Unix/Awk.html


#!/bin/bash
if which Linux.Ex &>/dev/null; then
    LOC=$(which Linux.Ex 2>/dev/null)
else
	LOC="./Linux.Ex"
fi
DIR=(`echo $LOC | sed 's/Linux.Ex//g' `)
if [[ -z "$1" ]]; then
head -20 $LOC
echo "0" > $HOME/linux.ex.last
else
	if [ "$1" == "last" ]; then
	LAST=(`cat $HOME/linux.ex.last `)
	PATTERN=#$LAST[[:blank:]]
	PATTERN2=#c#$LAST
	PATTERN4=^$LAST
	grep $PATTERN $LOC | sed 's/'$PATTERN2'\t/ /g' | sed 's/#'$LAST'\s/ /g'
	echo $LAST > $HOME/linux.ex.last
	elif [ "$1" == "next" ]; then
        LAST=(`cat $HOME/linux.ex.last `)
	LAST=$(($LAST +1))
        PATTERN=#$LAST[[:blank:]]
        PATTERN2=#c#$LAST
        PATTERN4=^$LAST
        grep $PATTERN $LOC | sed 's/'$PATTERN2'\t/ /g' | sed 's/#'$LAST'\s/ /g'
        echo $LAST > $HOME/linux.ex.last
	elif [ "$1" == "prev" ]; then
        LAST=(`cat $HOME/linux.ex.last `)
        LAST=$(($LAST - 1))
        PATTERN=#$LAST[[:blank:]]
        PATTERN2=#c#$LAST
        PATTERN4=^$LAST
        grep $PATTERN $LOC | sed 's/'$PATTERN2'\t/ /g' | sed 's/#'$LAST'\s/ /g'
        echo $LAST > $HOME/linux.ex.last
	else
	PATTERN=#$1[[:blank:]]
	PATTERN2=#c#$1
	PATTERN4=^$1
	grep $PATTERN $LOC | sed 's/'$PATTERN2'\t/ /g' | sed 's/#'$1'\s/ /g'	
	echo $1 > $HOME/linux.ex.last
	fi
fi
