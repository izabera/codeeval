#!/bin/bash
LANG=C
while read -rd"|"; read -ra arr; do
  for i in "${arr[@]}"; do
    printf %s "${REPLY:i-1:1}"
  done
  echo
done < "$1"
