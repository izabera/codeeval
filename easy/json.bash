#!/bin/bash
# haha not gonna use an actual json parser
LANG=C
set -o pipefail
while read -r; do
  [[ $REPLY ]] || continue
  grep -o '{ *"id" *: *[0-9]* *, *"label" *' <<< "$REPLY" |
  sed -n 's/,.*//;s/[^0-9]//g;H;${x;s/\n/+/g;s/^/0/p}' ||
  echo 0
done < "$1" | bc
