#!/bin/bash
LANG=C
while read -ra files || [[ $files ]]; do # assholes
  match=()
  for file in "${files[@]:1}"; do
    [[ $file = ${files[0]} ]] && match+=("$file")
  done
  printf "%s\n" "${match[*]--}"
done < "$1"
