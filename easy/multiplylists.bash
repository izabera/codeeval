#!/bin/bash
LANG=C
while read -ra arr1 -d"|"; read -ra arr2; do
  out=() len=${#arr1[@]}
  for (( i = 0; i < len; i++ )) do
    out+=("$(( arr1[i] * arr2[i] ))")
  done
  echo "${out[@]}"
done < "$1"
