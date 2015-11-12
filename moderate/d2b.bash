#!/bin/bash
while read -r; do
  printf -v num %d $[1&REPLY>>{31..0}]
  printf "%s\n" "$(( 10#$num ))"
done < "$1"
