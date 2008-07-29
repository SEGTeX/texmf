#!/usr/bin/env python

from elementtree.ElementTree import ElementTree
import glob, sys, re

is_article = re.compile(r'(CAN|GEO|EGJ|EGK|PRE|FBR|GPR|TLE|REC)')

needs_braces = re.compile(r'.*[A-Z]')
special_character = re.compile(r'([\&\#\$\_])')
math_mode = re.compile(r'([\w\d]+\^[\w\d]+)')
dash = re.compile(u'\xfb')

def fix_title(string):
    words = string.split()
    title = words.pop(0)
    if needs_braces.match(title,1):
        title = "{%s}" % title
        title = special_character.sub(r'\\\1',title) # escape for latex
    for word in words:
        if needs_braces.match(word):
            word = "{%s}" % word
        word = special_character.sub(r'\\\1',word) # escape for latex
        word = dash.sub('--',word)
        word = math_mode.sub(r'$\1$',word) # T^2 is math mode 
        title += ' ' + word
    return title

accents = {
    u'\xb0': '\\O',
    }

def fix_author(string):
    for a in accents.keys():
        string = re.sub(a,accents[a],string)
    return string

def fix_publisher(string):
    string = special_character.sub(r'\\\1',string) # escape for latex

out = open('SEG2008.bib','a')

book = {
    'SSS': 'Seismic source signature estimation and measurement',
    }

for xml in glob.glob('DCI_Archive/*.xml')[:100]:
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
                    field['title'] = fix_title(subelem.text)
                elif subelem.tag=='cpyrt':
                    for subsubelem in subelem:
                        if subsubelem.tag=='cpydate':
                            field['year'] = subsubelem.text
                        elif subsubelem.tag=='cpyrtnme':
                            for subsubsubelem in subsubelem:
                                if subsubsubelem.tag=='orgname':
                                    field['publisher'] = fix_publisher(subsubsubelem.text)
                elif subelem.tag=='authgrp':
                    for author in subelem:
                        name = ['','']
                        for subsubelem in author:
                            if subsubelem.tag=='fname':
                                if subsubelem.text:
                                    name[0] = subsubelem.text                                
                            elif subsubelem.tag=='surname':
                                if subsubelem.text:
                                    name[1] = fix_author(subsubelem.text)
                                else:
                                    name = None
                        if name:
                            authors.append(' '.join(name))
                    field['author'] = ' and '.join(authors)
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
    elif field['journal'] == 'SEG Books':
        if fpage == lpage:
            type = 'book'
        else:
            type = 'incollection'
            field['booktitle'] = book.get(key[:3])
        del field['journal']
    else:
        type = 'inproceedings'
        field['booktitle'] = field['journal']
        del field['journal']

    out.write('\n@%s{%s,\n' % (type,key))
    for key in field.keys():
        if field[key]:
            out.write('\t%s = {%s},\n' % (key,field[key]))
    out.write('}\n')

out.close()
sys.exit(0)

    
