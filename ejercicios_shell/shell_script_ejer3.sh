#!/bin/bash
FILE="$1"
NUMBER_ENGINES="$2"
tail -n +2 /home/dsc/Data/opentraveldata/$FILE| cut -d "^" -f 7| grep $NUMBER_ENGINES| wc -l
