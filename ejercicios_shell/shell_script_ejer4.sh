#!/usr/bin/bash
DELIMETER="$1"
FILE= "$2"
csvcut -d $DELIMETER -n /home/dsc/Data/opentraveldata/$FILE| less

