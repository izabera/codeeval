#!/bin/bash
col=0 row=0 mode=o

interpret () {
  case $1 in
            # 0   1   2   3   4   5   6   7   8   9
    c) row0=(" " " " " " " " " " " " " " " " " " " ")
       row1=(" " " " " " " " " " " " " " " " " " " ")
       row2=(" " " " " " " " " " " " " " " " " " " ")
       row3=(" " " " " " " " " " " " " " " " " " " ")
       row4=(" " " " " " " " " " " " " " " " " " " ")
       row5=(" " " " " " " " " " " " " " " " " " " ")
       row6=(" " " " " " " " " " " " " " " " " " " ")
       row7=(" " " " " " " " " " " " " " " " " " " ")
       row8=(" " " " " " " " " " " " " " " " " " " ")
       row9=(" " " " " " " " " " " " " " " " " " " ") ;;
    h) col=0 row=0 ;;
    b) col=0 ;;
    d) (( row += row < 9 )) ;;
    u) (( row -= row > 0 )) ;;
    l) (( col -= col > 0 )) ;;
    r) (( col += col < 9 )) ;;
    e) for (( i = col; i < 10; i++ )) do eval "row$row[i]=' '"; done ;;
    i) mode=i ;;
    o) mode=o ;;
    ^) write ^ ;;
    *) row=${1:0:1} col=${1:1} ;;
  esac
}

write () {
  if [[ $mode = o || $col = 9 ]]; then
    eval "row$row[col]=\$1"
  else
    eval "row$row=(\"\${row$row[@]:0:col}\" \"\$1\" \"\${row$row[@]:col}\")"
    eval "row$row=(\"\${row$row[@]:0:9}\")"
  fi
  (( col += col < 9 ))
}

while read -rn1; do
  if [[ $REPLY = ^ ]]; then
    seq= seq2=
    read -rn1 seq
    [[ $seq = [0-9] ]] && read -rn1 seq2
    interpret "$seq$seq2"
  elif [[ $REPLY ]]; then write "$REPLY"
  fi
done < "$1"

printf "%s%s%s%s%s%s%s%s%s%s\n" \
  "${row0[@]}" "${row1[@]}" "${row2[@]}" "${row3[@]}" "${row4[@]}" \
  "${row5[@]}" "${row6[@]}" "${row7[@]}" "${row8[@]}" "${row9[@]}"
