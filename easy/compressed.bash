#!/bin/bash
LANG=C
while read -ra arr; do
  # let's assume we always have at least one number
  typeset -i i=0 out=(1 "${arr[0]}")
  for num in "${arr[@]:1}"; do
    if (( num == out[i+1] )); then out[i]+=1
    else out[i+=2]=1 out[i+1]=$num
    fi
  done
  echo "${out[@]}"
done < "$1"
