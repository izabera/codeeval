#!/bin/bash
IFS=, LANG=C arr=(true false)
while read -r a b c; do
  echo "${arr[((a & (1 << b-1)) != 0) ^ ((a & (1 << c-1)) != 0)]}"
done < "$1"
