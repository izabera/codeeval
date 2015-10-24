#!/bin/bash
declare -A nums=([zero]=0 [one]=1 [two]=2 [three]=3 [four]=4
                 [five]=5 [six]=6 [seven]=7 [eight]=8 [nine]=9)

IFS=\;
while read -ra arr; do
  for i in "${arr[@]}"; do
    printf %s "${nums[${i}]}"
  done
  echo
done < "$1"
