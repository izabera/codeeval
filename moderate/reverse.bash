#!/bin/bash
LANG=C IFS=,
while read -rd";" -a arr; read -r num; do
  for (( i = 0; i < ${#arr[@]} - num + 1; i += num )) do
    for (( j = i, k = i + num - 1; j < k; j++, k-- )) do
      tmp=${arr[j]} arr[j]=${arr[k]} arr[k]=$tmp
    done
  done
  echo "${arr[*]}"
done < "$1"
