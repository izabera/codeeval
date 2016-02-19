#!/bin/bash
LANG=C IFS=,

while read -ra arr; do
  w=() d=()
  for word in "${arr[@]}"; do
    [[ $word = *[0-9]* ]] && d+=("$word") || w+=("$word")
  done
  if (( ${#w[@]} == 0 || ${#d[@]} == 0 )); then
    echo "${arr[*]}"
  else
    printf "%s|%s\n" "${w[*]}" "${d[*]}"
  fi
done < "$1"
