#!/bin/bash
LANG=C

#     30
#     |
#   ____
#   |   |
#   8   52
#   |
# ____
# |   |
# 3  20
#     |
#    ____
#   |   |
#   10 29

# hardcoded tree?  ok, hardcoded lookup table
#    |  3  8 10 20 29 30 52
# ---+---------------------
#  3 |  3
#  8 |  8  8
# 10 |  8  8 10
# 20 |  8  8 20 20
# 29 |  8  8 20 20 29
# 30 | 30 30 30 30 30 30
# 52 | 30 30 30 30 30 30 52

table=(
  [ 3* 3]=3
  [ 3* 8]=8  [ 8* 8]=8
  [ 3*10]=8  [ 8*10]=8  [10*10]=10
  [ 3*20]=8  [ 8*20]=8  [10*20]=20 [20*20]=20
  [ 3*29]=8  [ 8*29]=8  [10*29]=20 [20*29]=20 [29*29]=29
  [ 3*30]=30 [ 8*30]=30 [10*30]=30 [20*30]=30 [29*30]=30 [30*30]=30
  [ 3*52]=30 [ 8*52]=30 [10*52]=30 [20*52]=30 [29*52]=30 [30*52]=30 [52*52]=52
)
while read -r a b; do echo "${table[a*b]}"; done < "$1"