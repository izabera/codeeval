#!/bin/bash
LANG=C IFS=\;

regex='^([^:]*://)?([^/:]*)(:[0-9]+)?(/.*)?'
while read -r a b || [[ $a ]]; do
  [[ $a =~ $regex ]]
  ascheme=${BASH_REMATCH[1],,} ascheme=${ascheme:-http://}
  ahost=${BASH_REMATCH[2],,}
  aport=${BASH_REMATCH[3]:-:80}
  arest=
  for (( i = 0; i < ${#BASH_REMATCH[4]}; i++ )) do
    char=${BASH_REMATCH[4]:i:1}
    case $char in
      %) char=${BASH_REMATCH[4]:i:3}
        if [[ $char = %[[:xdigit:]][[:xdigit:]] ]]; then
          arest+=${char,,}; (( i += 2 ))
        else
          arest+=%25
        fi ;;
      [',/?@&=+$#']) arest+=$char ;;
      *) printf -v hex %%%x "'$char"; arest+=$hex ;;
    esac
  done

  [[ $b =~ $regex ]]
  bscheme=${BASH_REMATCH[1],,} bscheme=${bscheme:-http://}
  bhost=${BASH_REMATCH[2],,}
  bport=${BASH_REMATCH[3]:-:80}
  brest=
  for (( i = 0; i < ${#BASH_REMATCH[4]}; i++ )) do
    char=${BASH_REMATCH[4]:i:1}
    case $char in
      %) char=${BASH_REMATCH[4]:i:3}
        if [[ $char = %[[:xdigit:]][[:xdigit:]] ]]; then
          brest+=${char,,}; (( i += 2 ))
        else
          brest+=%25
        fi ;;
      [',/?@&=+$#']) brest+=$char ;;
      *) printf -v hex %%%x "'$char"; brest+=$hex ;;
    esac
  done

  checka=$ascheme$ahost$aport$arest
  checkb=$bscheme$bhost$bport$brest
  [[ $checka = "$checkb" ]] && echo True || echo False
  #declare -p a b checka checkb
done < "$1"
