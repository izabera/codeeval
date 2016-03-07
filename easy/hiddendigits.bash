#!/bin/bash
LANG=C
while read -r; do
  REPLY=${REPLY//[!a-j0-9]}
  if (( ${#REPLY} )); then
    REPLY=${REPLY//a/0} REPLY=${REPLY//b/1} REPLY=${REPLY//c/2} REPLY=${REPLY//d/3} REPLY=${REPLY//e/4}
    REPLY=${REPLY//f/5} REPLY=${REPLY//g/6} REPLY=${REPLY//h/7} REPLY=${REPLY//i/8} REPLY=${REPLY//j/9}
    echo "$REPLY"
  else
    echo NONE
  fi
done < "$1"
