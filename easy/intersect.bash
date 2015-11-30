#!/bin/bash
IFS=, LANG=C
while read -rd";" -a arr1; read -ra arr2 || [[ $arr2 ]]; do # assholes
  out=() i=0 j=0
  while (( i < ${#arr1[@]} && j < ${#arr2[@]} )); do
    if (( arr1[i] == arr2[j] )); then
      out+=("${arr1[i]}")
      (( i++, j++ ))
    elif (( arr1[i] < arr2[j] )); then
      (( i++ ))
    else
      (( j++ ))
    fi
  done
  echo "${out[*]}"
done < "$1"
