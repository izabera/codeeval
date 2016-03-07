#!/bin/bash
IFS=,
while read -r x n; do
  for (( i = 1; n * i < x; i++ )) do
    :
  done
  echo "$(( n * i ))"
done < "$1"
