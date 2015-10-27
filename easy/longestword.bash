#!/bin/bash
while read -ra arr; do
  longest=0 len=${#arr[@]} max=${#arr[0]}
  for (( i = 1; i < len; i++ )) do
    (( ${#arr[i]} > max )) && (( max = ${#arr[i]} , longest = i ))
  done
  printf "%s\n" "${arr[longest]}"
done < "$1"
