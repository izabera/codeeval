#!/bin/bash
LANG=C
nums=(
''  One    Two    Three       Four       Five       Six        Seven        Eight       Nine
Ten Eleven Twelve Thirteen    Fourteen   Fifteen    Sixteen    Seventeen    Eighteen    Nineteen
           Twenty [30]=Thirty [40]=Forty [50]=Fifty [60]=Sixty [70]=Seventy [80]=Eighty [90]=Ninety
)

while read -r num; do
  if (( num >= 1000000 )); then
    if (( num >= 100000000 )); then
      printf %sHundred "${nums[num/100000000]}"
      (( num %= 100000000 ))
    fi
    if [[ ${nums[num/1000000]+x} ]]; then printf %s "${nums[num/1000000]}"
    else
      (( tmp = num / 1000000 ))
      printf %s "${nums[${tmp%?}0]}" "${nums[tmp%10]}"
    fi
    (( num %= 1000000 ))
    printf Million
  fi

  if (( num >= 1000 )); then
    if (( num >= 100000 )); then
      printf %sHundred "${nums[num/100000]}"
      (( num %= 100000 ))
    fi
    if [[ ${nums[num/1000]+x} ]]; then printf %s "${nums[num/1000]}"
    else
      (( tmp = num / 1000 ))
      printf %s "${nums[${tmp%?}0]}" "${nums[tmp%10]}"
    fi
    (( num %= 1000 ))
    printf Thousand
  fi

  if (( num >= 100 )); then
    printf %sHundred "${nums[num/100]}"
    (( num %= 100 ))
  fi

  if (( num >= 1 )); then
    if [[ ${nums[num]+x} ]]; then printf %s "${nums[num]}"
    else
      printf %s "${nums[${num%?}0]}" "${nums[num%10]}"
    fi
  fi

  echo Dollars
done < "$1"
