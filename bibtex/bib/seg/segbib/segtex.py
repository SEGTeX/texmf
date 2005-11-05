#!/usr/bin/env python
import sys, re

limits = tuple(map(int,sys.argv[1].split('-')))

print r'''\documentclass{article}
\usepackage{natbib}
\usepackage{times}

\title{Testing SEG bibliography from %s to %s}
\author{Sergey Fomel}

\begin{document}
\maketitle
''' % limits

bib = open("SEG2005.bib","r")
key = re.compile(r'^\s*\@[^\{]+{([^\,]+)\,')
count = 0
for line in bib:
    match = key.search(line)
    if match:
        count += 1
        if (count > limits[1]):
            break
        if (count < limits[0]):
            continue
        print r'\nocite{%s}' % match.group(1)
bib.close()

print r'''
\bibliographystyle{seglike}
\bibliography{SEG2005}
\end{document}'''




