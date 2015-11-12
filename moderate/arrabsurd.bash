#!/bin/bash
while read -rd";" num; do
  sum=0
  for (( i = 1; i < num; i++ )) do
    read -rd, val
    (( sum += val ))
  done
  read -r val
  (( sum += val ))
  # if we had all the elements, sum would be (num-2) * (num-1) / 2
  echo "$(( sum - (num-2) * (num-1) / 2 ))"
done


