#!/bin/bash
FILE="$1"
tail -n+2 /home/dsc/Data/opentraveldata/$FILE| sort -t '^' -k 7 -n -r| head -1

