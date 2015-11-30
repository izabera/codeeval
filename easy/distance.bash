#!/bin/bash
LANG=C
while read -r; do
  points=( ${REPLY//[!0-9 -]} )
  (( num = (points[0] - points[2]) ** 2 + (points[1] - points[3]) ** 2 ))
  until [[ ${sqrt[num]} ]]; do
    (( sqrt[i*i] = i, i++ ))
  done
  echo "${sqrt[num]}"
done < "$1"
