#!/bin/bash
while read -ra words; do
  (( i = ${#words[@]} )) || continue
  arr=()
  while (( i-- )); do
    arr+=("${words[i]}")
  done
  printf "%s\n" "${arr[*]}"
done < "$1"
