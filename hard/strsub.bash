#!/bin/bash
IFS=, LANG=C
while read -rd";" string; read -ra replace; do
  # the string will only contain 0's and 1's
  # in a temp copy of the string, we'll replace everything with x
  copy=$string

  for i in "${!replace[@]}"; do
    (( i % 2 == 0 )) || continue
    while :; do

      if [[ $copy = *"${replace[i]}"* ]]; then

        # parts to keep intact
        pre=${copy%%"${replace[i]}"*} post=${copy#*"${replace[i]}"}

        # ${#pre} chars from ^       replacement    ${#post} char from $
        string=${string:0:${#pre}}${replace[i+1]}${string:${#pre}+${#replace[i]}}

        copy=$pre${replace[i+1]//?/x}$post

      else break
      fi

    done
  done
  echo "$string"
done < "$1"
