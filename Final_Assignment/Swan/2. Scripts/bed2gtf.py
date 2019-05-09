# -*- coding: utf-8 -*-

# Author: Pedro Furió Tarí
# Data: 30/05/2013
#

# The input should have the following format:
#############################################
# chr1    724805  725050  ...
# chr1    725859  725955  ...

# The output will be named the following way:
# chr1    pfurio     peak     724705  724804   .      +       .      peak_id="chr1_724705_724804"
# chr1    pfurio     peak     724805  725050   .      +       .      peak_id="chr1_724805_725050"
# chr1    pfurio     peak     725051  725150   .      +       .      peak_id="chr1_725051_725150"

import getopt, sys, os.path


def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hi:o:", ["help", "input=","output="])
    except getopt.GetoptError as err:
        print(err) # will print something like "option -a not recognized"
        usage()
        sys.exit(2)
    infile = None
    outfile = None

    for o, a in opts:
        if o in ("-h","--help"):
            usage()
            sys.exit()
        elif o in ("-i", "--input"):
            if os.path.isfile(a):
                infile = a
        elif o in ("-o", "--output"):
            outfile = a
        else:
            assert False, "Unhandled option"

    if infile is not None and outfile is not None:
        run(infile, outfile)
    else:
        usage()


def usage():
    print "\nUsage: python bed2gtf [options] <mandatory>"
    print "Options:"
    print "\t-h, --help:\n\t\t show this help message and exit"
    print "Mandatory:"
    print "\t-i, --input:\n\t\t File with the regions in bed format"
    print "\t-o, --output:\n\t\t Name of the gtf file output file. Directory where the file will be created should exist!"
    print "\n30/05/2013. Pedro Furió Tarí.\n"

def run(infile, outfile):

    inf  = open(infile, 'r')
    outf = open(outfile,'w')

    cont = 1
    for linea in inf:
        linea_split = linea.split()
        chrom = linea_split[0]
        ini_pos = int(linea_split[1])
        fin_pos = int(linea_split[2])
        #peak = linea_split[3]

        #outf.write(chrom + "\tpfurio\tpeak\t" + str(ini_pos) + "\t" + str(fin_pos) + '\t.\t+\t.\tpeak_id "' + peak + '";\n')
        outf.write(chrom + "\tpfurio\tpeak\t" + str(ini_pos) + "\t" + str(fin_pos) + '\t.\t+\t.\tpeak_id "' +
                chrom + "_" + str(ini_pos) + "_" + str(fin_pos) + '";\n')

        cont += 1

    inf.close()
    outf.close()


if __name__ == "__main__":
    main()

