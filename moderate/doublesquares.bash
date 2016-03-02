#!/bin/bash
LANG=C

exec < "$1"
read discarded   # why the fuck are you even giving me this number
# this is the only challenge that does this and it took me a while to realize it

while read -r num; do
# this solution is too slow, takes 9s on their server and scores 32.something
# rewritten in bc below

#  # dijkstra's algorithm
#  for i in 10 100 1000 10000 100000 1000000 10000000 100000000 1000000000; do
#    (( i ** 2 > num )) && break
#  done
#  lower=${i%0} upper=$i
#  while (( ( sqrt = ( upper + lower ) / 2 ) != lower )); do
#    if (( sqrt ** 2 > num )); then (( upper = sqrt ))
#    else (( lower = sqrt ))
#    fi
#  done
#
#  x=$sqrt y=0
#  #squares=()
#  squares=0
#  while ((x>=y)); do
#    ((sq=x*x+y*y))
#    if ((sq==num)); then
#      #squares+=("$(( x-- )),$(( y++ ))")
#      ((squares++,x--,y++))
#    elif ((sq<num)); then
#      ((y++))
#    else
#      ((x--))
#    fi
#  done
#
#  #echo "${#squares[@]}"
#  echo "$squares"

bc -l << eof
scale = 0
num = $num
x = sqrt(num)
y = 0

while ( x >= y ) {
  sq = x ^ 2 + y ^ 2
  if ( sq == num) {
    squares += 1; x -= 1; y += 1
  } else if ( sq < num ) {
    y += 1
  } else {
    x -= 1
  }
}
squares
eof

done
