#!/bin/bash
# stolen from k&r
while read -r num; do
  for (( c = 0; num; c++ )) do
    (( num &= num - 1 ))
  done
  echo "$c"
done < "$1"
