#!/bin/bash
LANG=C IFS=,
while read -r a b; do
  len=${#a}
  for (( i = 0; i < len; i++ )) do
    if [[ $a = ${b:i}${b::i} ]]; then
      echo True
      continue 2
    fi
  done
  echo False
done < "$1"
