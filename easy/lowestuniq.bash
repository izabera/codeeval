#!/bin/bash
while read -ra array; do
  nums=() pos=() i=0
  for num in "${array[@]}"; do
    (( nums[num] ++, pos[num] = ++i ))
  done
  for i in {1..9}; do
    if (( nums[i] == 1 )); then
      echo "${pos[i]}"
      continue 2
    fi
  done
  echo 0
done < "$1"
