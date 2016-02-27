#!/bin/bash
LANG=C

while read -r; do
  for (( i = 0; i < ${#REPLY}; i++ )) do
    val=${REPLY:i:1} tmp=${REPLY//[!$i]}
    if (( val != ${#tmp} )); then
      echo 0
      continue 2
    fi
  done
  echo 1
done < "$1"
