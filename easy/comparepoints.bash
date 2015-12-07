#!/bin/bash
LANG=C
while read -r x1 y1 x2 y2 || [[ $x1 ]]; do # assholes
  (( diffx = x1 - x2, diffy = y1 - y2 ))
  case $diffy in
    0) dir=;;
    -*) dir=N;;
    *) dir=S;;
  esac
  case $diffx in
    0) ;;
    -*) dir+=E;;
    *) dir+=W;;
  esac
  echo "${dir:-here}"
done < "$1"
