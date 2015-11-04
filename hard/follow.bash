#!/bin/bash

LANG=C

# https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order
while read -r num; do

  # split to array
  a=() max=${#num}
  for (( i = 0; i < max; i++ )) do
    a+=("${num:i:1}")
  done

  for (( k = max - 2; k >= 0; k-- )) do
    if (( a[k] < a[k+1] )); then
      for (( l = max - 1; l >= 0; l-- )) do
        if (( a[k] < a[l] )); then
          tmp=${a[k]} a[k]=${a[l]} a[l]=$tmp
          #declare -p a
          for (( i = k + 1, lim = max; i < lim; i++, lim-- )) do
            tmp=${a[i]} a[i]=${a[lim]} a[lim]=$tmp
          done
          break
        fi
      done
      printf %s "${a[@]}" $'\n'
      continue 2
    fi
  done

  # didn't find it, sort the digits, take the smallest element and add a 0
  digits=() sorted=
  for (( i = 0; i < max; i++ )) do
    (( digits[${num:i:1}] ++ ))
  done
  for i in {0..9}; do
    while (( digits[i] -- )); do sorted+=$i; done
  done
  [[ $sorted =~ (0*)(.)(.*) ]]; sorted=${BASH_REMATCH[2]}0${BASH_REMATCH[1]}${BASH_REMATCH[3]}
  printf "%s\n" "$sorted"

done < "$1"
