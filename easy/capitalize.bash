#!/bin/bash
while read -ra arr; do
  printf "%s\n" "${arr[*]^}"
done < "$1"
