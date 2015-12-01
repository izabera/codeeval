#!/bin/bash
LANG=C
while read -ra times || (( ${#times[@]} )); do # assholes
  tmp=() out=() i=0
  for time in "${times[@]}"; do
    (( i++, tmp[10#${time//:}] ++ ))
  done
  for time in "${!tmp[@]}"; do
    while (( tmp[time] -- )); do
      printf -v "out[--i]" %02d:%02d:%02d "$(( time/10000 ))" "$(( (time/100)%100 ))" "$(( time%100 ))"
    done
  done
  echo "${out[@]}"
done < "$1"
