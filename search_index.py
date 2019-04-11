#!/usr/bin/python
# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU GPL version 2 or later
import json
import os
import sys
import xml.etree.ElementTree as ET

xmlFile = sys.argv[1]
documents = []

for path, dirs, files in os.walk('.'):
    if xmlFile in files:
        tree = ET.parse(path + '/' + xmlFile)
        root = tree.getroot()
        for chapter in root.findall('chapter'):
            try:
                documents.append({"name": chapter.find('title').text,
                    "text": chapter.find('body').find('p').text,
                    "url": path })
            except:
                pass
    if '.git' in dirs:
        dirs.remove('.git')  # don't visit git directories

print(json.dumps(documents))
