#!/usr/bin/env python

import sys, string, re

is_repeated = re.compile('('+'|'.join([
    'GEO52-06-08150815',
    'GEO24-01-01720172',
    'GIT00-00-02850285',
    'PRE00-75-00290029',    
    'PRE00-66-00460046',
    'PRE00-64-00150015',    
    'PRE00-58-00380040',
    'PRE00-56-00280028',
    'PRE00-55-00140018',
    'PRE00-54-00280029',
    'PRE00-51-00330035',
    'PRE00-49-00230029',
    'PRE00-45-00120014',
    'PRE00-43-00070009',
    'PRE00-42-00220025',
    'PRE00-42-00070010',
    'SEG-1996-1603',
    'SEG-1986-W.3',
    'TLE21-08-08040804',
    'VIB00-00-08300830',
    'FBR20-01-00270033',
    'FBR20-01-00350041',
    'GPR51-01-00010013',
    'GPR51-01-00150022',
    'GPR51-01-00230035',
    'GPR51-01-00370048',
    'GPR51-01-00490060',
    'GPR51-01-00610074',
    'GPR51-01-00750087',
    'CAN32-02-01300138',
    'TLE22-10-09300930',
    'FBR20-05-02770281',
    'FBR20-05-02830286',
    'FBR20-05-02870294',
    'FBR20-05-02990301',
    'FBR20-05-03020304',
    'FBR20-05-03050308'
    ])+')')

is_article = re.compile(r'(CAN|GEO|EGJ|EGK|PRE|FBR|GPR|TLE|REC)')

def find_type (key,pages,title,booktitle):
    if is_article.match(key):
        return "article"
    elif '-' in pages or title.lower() != booktitle.lower():
        return "incollection"
    else:
        return "book"

def fix_special(string):
    string = string.replace("","{\\'{e}}").replace("","{\\\"{o}}")
    string = string.replace("","{\\\"{u}}")
    return special_character.sub(r'\\\1',string)

def fix_author(string):
    authors = []
    for author in string.split(';'):
        parts = author.split(', ')
        if len(parts) > 1:
            initials = parts[1].replace('.','[]')
            last = parts[0].replace(',','') # , in the last name is a typo
            authors.append(initials + last)
        else:
            # some names don't have initials
            last = parts[0].replace(',','').replace(' ','')
            authors.append(last)
    return fix_special(' and '.join(authors))

needs_braces = re.compile(r'.*[A-Z]')
special_character = re.compile(r'([\&\#\$\_])')
math_mode = re.compile(r'([\w\d]+\^[\w\d]+)')

def fix_title(string):
    words = string.split(' ')
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

field = {'article': (9,10,11,12,13),
         'incollection': (6,8,10,11,12,13,15),
         'book': (6,12,13,15)}

name = ('key',
         'author',
         'year',
         'title',
         'editor',
         '5',
         'publisher',
         '7',
         'booktitle',
         'journal',
         'volume',
         'number',
         'pages',
         'keywords',
         '14',
         'note')

def convert(debug=0):
    oldkey = ''
    repeat = {}
    while True:
        line = sys.stdin.readline().rstrip("\n").rstrip("\r")
        if not line:
            sys.exit(0)
        fields = line.split('|')
        if debug:
            print fields
        key = fields[0].translate(string.maketrans(' ','-'))
        if key == oldkey or is_repeated.match(key):
            if repeat.has_key(key):
                repeat[key] += 1
            else:
                repeat[key] = 0
            key += chr(ord('a') + repeat[key])
        else:
            oldkey = key
        type = find_type(key,fields[12],fields[3],fields[8])
        if type == 'article':
            if not fields[9]: # if no journal
                fields[9] = fields[8] # use booktitle            
        else:
            fields[6] = fix_special(fields[6]) # check for special characters
        if type == 'incollection':
            if not fields[12]: # if no pages
                pages = fields[0].split().pop() # find them in the key
                start = pages[:4].lstrip('0')
                end   = pages[4:].lstrip('0')
                fields[12] = '-'.join([start,end])
        if fields[15]:
            fields[15] = fix_special(fields[15])
        author = fix_author(' ' + fields[1])
        year = fields[2]
        title = fix_title(fields[3])
        print "@%s{%s," % (type, key)
        if author:
            print "\tauthor=\t{%s}," % author
        if not author or type != 'book':
            if fields[4]: # look for editor
                editor = fix_author(' ' + fields[4])
                if not author and type == 'incollection':
                    print "\tauthor=\t{%s},"   % editor
                else:
                    print "\teditor=\t{%s},"   % editor
            elif not author: # no author and no editor
                print "\tauthor=\t{SEG},"
        print "\tyear=\t%s," % year
        print "\ttitle=\t{%s}," % title
        for k in field[type]:
            if fields[k]:
                print "\t%s=\t{%s}," % (name[k],fields[k])
        print "\t}\n"

if __name__ == '__main__':
    convert()
