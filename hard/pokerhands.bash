#!/bin/bash
LANG=C

declare -A values=( [1]=1 [2]=2 [3]=3 [4]=4 [5]=5 [6]=6 [7]=7 [8]=8 [9]=9
[T]=10 [J]=10 [Q]=10 [K]=10 [A]=11)

declare -A fakevalues=( [1]=1 [2]=2 [3]=3 [4]=4 [5]=5 [6]=6 [7]=7 [8]=8 [9]=9
[T]=10 [J]=11 [Q]=12 [K]=13 [A]=14)
T=10 J=11 Q=12 K=13 A=14 # hacky values

royalflush () {
  suit=${1:1}
  [[ $1 = [TJQKA]"$suit" ]] || return
  [[ $2 = [TJQKA]"$suit" ]] || return
  [[ $3 = [TJQKA]"$suit" ]] || return
  [[ $4 = [TJQKA]"$suit" ]] || return
  [[ $5 = [TJQKA]"$suit" ]] || return
}

straightflush () {
  suit=${1:1}
  [[ $1 = ?"$suit" ]] || return
  [[ $2 = ?"$suit" ]] || return
  [[ $3 = ?"$suit" ]] || return
  [[ $4 = ?"$suit" ]] || return
  [[ $5 = ?"$suit" ]] || return
  minval=14 maxval=1
  for i in "${@%?}"; do
    (( i > maxval )) && maxval=$i
    (( i < minval )) && minval=$i
  done
  (( maxval - minval == 4 ))
}

flush () {
  suit=${1:1}
  [[ $1 = ?"$suit" ]] || return
  [[ $2 = ?"$suit" ]] || return
  [[ $3 = ?"$suit" ]] || return
  [[ $4 = ?"$suit" ]] || return
  [[ $5 = ?"$suit" ]] || return
}

four () {
  tmp=()
  for i do
    (( tmp[${i%?}] ++ ))
  done
  tmp=("${tmp[@]}")
  (( ${#tmp[@]} == 2 && ( ${tmp[@]:0:1}+0 == 1 || ${tmp[@]:0:1}+0 == 4 ) ))
}

full () {
  tmp=()
  for i do
    (( tmp[${i%?}] ++ ))
  done
  tmp=("${tmp[@]}")
  (( ${#tmp[@]} == 2 && ( ${tmp[@]:0:1}+0 == 2 || ${tmp[@]:0:1}+0 == 3 ) ))
}

pair () {
  tmp=()
  for i do
    (( tmp[${i%?}] ++ ))
  done
  (( ${#tmp[@]} < 5 ))
}

three () {
  tmp=()
  for i do
    (( tmp[${i%?}] ++ ))
  done
  tmp=("${tmp[@]}")
  (( ${tmp[@]:0:1}+0 == 3 || ${tmp[@]:1:1}+0 == 3 || ${tmp[@]:2:1}+0 == 3 ))
}

straight () {
  tmp=()
  for i do
    (( tmp[${i%?}] ++ ))
  done
  minval=14
  for i in "${@%?}"; do
    (( i < minval )) && minval=$i
  done
  for (( i = minval; i < minval+5; i++ )) do
    (( tmp[i] )) || return
  done
}

high () {
  maxval=1
  for i in "${@%?}"; do
    (( i > maxval )) && maxval=$i
  done
  REPLY=$maxval
}

twopairs () {
  tmp=()
  for i do
    (( tmp[${i%?}] ++ ))
  done
  couples=0
  tmp=("${tmp[@]}")
  (( ${tmp[@]:0:1}+0 == 2 )) && (( couples++ ))
  (( ${tmp[@]:1:1}+0 == 2 )) && (( couples++ ))
  (( ${tmp[@]:2:1}+0 == 2 )) && (( couples++ ))
  (( couples == 2 ))
}

declare -A points=( [high]=0 [pair]=1 [twopairs]=2 [three]=3 [straight]=4
[flush]=5 [full]=6 [four]=7 [straightflush]=8 [royalflush]=9)

while read -ra arr; do
  left=high leftcards=()
  for i in "${arr[@]:0:5}"; do
    (( leftcards[${i%?}] ++ ))
  done
  leftcards=("${!leftcards[@]}")
  for func in royalflush straightflush four full flush straight three twopairs pair; do
    "$func" "${arr[@]:0:5}" && left=$func && break
  done

  right=high rightcards=()
  for i in "${arr[@]:5}"; do
    (( rightcards[${i%?}] ++ ))
  done
  rightcards=("${!rightcards[@]}")
  for func in royalflush straightflush four full flush straight three twopairs pair; do
    "$func" "${arr[@]:5}" && right=$func && break
  done

  if (( points[$left] > points[$right] )); then echo left; continue
  elif (( points[$left] < points[$right] )); then echo right; continue
  fi

  for i in {4..0}; do
    if (( leftcards[i] > rightcards[i] )); then echo left; continue 2
    elif (( leftcards[i] < rightcards[i] )); then echo right; continue 2
    fi
  done

  echo none

done < "$1"
