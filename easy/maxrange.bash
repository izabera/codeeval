#!/bin/bash
LANG=C IFS='; '

while read -ra arr || [[ $arr ]]; do
  for (( i = 1, sum = 0, n = arr[0]; i <= n; i++ )) do
    (( sum += arr[i] ))
  done
  for (( max = 0; i < ${#arr[@]}; i++ )) do
    (( ( sum = sum - arr[i-n] + arr[i] ) > max )) && (( max = sum ))
  done
  echo "$max"
done < "$1"
