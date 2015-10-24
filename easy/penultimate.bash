#!/bin/bash
while read -ra arr; do
  printf "%s\n" "${arr[-2]}"
done < "$1"
