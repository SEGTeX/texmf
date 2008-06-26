#!/usr/bin/env python

from elementtree.ElementTree import ElementTree
import glob

#for xml in glob.glob('DCI_Archive/*.xml'):
for xml in ('DCI_Archive/EAE_2006_F002.xml',):
    tree = ElementTree(file=xml)
    for elem in tree.getroot():
        print elem.tag, ' => ', elem.text
        for subelem in elem:
            print ': ', subelem.tag, '=> ', subelem.text
            for subsubelem in subelem:
                print ':: ', subsubelem.tag, '=> ', subsubelem.text
                for subsubsubelem in subsubelem:
                    print '::: ', subsubsubelem.tag, '=> ', subsubsubelem.text


    
