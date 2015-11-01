#!/bin/bash
fib=(0 1)
while read -r; do
  until [[ ${fib[REPLY]} ]]; do
    fib+=("$((fib[-1] + fib[-2]))")
  done
  echo "${fib[REPLY]}"
done < "$1"
