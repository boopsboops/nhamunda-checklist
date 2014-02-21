#!/bin/sh
#greps text from pdf without writing to file
pdftotext CLOFFSCA.pdf - | grep 'Nhamund'
pdftotext ferraris2007_coc.pdf - | grep 'Nhamund'
#to search multiple files
find /home/rupert/Journals_OLD/ichthyology_papers -name '*.pdf' -exec sh -c 'pdftotext -q "{}" - | grep --with-filename --label="{}" --color "Nhamund"' \;