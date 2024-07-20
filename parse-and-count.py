import sys
from lxml import etree
from nltk.tokenize import wordpunct_tokenize

# Read in XML content from stdin
xml = sys.stdin.read().removeprefix("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")

# Parse into XML tree
root = etree.fromstring(xml)

# Extract body
body = root.xpath('/tei:TEI/tei:text/tei:body',
  namespaces={"tei":"http://www.tei-c.org/ns/1.0"})[0]

# Join all text of all descendents of body node
textContent = " ".join(body.itertext())

# tokenize the text 
tokens = wordpunct_tokenize(textContent)

# Remove all tokens that are not alphanumeric characters (mostly punctuation symbols)
tokens = [t for t in tokens if t.isalnum()]

# Print out the length of the remaining list
print(len(tokens))