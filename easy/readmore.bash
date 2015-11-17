#!/bin/bash
LANG=C
while read -r || [[ $REPLY ]]; do # assholes
  if (( ${#REPLY} <= 55 )); then
    printf "%s\n" "$REPLY"
  else
    REPLY=${REPLY:0:40}
    printf "%s... <Read More>\n" "${REPLY% *}"
  fi
done < "$1"
