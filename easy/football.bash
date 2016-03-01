#!/bin/bash
LANG=C
while read -ra arr || [[ $arr ]]; do
  j=1 out=() lookup=()
  for i in "${arr[@]}"; do
    if [[ $i = '|' ]]; then
      (( j++ ))
    else
      lookup[i]+=,$j
    fi
  done
  for i in "${!lookup[@]}"; do
    out+=("$i:${lookup[i]#,};")
  done
  echo "${out[*]}"
done < "$1"
