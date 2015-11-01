#!/bin/bash
while read -ra arr; do
  (( arr[-1] < ${#arr[@]} )) && printf "%s\n" "${arr[-arr[-1]-1]}"
done < "$1"
