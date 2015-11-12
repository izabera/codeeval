#!/bin/bash
while read -r; do
  echo "$(( 16#$REPLY ))"
done < "$1"
