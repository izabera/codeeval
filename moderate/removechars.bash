#!/bin/bash
LANG=C
while read -rd, str; read -r pat; do
  printf %s\\n "${str//[$pat]}"
done < "$1"
