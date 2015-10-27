#!/bin/bash
exec < "$1"
read -r num
while read -r; do
  lines[${#REPLY}]=$REPLY
done
lines=("${lines[@]}")

while (( num -- )); do
  printf "%s\n" "${lines[-1]}"
  unset "lines[${#lines[@]}-1]"
done
