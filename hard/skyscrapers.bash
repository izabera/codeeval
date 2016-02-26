#!/bin/bash
LANG=C
set -f
while read -r; do
  points=()
  # split on ; and remove those completely pointless parentheses
  IFS=";"; buildings=( ${REPLY//[()]} )

  IFS=,
  for i in "${buildings[@]}"; do
    building=( $i )
    for (( i = building[0] + 1; i <= building[2]; i++ )) do
      (( points[i] < building[1] )) && (( points[i] = building[1] ))
    done
  done
  keys=("${!points[@]}") last=$(( keys[-1] + 1 ))

  output=()
  for (( i = height = 0; i <= last; i++ )) do
    if (( points[i] != height )); then
      (( height = points[i] ))
      output+=("$((i-1))" "$height")
    fi
  done
  #declare -p output

  echo "${output[@]}"
done < "$1"
