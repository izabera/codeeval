#!/bin/bash
LANG=C
declare -A array
while read -ra input || (( ${#input[@]} )); do # assholes
  array=() i=0 row=0 col=0 max=()
  while :; do
    case ${input[i]} in
      "|") (( col = 0 , row++ )) ;;
      "") break ;;
      *) array[$row,$((col++))]=${input[i]}
    esac
    (( i++ ))
  done

  for (( i = 0; i <= row; i++ )) do
    for (( j = 0; j < col; j++ )) do
      (( array[$i,$j] > ${max[j]--1000} )) && max[j]=${array[$i,$j]}
    done
  done
  echo "${max[@]}"
done < "$1"
