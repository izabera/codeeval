#!/bin/bash
LANG=C

awk '
/SetCol/ { for (i = 0; i < 256; i++) arr[i,$2] = $3 }
/SetRow/ { for (i = 0; i < 256; i++) arr[$2,i] = $3 }
/QueryCol/ { sum = 0; for (i = 0; i < 256; i++) sum += arr[i,$2]; print sum }
/QueryRow/ { sum = 0; for (i = 0; i < 256; i++) sum += arr[$2,i]; print sum }
' "$@"

# typeset -i arr sum
# while read -ra cmd; do
#   case $cmd in
#     SetCol) for i in {0..255}; do arr[i*256+cmd[1]]=cmd[2]; done ;;
#     SetRow) for i in {0..255}; do arr[cmd[1]*256+i]=cmd[2]; done ;;
#     QueryCol) sum=0; for i in {0..255}; do sum+=arr[i*256+cmd[1]]; done; echo "$sum" ;;
#     QueryRow) sum=0; for i in {0..255}; do sum+=arr[cmd[1]*256+i]; done; echo "$sum" ;;
#   esac
# done < "$1"
