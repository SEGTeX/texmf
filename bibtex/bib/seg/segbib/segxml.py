#!/usr/bin/env python

from elementtree.ElementTree import ElementTree
import glob, sys

out = open('SEG2008.bib','w')

#for xml in glob.glob('DCI_Archive/*.xml'):
for xml in ('DCI_Archive/GPR10_02_01660170.xml',):
    tree = ElementTree(file=xml)
    field = {}
    fpage = None
    lpage = None
    type = 'inproceedings'
    for elem in tree.getroot():
        print elem.tag, ' => ', elem.text
        for subelem in elem:
            if elem.tag=='front':
                if subelem.tag=='docid':
                    key = '-'.join(subelem.text.split())
                elif subelem.tag=='volume':
                    field['volume']=subelem.text
                elif subelem.tag=='fpage':
                    fpage = subelem.text
                elif subelem.tag=='lpage':
                    lpage = subelem.text
                elif subelem.tag=='spin-journal':
                    field['journal'] = subelem.text
                    type = 'article'
                elif subelem.tag=='issno':
                    field['number'] = subelem.text
                else:
                    print ': ', subelem.tag, '=> ', subelem.text
            elif elem.tag=='body':
                if subelem.tag=='title':
                    field['title'] = subelem.text
                elif subelem.tag=='cpyrt':
                    for subsubelem in subelem:
                        if subsubelem.tag=='cpydate':
                            field['year'] = subsubelem.text
                else:
                    print ': ', subelem.tag, '=> ', subelem.text
                    
                    for subsubelem in subelem:
                        print ':: ', subsubelem.tag, '=> ', subsubelem.text
                        for subsubsubelem in subsubelem:
                            print '::: ', subsubsubelem.tag, '=> ', subsubsubelem.text

    if fpage and lpage:
        if fpage == lpage:
            field['pages'] = fpage
        else:
            field['pages'] = '-'.join([fpage,lpage])

    out.write('\n@%s{%s,\n' % (type,key))
    for key in field.keys():
        out.write('\t%s = {%s},\n' % (key,field[key]))
    out.write('}\n')

#@article{GPR10-02-01660170,
#   author = {R[] Green},
#   journal = {Geophys. Prosp.},
#   note = {Discussion in GPR-10-04-0548-0548},
#   number = {02},
#   pages = {166-170},
#   publisher = {Eur. Assn. Geosci. Eng.},
#   title = {The hidden layer problem },
#   volume = {10},
#   year = {1962}}
   
out.close()
sys.exit(0)

    
