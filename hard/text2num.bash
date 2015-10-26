#!/bin/bash

# let's assume that our input is sane
declare -A nums=([zero]=0     [one]=1      [two]=2        [three]=3     [four]=4
                 [five]=5     [six]=6      [seven]=7      [eight]=8     [nine]=9
                 [ten]=10     [eleven]=11  [twelve]=12    [thirteen]=13 [fourteen]=14
                 [fifteen]=15 [sixteen]=16 [seventeen]=17 [eighteen]=18 [nineteen]=19
                 [twenty]=20  [thirty]=30  [forty]=40     [fifty]=50    [sixty]=60
                 [seventy]=70 [eighty]=80  [ninety]=90    [hundred]=100 [thousand]=1000
                 [million]=1000000)

parsem () {
  case million in
    "${words[1]}") # 3 mln
      (( num = 1000000 * nums[${words[0]}] ))
      words=("${words[@]:2}") ;;

    "${words[2]}") # 30 3 mln   or   3 hun mln
      if [[ ${words[1]} = hundred ]]; then
        (( num = 100000000 * nums[${words[0]}] ))
      else
        (( num = 1000000 * (nums[${words[0]}] + nums[${words[1]}]) ))
      fi
      words=("${words[@]:3}") ;;

    "${words[3]}") # 3 hun 3 mln
      (( num = 1000000 * (100 * nums[${words[0]}] + nums[${words[2]}]) ))
      words=("${words[@]:4}") ;;

    "${words[4]}") # 3 hun 30 3 mln
      (( num = 1000000 * (100 * nums[${words[0]}] + nums[${words[2]}] + nums[${words[3]}]) ))
      words=("${words[@]:5}") ;;
  esac
}

parsek () {
  case thousand in
    "${words[1]}") # 3 thou
      (( num += 1000 * nums[${words[0]}] ))
      words=("${words[@]:2}") ;;

    "${words[2]}") # 30 3 thou   or   3 hun thou
      if [[ ${words[1]} = hundred ]]; then
        (( num += 100000 * nums[${words[0]}] ))
      else
        (( num += 1000 * (nums[${words[0]}] + nums[${words[1]}]) ))
      fi
      words=("${words[@]:3}") ;;

    "${words[3]}") # 3 hun 3 thou
      (( num += 1000 * (100 * nums[${words[0]}] + nums[${words[2]}]) ))
      words=("${words[@]:4}") ;;

    "${words[4]}") # 3 hun 30 3 thou
      (( num += 1000 * (100 * nums[${words[0]}] + nums[${words[2]}] + nums[${words[3]}]) ))
      words=("${words[@]:5}") ;;
  esac
}

parseu () {
  case ${#words[@]} in
    1) # 3
      (( num += nums[${words[0]}] )) ;;

    2) # 30 3
      if [[ ${words[1]} = hundred ]]; then
        (( num += 100 * nums[${words[0]}] ))
      else
        (( num += nums[${words[0]}] + nums[${words[1]}] ))
      fi ;;

    3) # 3 hun 3
      (( num += 100 * nums[${words[0]}] + nums[${words[2]}] )) ;;

    4) # 3 hun 30 3
      (( num += 100 * nums[${words[0]}] + nums[${words[2]}] + nums[${words[3]}] )) ;;
  esac
}

while read -ra words; do
#while read -era words; do
  #history -s -- "${words[*]}"
  if [[ ${words[0]} = negative ]]; then
    words=("${words[@]:1}")
    printf -
  fi
  num=0
  parsem
  parsek
  parseu
  printf "%s\n" "$num"
done < "$1"
