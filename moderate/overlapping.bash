#!/bin/bash
LANG=C IFS=,
while read -r ulx1 uly1 lrx1 lry1 ulx2 uly2 lrx2 lry2; do
  # check if any corner of rect1 is in rect2
    if (( ulx1 >= ulx2 &&
          ulx1 <= lrx2 &&
          uly1 <= uly2 &&
          uly1 >= lry2 )); then echo True
  elif (( ulx1 >= ulx2 &&
          ulx1 <= lrx2 &&
          lry1 <= uly2 &&
          lry1 >= lry2 )); then echo True
  elif (( lrx1 >= ulx2 &&
          lrx1 <= lrx2 &&
          uly1 <= uly2 &&
          uly1 >= lry2 )); then echo True
  elif (( lrx1 >= ulx2 &&
          lrx1 <= lrx2 &&
          lry1 <= uly2 &&
          lry1 >= lry2 )); then echo True
  # or the other way around
  elif (( ulx2 >= ulx1 &&
          ulx2 <= lrx1 &&
          uly2 <= uly1 &&
          uly2 >= lry1 )); then echo True
  elif (( ulx2 >= ulx1 &&
          ulx2 <= lrx1 &&
          lry2 <= uly1 &&
          lry2 >= lry1 )); then echo True
  elif (( lrx2 >= ulx1 &&
          lrx2 <= lrx1 &&
          uly2 <= uly1 &&
          uly2 >= lry1 )); then echo True
  elif (( lrx2 >= ulx1 &&
          lrx2 <= lrx1 &&
          lry2 <= uly1 &&
          lry2 >= lry1 )); then echo True
  else echo False
  fi
done < "$1"
