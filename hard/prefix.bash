#!/bin/bash
prefix () {
  local op=${tokens[i++]} arg{1,2}{num,den}
  if [[ ${tokens[i]} = [*+/] ]]; then
    prefix
    arg1num=$resultnum arg1den=$resultden
  else
    arg1num=${tokens[i++]} arg1den=1
  fi
  if [[ ${tokens[i]} = [*+/] ]]; then
    prefix
    arg2num=$resultnum arg2den=$resultden
  else
    arg2num=${tokens[i++]} arg2den=1
  fi
  #declare -p i arg1num arg1den op arg2num arg2den
  fractmath "$arg1num" "$arg1den" "$op" "$arg2num" "$arg2den"
}

fractmath () {
  #printf args:
  #printf " <%s>" "$@"; echo
  case $3 in
    +) if (( $2 == $5 )); then
         (( resultnum = $1 + $4 , resultden = $2 ))
       else
         lcm "$2" "$5"
         #echo "$lcm"
         (( resultden = lcm , resultnum = $1 * lcm / $2 + $4 * lcm / $5 ))
       fi ;;
    /) (( resultnum = $1 * $5 , resultden = $2 * $4 )) ;;
    *) (( resultnum = $1 * $4 , resultden = $2 * $5 )) ;;
  esac
  gcd "$resultnum" "$resultden"
  (( resultnum /= gcd, resultden /= gcd ))
  #echo "<$1/$2> $3 <$4/$5> = <$resultnum/$resultden>"
}

gcd () {
  local a=$1 b=$2 t
  while (( b )); do
    (( t = b , b = a % b , a = t ))
  done
  gcd=$a
}

lcm () {
  gcd "$@"
  (( lcm = $1 / gcd * $2 ))
}

#set -x
while read -ra tokens; do
#set -f
#while read -er ; do
  #history -s -- "$REPLY"
  #tokens=($REPLY)
  #declare -p tokens
  i=0
  prefix
  echo "$(( resultnum / resultden ))"
#done < "${1-/dev/stdin}"
done < "$1"
