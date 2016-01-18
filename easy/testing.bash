#!/bin/bash
LANG=C
while read -rd"|" str1; read -r str2 || [[ $str1 ]]; do # assholes
  for (( count = i = 0; i < ${#str1}; i++ )) do
    [[ ${str1:i:1} = "${str2:i:1}" ]] || (( count ++ ))
  done
  case $count in
       0) echo Done     ;;
    [12]) echo Low      ;;
    [34]) echo Medium   ;;
    [56]) echo High     ;;
       *) echo Critical ;;
  esac
done < "$1"
