#!/bin/bash
while read -r; do
  echo "$(( REPLY % 2 == 0 ))"
done < "$1"
