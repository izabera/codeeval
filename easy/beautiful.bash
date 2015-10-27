#!/bin/bash
declare -A letters
LANG=C
while read -r REPLY; do   # let's remove some whitespace
  letters=() len=${#REPLY}

  if (( (len = ${#REPLY}) < 50 )); then
    for (( i = 0; i < len; i++ )) do
      x=${REPLY:i:1}
      [[ $x = [a-zA-Z] ]] || continue
      (( letters[${x,}] ++ ))
    done
  else
    while read -rn1 x; do
      [[ $x = [a-zA-Z] ]] || continue
      (( letters[${x,}] ++ ))
    done <<< "$REPLY"
  fi

  # simple insert sort
  sorted=()
  for x in "${!letters[@]}"; do
    for (( i = 0; i < ${#sorted[@]}; i++ )) do
      (( letters[$x] <= letters[${sorted[i]}] )) || break
    done
    sorted=("${sorted[@]:0:i}" "$x" "${sorted[@]:i}")
  done

  j=0 tot=0
  for i in {26..1}; do
    (( tot += i * letters[${sorted[j]}] ))
    (( ++j < ${#sorted[@]} )) || break
  done

  printf "%s\n" "$tot"
done
