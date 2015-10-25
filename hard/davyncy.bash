#!/bin/bash

LANG=C

matchleft () {
  # matchleft foo oobar -> leftoverlap = 2
  local i len=${#1}
  leftoverlap=0
  for (( i = 1; i < len; i++ )) do
    [[ ${2:0:i} = "${1: -i}" ]] && (( leftoverlap = i ))
  done
  return "$((!leftoverlap))"
}

match () {
  if [[ $1 = *"$2"* ]]; then overlap=${#2}
  elif [[ $2 = *"$1"* ]]; then overlap=${#1}
  elif matchleft "$@"; then overlap=$leftoverlap
  elif matchleft "$2" "$1"; then overlap=$leftoverlap
  else return 1
  fi
}

join () {
  if [[ $1 = *"$2"* ]]; then joined=$1
  elif [[ $2 = *"$1"* ]]; then joined=$2
  elif [[ ${1:0:maxoverlap} = "${2: -maxoverlap}" ]]; then joined=$2${1:maxoverlap}
  else joined=$1${2:maxoverlap}
  fi
}

IFS=\; 
while read -ra fragments; do
  while (( (total = ${#fragments[@]}) > 1 )); do
    maxoverlap=0

    for (( i = 0; i < total; i++ )) do
      for (( j = 0; j < total; j++ )) do
        (( i == j )) && continue
        if match "${fragments[i]}" "${fragments[j]}"; then
          if (( overlap > maxoverlap )); then
            (( maxoverlap = overlap , _i = i , _j = j ))
          fi
        fi
      done
    done

    join "${fragments[_i]}" "${fragments[_j]}"
    unset "fragments[_i]" "fragments[_j]"
    fragments=("${fragments[@]}" "$joined")

  done
  printf "%s\n" "${fragments[0]}"
done < "$1"
