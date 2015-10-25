#!/bin/bash
while IFS=, read -r a b; do
  [[ $a != *"$b" ]]; echo "$?"
done < "$1"
