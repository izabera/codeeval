#!/bin/bash
LANG=C
exec < "$1"
read -r num
while read -r; do
  lines[${#REPLY}]=$REPLY
done
lines=("${lines[@]}")

while (( i++ , num -- )); do
  printf "%s\n" "${lines[-i]}"
done
