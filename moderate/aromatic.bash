#!/bin/bash
LANG=C
declare -A romans=([M]=1000 [D]=500 [C]=100 [L]=50 [X]=10 [V]=5 [I]=1)
op=(+ -)
while read -r; do
  i=${#REPLY} older=0 sum=0
  while (( i > 0 )); do
    roman=${REPLY: --i:1} arabic=${REPLY: --i:1}
    (( sum += ${op[older > romans[$roman]]} arabic * romans[$roman] ))
    older=${romans[$roman]}
  done
  echo "$sum"
done < "$1"
