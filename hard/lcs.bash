#!/bin/bash
# ported from
# https://github.com/mpillar/codeeval/blob/master/2-hard/longest-common-subsequence/main.py

LANG=C IFS=\;
while read -r a b || [[ $a ]]; do
  [[ $a ]] || continue
  len=() cols=$((${#b}+1)) lena=${#a} lenb=${#b}
  for (( i = 0; i < lena; i++ )) do
    x=${a:i:1}
    for (( j = 0; j < lenb; j++ )) do
      y=${b:j:1}
      if [[ $x = "$y" ]]; then
        (( len[(i+1)*cols+(j+1)] = len[i*cols+j] + 1 ))
      else
        (( len[(i+1)*cols+(j+1)] = len[(i+1)*cols+j] > len[i*cols+j+1] ? len[(i+1)*cols+j] : len[i*cols+j+1] ))
      fi
    done
  done
  x=$lena y=$lenb result=
  while (( x != 0 && y != 0 )); do
    if (( len[x*cols+y] == len[(x-1)*cols+y] )); then
      (( x-- ))
    elif (( len[x*cols+y] == len[x*cols+y-1] )); then
      (( y-- ))
    else
      result=${a:x-1:1}$result
      (( x--, y-- ))
    fi
  done
  echo "$result"
done < "$1"
