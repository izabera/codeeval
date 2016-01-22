#!/bin/bash

LANG=C
while read -r a n; do
  digits=(0{,}{,,,,})
  case $a in
    [28]) (( digits[2] = digits[4] = digits[8] = digits[6] = n / 4 )) ;;&
    [37]) (( digits[3] = digits[9] = digits[7] = digits[1] = n / 4 )) ;;&
    4) (( digits[6] = n/2, digits[4] = n/2 + n%2 )) ;;
    9) (( digits[1] = n/2, digits[9] = n/2 + n%2 )) ;;
    [56]) digits[a]=$n ;;
    2) case $(( n % 4 )) in
         1) (( digits[2] ++ )) ;;
         2) (( digits[2] ++ , digits[4] ++ )) ;;
         3) (( digits[2] ++ , digits[4] ++ , digits[8] ++ )) ;;
       esac ;;
    3) case $(( n % 4 )) in
         1) (( digits[3] ++ )) ;;
         2) (( digits[3] ++ , digits[9] ++ )) ;;
         3) (( digits[3] ++ , digits[9] ++ , digits[7] ++ )) ;;
       esac ;;
    7) case $(( n % 4 )) in
         1) (( digits[7] ++ )) ;;
         2) (( digits[7] ++ , digits[9] ++ )) ;;
         3) (( digits[7] ++ , digits[9] ++ , digits[3] ++ )) ;;
       esac ;;
    8) case $(( n % 4 )) in
         1) (( digits[8] ++ )) ;;
         2) (( digits[8] ++ , digits[4] ++ )) ;;
         3) (( digits[8] ++ , digits[4] ++ , digits[2] ++ )) ;;
       esac ;;
  esac
  printf "0: %d, 1: %d, 2: %d, 3: %d, 4: %d, 5: %d, 6: %d, 7: %d, 8: %d, 9: %d\n" "${digits[@]}"
done < "$1"
