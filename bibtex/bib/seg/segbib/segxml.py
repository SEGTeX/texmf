#!/usr/bin/env python

from elementtree.ElementTree import ElementTree
import glob, sys, re

out = open('SEG2008.bib','w')

is_article = re.compile(r'(CAN|GEO|EGJ|EGK|PRE|FBR|GPR|TLE|REC)')

for xml in glob.glob('DCI_Archive/*.xml')[:10]:
    print xml
    tree = ElementTree(file=xml)
    field = {}
    fpage = None
    lpage = None
    authors = []
    group = ''
    for elem in tree.getroot():
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
                elif subelem.tag=='group':
                    group = subelem.text
                elif subelem.tag=='date':
                    pass
                else:
                    print ': ', subelem.tag, '=> ', subelem.text
            elif elem.tag=='body':
                if subelem.tag=='title':
                    field['title'] = subelem.text
                elif subelem.tag=='cpyrt':
                    for subsubelem in subelem:
                        if subsubelem.tag=='cpydate':
                            field['year'] = subsubelem.text
                elif subelem.tag=='authgrp':
                    for author in subelem:
                        name = ['','']
                        for subsubelem in author:
                            if subsubelem.tag=='fname':
                                name[0] = subsubelem.text
                            elif subsubelem.tag=='surname':
                                name[1] = subsubelem.text
                        authors.append(' '.join(name))
                    field['author'] = ' '.join(authors)
                else:
                    print ': ', subelem.tag, '=> ', subelem.text
                    
                    for subsubelem in subelem:
                        print ':: ', subsubelem.tag, '=> ', subsubelem.text
                        for subsubsubelem in subsubelem:
                            print '::: ', subsubsubelem.tag, \
                                '=> ', subsubsubelem.text

    # determine pages
    if fpage and lpage:
        if fpage == lpage:
            field['pages'] = fpage
        else:
            field['pages'] = '-'.join([fpage,lpage])

    # determine type
    if is_article.match(group):
        type = 'article'
    elif fpage != lpage: # or title.lower() != booktitle.lower():
        type = 'incollection'
        field['booktitle'] = field['journal']
        del field['journal']
    else:
        type = 'book'
        del field['journal']

    out.write('\n@%s{%s,\n' % (type,key))
    for key in field.keys():
        out.write('\t%s = {%s},\n' % (key,field[key]))
    out.write('}\n')

out.close()
sys.exit(0)

    
