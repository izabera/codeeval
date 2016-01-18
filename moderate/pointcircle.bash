#!/bin/bash
LANG=C
while read -r || [[ $REPLY ]]; do # assholes
  points=(${REPLY//[!.0-9-]/ })
  (( xcenter = 10#${points[0]#*.} + 10#${points[0]%.*} * 100 ,
     ycenter = 10#${points[1]#*.} + 10#${points[1]%.*} * 100 ,
     radius  = 10#${points[2]#*.} + 10#${points[2]%.*} * 100 ,
     xpoint  = 10#${points[3]#*.} + 10#${points[3]%.*} * 100 ,
     ypoint  = 10#${points[4]#*.} + 10#${points[4]%.*} * 100 ,
     dist    = (xpoint - xcenter) ** 2 + (ypoint - ycenter) ** 2 ))
  if (( radius ** 2 <= dist )); then echo false
  else echo true
  fi
done < "$1"
