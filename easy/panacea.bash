#!/bin/bash
LANG=C

while read -ra hex -d'|'; read -ra bin; (( ${#hex[@]} )); do
  for (( i = hexsum = 0; i < ${#hex[@]}; i++ )) do
    (( hexsum += 16#${hex[i]} ))
  done
  for (( i = binsum = 0; i < ${#bin[@]}; i++ )) do
    (( binsum += 2#${bin[i]} ))
  done
  (( binsum >= hexsum )) && echo True || echo False
done < "$1"
