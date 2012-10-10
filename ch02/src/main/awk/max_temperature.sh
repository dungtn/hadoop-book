#!/usr/bin/env bash
# Calculate the max temperature for each year
# Usage: $chmod +x max_temperature.sh | max_temperature.sh ${PWD}/input/

if [ "$1" == "" ]; then
  echo "No input directory specified!"
  exit
fi
for year in "$1"/ncdc/all/*
do
  echo -ne `basename $year .gz`"\t"
  gunzip -c $year | \
    awk '{ temp = substr($0, 88, 5) + 0;
           q = substr($0, 93, 1);
           if (temp !=9999 && q ~ /[01459]/ && temp > max) max = temp }
         END { print max }'
done
