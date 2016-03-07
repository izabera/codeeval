#!/bin/bash
LANG=C

declare -A letters
while read -ra tmp || [[ $tmp ]]; do
  arr=()
  for i in "${tmp[@]}"; do
    [[ $i = "|" ]] && continue
    arr+=("$i")
  done
  cols=${#arr[0]} lines=${#arr[@]}
  count=0
  for (( i = 0; i < cols-1; i++ )) do
    for (( j = 0; j < lines-1; j++ )) do
      letters=()
      [[ ${arr[j]:i:1} = [code] ]] && letters[${arr[j]:i:1}]=1 || continue
      [[ ${arr[j]:i+1:1} = [code] ]] && letters[${arr[j]:i+1:1}]=1 || continue
      [[ ${arr[j+1]:i:1} = [code] ]] && letters[${arr[j+1]:i:1}]=1 || continue
      [[ ${arr[j+1]:i+1:1} = [code] ]] && letters[${arr[j+1]:i+1:1}]=1 || continue
      (( letters[c] + letters[o] + letters[d] + letters[e] == 4 )) && (( count++ ))
    done
  done
  echo "$count"
done < "$1"
