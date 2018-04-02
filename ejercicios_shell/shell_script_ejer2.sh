#!/bin/bash
FILE="$1"
COLUMN="$2"
tail -n+2 /home/dsc/Data/opentraveldata/$FILE| sort -t '^' -k $COLUMN -n -r| head -1

