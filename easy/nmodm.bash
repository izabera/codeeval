#!/bin/bash
LANG=C IFS=,
while read -r a b; do
  echo "$(( a - a / b * b ))"
done < "$1"
