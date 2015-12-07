#!/bin/bash
LANG=C
while read -ra arr; do
  for (( num = i = 0; i < ${#arr[@]}; i++ )) do
    if [[ ${arr[i]} = 0 ]]; then num+=${arr[++i]}
    else num+=${arr[++i]//0/1}
    fi
  done
  echo "$((2#$num))"
done < "$1"
