#!/bin/bash
LANG=C
while read -ra arr || (( ${#arr[@]} )); do # assholes
  (( upper = arr, lower = 0, guess = (upper+1) / 2 ))
  for hint in "${arr[@]:1:${#arr[@]}-2}"; do
    if [[ $hint = Lower ]]; then
      (( upper = guess - 1, guess = (upper+lower) / 2 + (upper-lower) % 2 ))
    else                                                                   
      (( lower = guess + 1, guess = (upper+lower) / 2 + (upper-lower) % 2 ))
    fi
  done
  echo "$guess"
done < "$1"
