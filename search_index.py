#!/usr/bin/python
# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU GPL version 2 or later
import json
import os.path
import sys
import xml.etree.ElementTree as ET

files = sys.argv[1:]
documents = []
url_root = 'https://devmanual.gentoo.org/'

for f in files:
    tree = ET.parse(f)
    root = tree.getroot()
    for chapter in root.findall('chapter'):
        try:
            documents.append({"name": chapter.find('title').text,
                "text": chapter.find('body').find('p').text,
                 "url": url_root + os.path.dirname(f) + '/'})
        except AttributeError:
            pass

print('var documents = ' + json.dumps(documents) + ';')
