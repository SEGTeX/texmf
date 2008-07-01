#!/usr/bin/env python

from elementtree.ElementTree import ElementTree
import glob, sys

out = open('SEG2008.bib','w')

#for xml in glob.glob('DCI_Archive/*.xml'):
for xml in ('DCI_Archive/EAE_2006_F002.xml',):
    tree = ElementTree(file=xml)
    bibtex = {}
    for elem in tree.getroot():
        print elem.tag, ' => ', elem.text
        for subelem in elem:
            print ': ', subelem.tag, '=> ', subelem.text
            if elem.tag=='front' and subelem.tag=='docid':
                bibtex['docid'] = '-'.join(subelem.text.split())
            for subsubelem in subelem:
                print ':: ', subsubelem.tag, '=> ', subsubelem.text
                for subsubsubelem in subsubelem:
                    print '::: ', subsubsubelem.tag, '=> ', subsubsubelem.text

    out.write('''
@inproceedings{%(docid)s,
\tauthor = {C[] N[] G[] Dampney},
\tbooktitle = {Two dimensional regional gravity investigations},
\teditor = {D[] A[] Falvey},
\tkeywords = {Murray Basin},
\tnote = {Discussion on p. 154},
\tnumber = {04},
\tpages = {99-102},
\tpublisher = {Austr. Soc. Expl. Geophys.},
\ttitle = {Gravity interpretation over sedimentary basins - {I}ngenuous or ingenious methodology? },
\tvolume = {08},
\tyear = {1977}
}''' % bibtex)

out.close()
sys.exit(0)

    
