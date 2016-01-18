#!/bin/bash
LANG=C
for i in {1..12}; do
  j=1
  printf %4d "$((i*j++))"{,,,}{,,}
  echo
done
