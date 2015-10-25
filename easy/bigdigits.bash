#!/bin/bash
# -**----*--***--***---*---****--**--****--**---**--
# *--*--**-----*----*-*--*-*----*-------*-*--*-*--*-
# *--*---*---**---**--****-***--***----*---**---***-
# *--*---*--*-------*----*----*-*--*--*---*--*----*-
# -**---***-****-***-----*-***---**---*----**---**--
# --------------------------------------------------

line0=("-**--" "--*--" "***--" "***--" "-*---" "****-" "-**--" "****-" "-**--" "-**--")
line1=("*--*-" "-**--" "---*-" "---*-" "*--*-" "*----" "*----" "---*-" "*--*-" "*--*-")
line2=("*--*-" "--*--" "-**--" "-**--" "****-" "***--" "***--" "--*--" "-**--" "-***-")
line3=("*--*-" "--*--" "*----" "---*-" "---*-" "---*-" "*--*-" "-*---" "*--*-" "---*-")
line4=("-**--" "-***-" "****-" "***--" "---*-" "***--" "-**--" "-*---" "-**--" "-**--")
line5=("-----" "-----" "-----" "-----" "-----" "-----" "-----" "-----" "-----" "-----")

LANG=C
while read -r; do
  output=
  for i in {0..5}; do
    for (( j = 0; j < ${#REPLY}; j++ )) do
      [[ ${REPLY:j:1} = [0-9] ]] && eval output+=\${line$i[\${REPLY:j:1}]}
    done
    output+=$'\n'
  done
  printf %s "$output"
done < "$1"
