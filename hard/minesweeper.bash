#!/bin/bash
while IFS=, read -rd \; lines cols; read pattern; do
  # set up a fake top row
  fake=${pattern:0:cols} fake=x${fake//?/x}x
  board=("$fake")
  # rest of the actual board
  while [[ $pattern ]]; do
    board+=("x${pattern:0:cols}x") # with x
    pattern=${pattern:cols}
  done
  # and a fake bottom row
  board+=("$fake")

  out=()
  for (( i = 1; i <= lines; i++ )) do
    line=
    for (( j = 1; j <= cols; j++ )) do
      if [[ ${board[i]:j:1} = "*" ]]; then
        line+=*
      else
        count=0
        [[ ${board[i-1]:j-1:1} = "*" ]] && ((count++))
        [[ ${board[i-1]:j  :1} = "*" ]] && ((count++))
        [[ ${board[i-1]:j+1:1} = "*" ]] && ((count++))
        [[ ${board[i  ]:j-1:1} = "*" ]] && ((count++))
        [[ ${board[i  ]:j+1:1} = "*" ]] && ((count++))
        [[ ${board[i+1]:j-1:1} = "*" ]] && ((count++))
        [[ ${board[i+1]:j  :1} = "*" ]] && ((count++))
        [[ ${board[i+1]:j+1:1} = "*" ]] && ((count++))
        line+=$count
      fi
    done
    out+=("$line")
  done

  printf %s "${out[@]}" $'\n'
done < "$1"
