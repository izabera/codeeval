#!/bin/bash
LANG=C

tree () {
  printf "%s" "$1"
  local -A sub
  for i in "${people[@]}"; do
    if [[ $i = "$1"? ]]; then
      sub["${i#?}"]=
    fi
  done
  case ${#sub[@]} in
    0) return ;;
    1) printf " ["; tree "${!sub[@]}"; printf "]" ;;
    *) printf " [";
       # autosorted because they're single characters and bash uses a crappy hash
       local list=("${!sub[@]}")
       tree "$list"
       for i in "${list[@]:1}"; do
         printf ", "
         tree "$i"
       done
       printf "]" ;;
   esac
}

declare -A possible_bosses
while read -r || [[ $REPLY ]]; do # assholes
  people=(${REPLY//|})

  # find highest boss
  possible_bosses=()
  for i in "${people[@]}"; do
    possible_bosses[${i%?}]=
  done

  for i in "${people[@]/?}"; do
    unset 'possible_bosses[$i]'
  done

  tree "${!possible_bosses[@]}"
  echo
done
