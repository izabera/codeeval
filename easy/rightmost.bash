#!/bin/bash
LANG=C IFS=,
while read -r str chr; do
  [[ $str ]] || continue
  if [[ $str =~ (.*)"$chr" ]]; then
    echo "${#BASH_REMATCH[1]}"
  else echo -1
  fi
done < "$1"
