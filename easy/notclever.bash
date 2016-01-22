#!/bin/bash
LANG=C
while read -rd"|" -a arr; read -r limit || [[ $limit ]]; do
  for (( j = 0; j < limit; j++ )) do
    for (( i = 0; i < ${#arr[@]}; i++ )) do
      if (( arr[i] > arr[i+1] )); then
        (( arr[i] = arr[i+1] , arr[i+1] = ${arr[i]} ))
        continue 2
      fi
    done
  done
  echo "${arr[@]}"
done < "$1"
