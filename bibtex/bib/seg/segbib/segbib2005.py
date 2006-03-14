#!/usr/bin/env python
import sys, re, string

key = re.compile('\@([^\{]+)\{(\w+(?:\s+[\w\.\-]+)+)\,')
author = re.compile('\s+(author|editor)\s*=\s*\{([^\}]+)')
title = re.compile('\s+title\s*=\s*\{([^\}]+)')
year = re.compile('\s+year\s*=\s*\{([^\}]+)')
special_character = re.compile(r'([^\\])([\&\#\$\_])')
needs_braces = re.compile(r'([^\{])([A-Z])')

is_book = re.compile('('+'|'.join([
    'SSS00 00 07320732',
    'ANI00 00 00010425',
    'CAP00 00 00010343',
    'RGM00 00 00010454',
    'ASA00 00 00010725',
    'SAA00 00 00010633',
    'MG101 00 00010492',
    'MG202 00 00010708',
    'DEC00 00 04820482',
    'DED00 00 07260726',
    ])+')')

is_repeated = re.compile('('+'|'.join([
    'GEO52 06 08150815',
    'GEO24 01 01720172',
    'GIT00 00 02850285',
    'PRE00 75 00290029',    
    'PRE00 66 00460046',
    'PRE00 64 00150015',    
    'PRE00 58 00380040',
    'PRE00 56 00280028',
    'PRE00 55 00140018',
    'PRE00 54 00280029',
    'PRE00 51 00330035',
    'PRE00 49 00230029',
    'PRE00 45 00120014',
    'PRE00 43 00070009',
    'PRE00 42 00220025',
    'PRE00 42 00070010',
    'SEG 1996 1603',
    'SEG 1986 W.3',
    'TLE21 08 08040804',
    'VIB00 00 08300830',
    'FBR20 01 00270033',
    'FBR20 01 00350041',
    'GPR51 01 00010013',
    'GPR51 01 00150022',
    'GPR51 01 00230035',
    'GPR51 01 00370048',
    'GPR51 01 00490060',
    'GPR51 01 00610074',
    'GPR51 01 00750087',
    'CAN32 02 01300138',
    'TLE22 10 09300930',
    'FBR20 05 02770281',
    'FBR20 05 02830286',
    'FBR20 05 02870294',
    'FBR20 05 02990301',
    'FBR20 05 03020304',
    'FBR20 05 03050308'
    ])+')')

def fix_special(string):
    string = string.replace("","{\\'{e}}").replace("","{\\\"{o}}")
    string = string.replace("","{\\\"{u}}")
    string = special_character.sub(r'\1\\\2',string)
    string = string.replace("{T}^2","$T^2$")
    string = string.replace("{X}^2","$X^2$")
    return string

def fix_author(string):
    authors = []
    for author in string.split('; '):
        parts = author.split(', ')
        if len(parts) > 1:
            initials = parts[1].replace('.','[]').replace(',','[]')
            last = parts[0].replace(',','') # , in the last name is a typo
            authors.append(initials + ' ' + last)
        else:
            # some names don't have initials
            last = parts[0].replace(',','').replace(' ','')
            authors.append(last)
    return fix_special(' and '.join(authors))

def convert():
    is_article = False
    book = False

    oldname = ''
    repeat = {}
    authors = {}
    
    while True:
        line = sys.stdin.readline()
        if not line:
            sys.exit(0)
        
        line = line.rstrip("\n").rstrip("\r")
        has_key = key.search(line)
        if has_key:
            is_article = (has_key.group(1) == 'article')

            head = has_key.group(0)
            line = head.translate(string.maketrans(' ','-'))
            
            name = has_key.group(2)
            if name == oldname or is_repeated.match(name):
                if repeat.has_key(name):
                    repeat[name] += 1
                else:
                    repeat[name] = 0
                line = line.replace(',',chr(ord('a') + repeat[name])+',')
            else:
                oldname = name
                
            line = line.replace('unknown','incollection')

            book = is_book.match(name)
            if book:
                line = line.replace('incollection','book')
        else:
            has_author = author.search(line)
            if has_author:
                line = '   %s = {%s},' % (has_author.group(1),
                                          fix_author(has_author.group(2)))
                authors[head] = 1
            elif title.search(line):
                line = needs_braces.sub(r'\1{\2}',line)
            elif year.search(line) and not authors.get(head):
                line = '   author = {SEG},\n' + line
            elif is_article:
                line = line.replace('booktitle','journal')
            elif book:
                line = line.replace('booktitle','title')
                
        line = fix_special(line)

        print line

if __name__ == '__main__':
    convert()

     
