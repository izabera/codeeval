#!/bin/bash
LANG=C awk -F, '
{
  delete arr
  for (i = 1; i <= NF; i++) {
    if (++arr[$i] > NF/2) {
      print $i
      next
    }
  }
  print "None"
}' "$1"

#old solution that for some reason takes > 10s on their stupid server
#LANG=C IFS=,
#while read -ra arr; do
  #elems=() max=-1 half=$(( ${#arr[@]} / 2 ))
  #for elem in "${arr[@]}"; do
    #if (( ++ elems[elem] > half )); then
      #echo "$elem"
      #continue 2
    #fi
  #done
  #echo None
#done < "$1"
