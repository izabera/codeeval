#!/bin/bash
LANG=C
# *cough cough* https://gist.github.com/fintara/8526152
while read -r num; do
  printf -v num %d $[1&num>>{31..0}]
  num=${num//0}
  echo "$(( ${#num} % 3 ))"
done < "$1"
