#!/bin/bash

LANG=C
ispal () {
  i=${#1} pal=
  while (( i )); do
    pal+=${1:(--i):1}
  done
  (( 10#$pal == $1 ))
}

while read -r num; do
  count=0
  while ! ispal "$num"; do
    (( num += 10#$pal , count++ ))
  done
  printf "%s %s\n" "$count" "$num"
done < "$1"
