#!/bin/bash
LANG=C
while read -ra nums || [[ $nums ]]; do
  sum=0
  for i in "${nums[@]}"; do
    (( sum += 2 * (${i:0:1} + ${i:2:1}) + (${i:1:1} + ${i:3:1}) ))
  done
  (( sum % 10 )) && echo Fake || echo Real
done < "$1"
