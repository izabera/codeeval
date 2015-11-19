#!/bin/bash
LANG=C
# bash is terribly slow
typeset -i tmp i=1
while read -r amount limit || [[ $amount ]]; do # assholes
  while (( i <= limit )); do
    printf -v tmp 10#%d%d%d%d%d%d%d%d%d%d%d%d%d $[1&i>>{12..0}]
    zeros[i]=${tmp//1} zeros[i]=${#zeros[i]} i+=1
  done
  for (( count = 0, j = 1 ; j <= limit; j++ )) do
    (( zeros[j] == amount )) && (( count ++ ))
  done
  echo "$count"
done < "$1"
