#!/usr/bin/env python

from elementtree.ElementTree import ElementTree
import glob, sys, re

is_article = re.compile(r'(CAN|GEO|EGJ|EGK|PRE|FBR|GPR|TLE|REC)')

needs_braces = re.compile(r'.*[A-Z]')
special_character = re.compile(r'([\&\#\$\_])')
math_mode = re.compile(r'([\w\d]+\^[\w\d]+)')

accents = {
    u'\xb0': '{\\O}',
    u'\xb5': '\\ae',
    u'\xfb': '--',
    u'\xc6': '\'',
    u'\xf4': '``',
    u'\xf6': '\'\'',
    u'\xe0': ' ',
    u'\xf7': '\\"{o}',
    u'\xab': '--',
    u'\xb2': '\\\'{y}',
    u'\xdf': '\\\'{a}',
    u'\xdc': '\\u{s}'
    }

def fix_special(string):
    for a in accents.keys():
        string = re.sub(a,accents[a],string)
    return string

def fix_title(string):
    string = fix_special(string)
    words = string.split()
    title = words.pop(0)
    if needs_braces.match(title,1):
        title = "{%s}" % title
        title = special_character.sub(r'\\\1',title) # escape for latex
    for word in words:
        if needs_braces.match(word):
            word = "{%s}" % word
        word = special_character.sub(r'\\\1',word) # escape for latex
        word = math_mode.sub(r'$\1$',word) # T^2 is math mode 
        title += ' ' + word
    return title

def fix_publisher(string):
    string = special_character.sub(r'\\\1',string) # escape for latex
    return string

out = open('SEG2008.bib','a')

book = {
    'SSS': 'Seismic source signature estimation and measurement',
    'ASA': 'Applied seismic anisotropy: theory, background, and field studies',
    'SW2': '2nd Southwest. Pacific Workshop-Symp., Papers and Summaries',
    'MSD': 'Migration of seismic data',
    'MAT': 'Multiple attenuation',
    'SAA': 'Seismic and acoustic velocities in reservoir rocks',
    'EM2': 'Electromagnetic methods in applied geophysics',
    'MTM': 'Magnetotelluric methods'
    }

for xml in glob.glob('DCI_Archive/*.xml'):
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
                                    name[1] = fix_special(subsubelem.text)
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

    # add issue
    if group[:3] == 'GEO': 
        number = field.get('number')
        year = field.get('year')
        if number and year and int(year) >= 2005:
            field['issue'] = number

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
        if fpage == lpage or fpage == '1':
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

    
