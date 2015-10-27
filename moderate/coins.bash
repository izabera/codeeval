#!/bin/bash
# greedy w/ lookup
list=(0 1 2 1 2)
while read -r; do
  printf "%s\n" "$(( REPLY / 5 + list[REPLY%5] ))"
done < "$1"
