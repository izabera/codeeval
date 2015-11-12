#!/bin/bash
LANG=C
while read -r; do
  len=${#REPLY}
  for (( period = 1; period <= len / 2; period++ )) do
    (( len % period == 0 )) || continue
    for (( i = period; i <= len - period; i += period )) do
      # nope
      [[ ${REPLY:0:period} != ${REPLY:i:period} ]] && continue 2
    done
    # found it
    echo "$period"
    continue 2
  done
  # nope
  echo "$len"
done < "$1"
