#!/bin/bash
pascal=(0 "1" "1 1" "1 2 1" "1 3 3 1" "1 4 6 4 1" "1 5 10 10 5 1"
"1 6 15 20 15 6 1" "1 7 21 35 35 21 7 1" "1 8 28 56 70 56 28 8 1")
while read -r num; do
  if ! [[ ${pascal[num]+set} ]]; then
    previous=0
    for (( i = ${#pascal[@]} -1; i <= num; i++ )) do
      tmp=() previous=0
      for j in ${pascal[-1]} 0; do
        tmp+=("$(( j + previous ))") previous=$j
      done
      pascal+=("${tmp[*]}")
    done
  fi
  printf "%s\n" "${pascal[*]:1:num}"
done < "$1"
