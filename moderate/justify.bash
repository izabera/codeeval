#!/bin/bash
LANG=C

eighty="                                                                                "
set -f
while read -r || [[ $REPLY ]]; do
  while (( ${#REPLY} > 80 )); do
    words=($REPLY) line=${words[0]} i=1
    while (( ${#line} + ${#words[i]} < 80 )); do
      line+=" ${words[i++]}"
    done
    REPLY=${words[*]:i}

    words=($line) concat=${line// } sep=0 seps=()
    while (( ${#concat} + (sep + 1) * (${#words[@]} - 1) < 80 )); do
      (( sep ++ ))
    done

    for i in "${words[@]:1}"; do
      seps+=("${eighty:0:sep}")
    done

    (( len = ${#concat} + sep * (${#words[@]} - 1) ))
    line=${words[0]}
    for i in "${!seps[@]}"; do
      (( len++ < 80 )) && seps[i]+=" "
      line+=${seps[i]}${words[i+1]}
    done

    printf "%s\n" "$line"
  done
  printf "%s\n" "$REPLY"
done < "$1"
