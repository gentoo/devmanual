#!/usr/bin/python3
# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU GPL version 2 or later
import json
import os.path
import sys
import xml.etree.ElementTree as ET
import re


# The regex for stripping a newline and the possible indentation
# whitespace following it in multiline content
whitespace_re = re.compile(r'\n[ \t]*', flags=re.M)


def stringify_node(parent: ET.Element) -> str:
    """Flatten this node and its immediate children to a string.

    Combine the text and tail of this node, and any of its immediate
    children, if there are any, into a flat string. The tag <d/> is a
    special case that resolves to the dash ('-') character.

    Keyword arguments:
    parent -- the node to convert to a string

    """
    # We usually have something like:
    #   <p>\nText
    # Left strip the whitespace.
    if parent.text:
        text = parent.text.lstrip()
    else:
        text = str()

    # For each child, strip the tags and append to text
    # along with the tail text following it.
    # The tail may include '\n', '\t', ' ' if it spans multiple lines.
    # We will worry about those on return, not now.
    for child in parent:
        # The '<d/>' tag is simply a fancier '-' character
        if child.tag == 'd':
            text += '-'
        if child.text:
            text += child.text
        if child.tail:
            text += child.tail

    # A paragraph typically ends with:
    #   Text\n</p>
    # Right strip any spurious whitespace.
    # Finally, get rid of any intermediate newlines and indentation whitespace.
    return whitespace_re.sub(' ', text.rstrip())


def process_node(documents: list, node: ET.Element, name: str, url: str) -> None:
    """Recursively process a given node and its children based on tag values.

    For the top level node <chapter>, extract the title and recurse
    down to the children.
    For the intermediary nodes with titles, such as <section>, update
    the search result title and url, and recurse down.
    For the terminal nodes, such as <p>, convert the contents of the
    node to a string, and add it to the search documents.

    Keyword arguments:
    documents -- the search documents array
    node -- the node to process
    name -- the title to display for the search term match
    url -- the url for the search term match in the document

    """
    if node.tag == 'chapter':
        name = stringify_node(node.find('title'))

        for child in node:
            process_node(documents, child, name, url)
    elif node.tag in ['section', 'subsection', 'subsubsection']:
        title = stringify_node(node.find('title'))
        name += ' -> ' + title
        url = "{url_base}#{anchor}".format(
            url_base=url.split('#')[0],
            anchor=title.lower().replace(' ', '-'))

        for child in node:
            process_node(documents, child, name, url)
    elif node.tag in ['devbook', 'body', 'dl', 'ul', 'table', 'tr']:
        for child in node:
            process_node(documents, child, name, url)
    elif node.tag in ['p', 'dd', 'dt', 'important', 'li', 'note', 'warning', 'th', 'ti']:
        text = stringify_node(node)

        documents.append({'id': len(documents),
                          'name': name,
                          'text': text,
                          'url': url})
    else:
        pass


def main(pathnames: list) -> None:
    """The entry point of the script.

    Keyword arguments:
    pathnames -- a list of path names to process in sequential order
    """
    url_root = 'https://devmanual.gentoo.org/'
    documents = []

    for path in pathnames:
        tree = ET.parse(path)
        root = tree.getroot()

        try:
            url = url_root + os.path.dirname(path) + '/'

            process_node(documents, root, None, url)
        except:
            raise

    print('var documents = ' + json.dumps(documents) + ';')


if __name__ in '__main__':
    main(sys.argv[1:])
