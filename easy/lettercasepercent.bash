#!/bin/bash
LANG=C

while read -r || [[ $REPLY ]]; do
  lower=${REPLY//[A-Z]} upper=${REPLY//[a-z]}
  (( lopercent = 100000 * ${#lower} / ${#REPLY} + 5 ))
  lopercent=${lopercent%?}
  (( uppercent = 10000 - lopercent ))
  printf -v lopercent %04d "$lopercent"
  printf -v uppercent %04d "$uppercent"
  lopercent=${lopercent::-2}.${lopercent: -2}
  uppercent=${uppercent::-2}.${uppercent: -2}
  printf "lowercase: %.2f uppercase: %.2f\n" "$lopercent" "$uppercent"
done < "$1"
