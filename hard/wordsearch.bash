#!/bin/bash
LANG=C
#line0=(A B C E)
#line1=(S F C S)
#line2=(A D E E)

declare -A positions=([A]="00 20" [B]=01 [C]="02 12" [D]=21 [E]="03 22 23" [F]=11 [S]="10 13")

check () {
  # we're passed the string, the current position and the remaining non-visited positions
  (( ${#1} == 1 )) && return
  (( $# != 2 )) || return
  local str=${1#?} targets=(${positions[${1:1:1}]}) curpos=$2
  shift 2

  local tmp
  printf -v tmp " %s" "$@"

  for pos in "${targets[@]}"; do
    [[ $tmp = *"$pos"* ]] || continue
    curi=${curpos%?} curj=${curpos#?}
    nexti=${pos%?} nextj=${pos#?}
    diffx=$((curi - nexti)) diffx=${diffx#-} diffy=$((curj - nextj)) diffy=${diffy#-}

    if (( diffx + diffy == 1 )); then
      check "$str" "$pos" ${tmp/ $pos} && return
    fi
  done
  return 1
}

while read -r || [[ $REPLY ]]; do
  if [[ $REPLY = *[!ABCDEFS]* ]]; then
    echo False
  else
    targets=(${positions[${REPLY:0:1}]})
    printf -v tmp " %s" {0..2}{0..3}
    for pos in "${targets[@]}"; do
      if check "$REPLY" "$pos" ${tmp/ $pos}; then
        echo True
        continue 2
      fi
    done
    echo False
  fi
done < "$1"
