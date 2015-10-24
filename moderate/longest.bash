#!/bin/bash
exec < "$1"
read -r num
while read -r; do
  if (( ${#longest[@]} < num )); then
    longest+=("$REPLY")
  else
    for i in "${!longest[@]}"; do
      if (( ${#longest[i]} < ${#REPLY} )); then
        longest[i]=$REPLY
        break
      fi
    done
  fi
done

while (( ${#longest[@]} )); do
  max=0
  for i in "${!longest[@]}"; do
    if (( ${#longest[i]} > ${#longest[max]} )); then
      max=$i
    fi
  done
  printf "%s\n" "${longest[max]}"
  unset "longest[max]"
  longest=("${longest[@]}")
done
