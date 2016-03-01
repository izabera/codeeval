#!/bin/bash
LANG=C
squares=([1]=1 [4]=2 [9]=3 [16]=4 [25]=5 [36]=6 [49]=7 [64]=8 [81]=9 [100]=10)

while read -ra arr || [[ ${arr} ]]; do
  max=${squares[${#arr[@]}]} out=()
  for (( i = 0; i < max; i++ )) do
    for (( j = max - 1; j >= 0; j-- )) do
      out+=("${arr[j*max+i]}")
    done
  done
  echo "${out[*]}"
done < "$1"
