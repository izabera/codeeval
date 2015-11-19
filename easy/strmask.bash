#!/bin/bash
LANG=C
while read -r str mask || [[ $str ]]; do # assholes
  len=${#str}
  for (( i = 0; i < len; i++ )) do
    letter=${str:i:1}
    (( ${mask:i:1} )) && printf %s "${letter^}" || printf %s "$letter"
  done
  echo
done < "$1"
