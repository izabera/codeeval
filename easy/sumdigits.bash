#!/bin/bash
while read -r; do
  for (( sum = 0, i = 0; i < ${#REPLY}; i++ )) do
    (( sum += ${REPLY:i:1} ))
  done
  echo "$sum"
done < "$1"
