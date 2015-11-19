#!/bin/bash
LANG=C ans=(False True)
while read -r; do
  for (( len = ${#REPLY}, sum = 0, i = 0; i < len; i++ )) do
    (( sum += ${REPLY:i:1} ** len ))
  done
  echo "${ans[sum == REPLY]}"
done < "$1"
