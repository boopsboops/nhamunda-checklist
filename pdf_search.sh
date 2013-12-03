#!/bin/sh
#greps text from pdf without writing to file
pdftotext CLOFFSCA.pdf - | grep 'Nhamund'
pdftotext ferraris2007_coc.pdf - | grep 'Nhamund'
