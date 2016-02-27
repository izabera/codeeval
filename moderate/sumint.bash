#!/bin/bash
LANG=C IFS=,

while read -ra arr; do
  (( max_ending_here = max_so_far = arr[0] ))
  for x in "${arr[@]:1}"; do
    (( tmp = max_ending_here + x ))
    (( max_ending_here = x > tmp ? x : tmp ))
    (( max_so_far = max_so_far > max_ending_here ? max_so_far : max_ending_here ))
  done
  echo "$max_so_far"
done < "$1"
