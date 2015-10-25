#!/bin/bash

LANG=C
while read -r; do
  # iterative version is supposed to be faster

  n=${#REPLY} digits=()
  for (( i = 0; i < n; i++ )) do
    digits+=("${REPLY:i:1}")
  done

  list=(10#"${digits[0]}") tmplist=() count=0

  for (( i = 1; i < n; i++ )) do
    for j in "${list[@]}"; do
      tmplist+=("$j+10#${digits[i]}" "$j-10#${digits[i]}" "$j${digits[i]}")
    done
    list=("${tmplist[@]}") tmplist=()
  done

  for i in "${list[@]}"; do
    (( i % 2 == 0 || i % 3 == 0 || i % 5 == 0 || i % 7 == 0 )) && (( count++ ))
  done
  echo "$count"
done < "$1"
