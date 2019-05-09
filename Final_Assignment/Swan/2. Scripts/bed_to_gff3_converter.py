#!/usr/bin/env python
"""
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

Written (W) 2010-2012 Vipin T Sreedharan
Copyright (C) 2010-2012 Friedrich Miescher Laboratory of the Max Planck Society

Description : Convert data in 12 column Browser Extensible Data (BED) format file to Generic Feature Format Version 3 (GFF3).
"""
import re, sys
from optparse import OptionParser

def stop_err(fmsg):
    """Error message 
    """
    sys.stderr.write('%s\n' % fmsg)
    sys.exit(-1)

def __main__():
    cmd_arg = OptionParser()
    cmd_arg.add_option('', '-q', dest='query_file', help='Data in 12 column BED format file')
    cmd_arg.add_option('', '-o', dest='result_file', help='GFF3 file name')
    cmd_arg.add_option('', '-s', dest='source_name', help='GFF3 source name, 2nd column (default:fml_bed2gff)')
    options, args = cmd_arg.parse_args()
    if options.source_name == None:
        options.source_name = 'fml_bed2gff'
    if len(sys.argv) < 2:
        cmd_arg.print_help()
        sys.exit(-1)
    if options.query_file != None and options.result_file != None: 
        try:
            bed_fh = open(options.query_file, 'rU')
        except Exception, erm:
            stop_err('Error reading query file ' + str(erm))
        try:
            gff_fh = open(options.result_file, 'w')
        except Exception, erm:
            stop_err('Error writing result file ' + str(erm))
        gff_fh.write('##gff-version 3\n')
        for line in bed_fh:
            line = line.strip( '\n\r' ).split( '\t' )
            if not line or re.match('#', line[0]):
                continue
            if '' in line:
                continue
            assert len(line) >= 12, '\t'.join(line) 
            if len(line[-1].split(',')) != len(line[-2].split(',')):
                continue # checking the consistency b/w relative start of exon and number of exons
            rstart = line[-1].split(',')
            if rstart[-1] == '': 
                rstart.pop()
            exon_len = line[-2].split(',')
            if exon_len[-1] == '': 
                exon_len.pop()
            if line[5] != '+' and line[5] != '-':
                line[5] = '.' # replace the unknown strand with '.' 
            pline = [str(line[0]),
                    options.source_name,
                    'gene',
                    str(int(line[1]) + 1),
                    line[2],
                    line[4],
                    line[5],
                    '.',
                    'ID=Gene:' + line[3] + ';Name=Gene:' + line[3]]
            gff_fh.write('\t'.join(pline) + '\n')
            pline = [str(line[0]),
                    options.source_name,
                    'transcript',
                    str(int(line[1]) + 1),
                    line[2],
                    line[4],
                    line[5],
                    '.',
                    'ID=' + line[3] + ';Name=' + line[3] + ';Parent=Gene:' + line[3]]
            gff_fh.write('\t'.join(pline) + '\n')
            st = int(line[1])
            for ex_cnt in range(int(line[-3])):
                start = st + int(rstart[ex_cnt]) + 1
                stop = start + int(exon_len[ex_cnt]) - 1
                pline = [str(line[0]),
                        options.source_name,
                        'exon',
                        str(start),
                        str(stop),
                        line[4],
                        line[5],
                        '.',
                        'Parent=' + line[3]]
                gff_fh.write('\t'.join(pline) + '\n')
        bed_fh.close()
        gff_fh.close()

if __name__ == "__main__": __main__()
