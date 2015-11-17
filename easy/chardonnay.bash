#!/bin/bash
LANG=C
while read -ra names -d "|"; read -r search || [[ $search ]]; do # assholes
  matches=() search=${search,,}

  for name in "${names[@]}"; do
    tmp=${name,,}
    for (( i = 0; i < ${#search}; i++ )) do
      c=${search:i:1}
      [[ $tmp = *"$c"* ]] || continue 2
      tmp=${tmp/"$c"}
    done
    matches+=("$name")
  done

  printf "%s\n" "${matches[*]:-False}"
done < "$1"
