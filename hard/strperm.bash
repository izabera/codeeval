#!/bin/bash

LANG=C IFS=,
declare -A letters

f () {
  case $# in
    0) ret=() ;;
    1) ret=("$1") ;;
    2) [[ $1 < $2 ]] && ret=("$1$2" "$2$1") || ret=("$2$1" "$1$2") ;;
    *)
      local tmp i
      for (( i = 1; i <= $#; i++ )) do
        f "${@:1:i-1}" "${@:i+1}"
        tmp+=("${ret[@]/#/${!i}}")
      done
      ret=("${tmp[@]}")
  esac
}

while read -r; do

  # split to array
  letters=() len=${#REPLY}
  for (( i = 0; i < len; i++ )) do
    letters[${REPLY:i:1}]=
  done

  # now sort array
  a=()
  for i in {0..9} {A..Z} {a..z}; do
    [[ ${letters[$i]+s} ]] && a+=("$i")
  done

  f "${a[@]}"
  printf "%s\n" "${ret[*]}"
done < "$1"


