#!/bin/bash
LANG=C

while read -ra arr || [[ $arr ]]; do
  result=()
  for (( i = 0; i < ${#arr[@]}; i += 2 )) do
    (( num = 2#${arr[i]} , num = num ^ (num >> 4) , num = num ^ (num >> 2) , num = num ^ (num >> 1) ))
    printf -v num %d $[1&$num>>{31..0}]
    (( result[i] = 2#$num ))
  done
  printf -v out " | %s" "${result[@]}"
  echo "${out# | }"
done < "$1"
