#!/bin/bash
LANG=C
while read -r || [[ $REPLY ]]; do # assholes
  up=1
  for (( i = 0; i < ${#REPLY}; i++ )) do
    char=${REPLY:i:1}
    if [[ $char = [A-Za-z] ]]; then
      if (( up++%2 )); then
        printf %s "${char^}"
      else
        printf %s "${char,}"
      fi
    else
      printf %s "$char"
    fi
  done
  echo
done < "$1"
