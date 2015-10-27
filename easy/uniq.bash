#!/bin/bash
IFS=,
declare -A arr
while read -ra list; do
  arr=() out=()
  for i in "${list[@]}"; do
    (( ! arr[$i] ++ )) && out+=("$i")
  done
  echo "${out[*]}"
done < "$1"
