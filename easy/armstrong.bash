#!/bin/bash
LANG=C
while read -r; do
  exp=${#REPLY}
  for (( i = sum = 0; i < exp; i++ )) do
    (( sum += ${REPLY:i:1} ** exp ))
  done
  (( sum == REPLY )) && echo True || echo False
done < "$1"
