#!/bin/bash
export LANG=C

while read -ra arr || [[ $arr ]]; do
  j=0 str=()
  for i in "${arr[@]}"; do
    if [[ $i = "|" ]]; then
      j=0
    else
      printf -v tmp %d "'$i"
      printf -v tmp %03o "$((i+101))"
      printf -v "str[j]" "%s%b" "${str[j]}" "\\$tmp"
      ((j++))
    fi
  done

  # simple insert sort will do
  sorted=("$str")
  for i in "${str[@]:1}"; do
    for (( j = 0; j < ${#sorted[@]}; j++ )) do
      [[ ${sorted[j]} > $i ]] && break
    done
    sorted=("${sorted[@]::j}" "$i" "${sorted[@]:j}")
  done

  out=()
  for (( i = 0; i < ${#sorted[0]}; i++ )) do
    for (( j = 0; j < ${#sorted[@]}; j++ )) do
      printf -v tmp %d "'${sorted[j]:i:1}"
      out+=("$((tmp-101))")
    done
    out+=("|")
  done

  echo "${out[@]::${#out[@]}-1}"
done < "$1"
