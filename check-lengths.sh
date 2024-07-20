#!/bin/bash

# SETTINGS
# Select python executable on your system
PYTHON=python3.11

# Read in folder name
FOLDER=$1

# Make for loops in bash work with spaces in file names
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# Iterate over all dhc files
for i in $(ls $FOLDER/*.dhc)
do
  # Identify the xml file
  # Note: There is a certain danger here if the dhc file contains multiple xml files.
  # 2025 this is not the case.
  XMLFILE=$(unzip -l $i | grep .xml | cut -c "31-")

  # Retrieve xml file from zip file and call python script to parse, tokenize and count
  LEN=$(unzip -p "$i" "$XMLFILE" | $PYTHON parse-and-count.py --input XML)
  
  # Print out word count and dhc file name
  echo "$LEN $i"
done

# Restore previous behaviour
IFS=$SAVEIFS
