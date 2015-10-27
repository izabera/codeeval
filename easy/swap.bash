#!/bin/bash
while read -ra values -d:; IFS=', ' read -ra swaps; do
  for swap in "${swaps[@]}"; do
    left=${swap%-*} right=${swap#*-}
    tmp=${values[left]} values[left]=${values[right]} values[right]=$tmp
  done
  printf "%s\n" "${values[*]}"
done < "$1"
