#!/usr/bin/env python

from elementtree.ElementTree import ElementTree
import glob

for xml in glob.glob('DCI_Archive/*.xml'):
    doc = ElementTree(file=xml)
