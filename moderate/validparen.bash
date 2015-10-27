#!/bin/bash
exit=(True False)
shopt -s extglob
while read -r; do
  while len=${#REPLY} REPLY=${REPLY//@("[]"|"()"|"{}")}
    (( len != ${#REPLY} ))
  do :; done
  printf "%s\n" "${exit[len != 0]}"
done < "$1"
