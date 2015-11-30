#!/bin/bash
LANG=C
set -f
while IFS=\; read -r words nums; do
  words=( $words ) nums=( $nums ) out=() i=0
  for arg in "${nums[@]}"; do
    out[arg]=${words[i]}
    unset "words[i++]"
  done
  for (( i = 1; ; i++ )) do
    if [[ ! ${out[i]} ]]; then
      out[i]=${words[@]}
      break
    fi
  done
  echo "${out[*]}"
done < "$1"
