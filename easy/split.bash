#!/bin/bash
LANG=C
while read -r a b; do
  op=${b//[!+-]} left=${b%"$op"*} right=${b#*"$op"}
  echo "$(( 10#${a:0:${#left}} $op 10#${a: -${#right}} ))"
done < "$1"
