# README

The code in this repository is used to automatically count all words in all submissions for DHd2025. 


## Setup

1. Install python dependencies
```
pip install -r requirements.txt
```

## Usage

1. Download a zip file from Conftool containing all dhc files. This can be done using the option "Alle ersten Dateien der aktuellen Seite als ZIP speichern".
2. Extract zip file into folder FOLDER
3. Run shell script
```
./check-lengths.sh FOLDER
```

## Output

The output should look like this:
```
1999 FOLDER/FILENAME.dhc
...
```

The output does not contain paper ids, because they are not included in the xml. This would be more convenient, but requires changing the XML format.

## Logic
The way the script works can be explained quickly: The script extracts all text content below the `body` element of the TEI/XML file. This text is then tokenized using NLTK and regular expressions. After that, all tokens that do not consist of alphanumeric characters are removed (i.e., we don't count punctuation). The length of the remaining list is then returned.

## Implications
This procedure has consequences: Footnotes, captions, references, URLs, section titles are all included in the word count, as they are XMLified below the `body` element. 


## Alternative Word Counters

| String | Google Docs | MS Word | This script |
| -------- | ----------------- | ------------- | ------------- |
| This is a sentence without anything interesting. | 7 | 7 | 7 | 
| This is 1 sentence with 3 digits and parentheses (5). | 10 | 10 | 10 |
| This sentence has a multi-word! | 5 | 5 | 6 |
| A sentence with an equation: 5+5 = 10. | 8 | 8 | 8 |
| 1 question with a date range: 1705-1732? | 7 | 7 | 8 |