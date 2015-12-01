#!/bin/bash
LANG=C
tho=('' M MM MMM)
hun=('' C CC CCC CD D DC DCC DCCC CM)
dec=('' X XX XXX XL L LX LXX LXXX XC)
uni=('' I II III IV V VI VII VIII IX)
while read -r num; do
  if (( num >= 1000 )); then
    printf %s "${tho[num/1000]}"
    (( num %= 1000 ))
  fi
  if (( num >= 100 )); then
    printf %s "${hun[num/100]}"
    (( num %= 100 ))
  fi
  if (( num >= 10 )); then
    printf %s "${dec[num/10]}"
    (( num %= 10 ))
  fi
  echo "${uni[num]}"
done < "$1"
