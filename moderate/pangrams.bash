#!/bin/bash
LANG=C
while read -r str; do
  str=${str//[!a-zA-Z]} str=${str,,}
  missing=
  for letter in {a..z}; do
    [[ $str = *"$letter"* ]] || missing+=$letter
  done
  printf "%s\n" "${missing:-NULL}"
done < "$1"
