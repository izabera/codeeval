#!/bin/bash
LANG=C IFS=";"
values=(10000 5000 2000 1000 500 200 100 50 25 10 5 1)
letters=("ONE HUNDRED" "FIFTY" "TWENTY" "TEN" "FIVE" "TWO" "ONE"
"HALF DOLLAR" "QUARTER" "DIME" "NICKEL" "PENNY")

while read -r pp ch; do
  if [[ $pp != *.* ]]; then pp+=00
  else pp=${pp/.}
  fi
  if [[ $ch != *.* ]]; then ch+=00
  else ch=${ch/.}
  fi
  if (( ch < pp )); then
    echo ERROR
  elif (( ch == pp )); then
    echo ZERO
  else
    out=() IFS=,
    (( change = ch - pp ))
    for val in "${!values[@]}"; do
      while (( change >= values[val] )); do
        (( change -= values[val] ))
        out+=("${letters[val]}")
      done
    done
    echo "${out[*]}"
    IFS=";"
  fi
done
