#!/bin/bash
LANG=C
declare -l REPLY
while read -r; do
  echo ${REPLY//[^[:alpha:]]/ }
done < "$1"
if [[ $REPLY ]]; then #assholes
  echo ${REPLY//[^[:alpha:]]/ }
fi
