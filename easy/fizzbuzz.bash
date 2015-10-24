#!/bin/bash
while read -r x y n; do
  for (( i = 1; i <= n; i++ )) do
    if (( i % x == 0 && i % y == 0 )); then printf FB
    elif (( i % x == 0 )); then printf F
    elif (( i % y == 0 )); then printf B
    else printf %s "$i"
    fi
    (( i == n )) && echo || printf " "
  done
done < "$1"
