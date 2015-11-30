#!/usr/bin/env bash

LANG=C IFS=

getbyte () {
  read -r -n1 -d "" input
  printf -v "tape[i]" %d "'$input"
}

putbyte () {
  printf -v tmp %o "$(( tape[i] & 255 ))"
  printf %b "\\$tmp"
}

# note to self: extglobs literally kill performance
compile() {
  program=$(tr -dc "[]<>,.+-" <<< "$program")
  program=$(sed "
  # pntlessX: pointless code
  :pntless1
  s/+-//g; s/-+//g; s/<>//g; s/><//g; s/[-+][-+]*z/z/g; s/zzz*/z/g; s/^zz*//
  tpntless1

  s/\[[-+]]/z/g;        # z == zero this cell

  # then optimize a few common constructs

  s/>>>>>>>>>\(z*\)<<<<<<<<</a9|\1|/g;     s/<<<<<<<<<\(z*\)>>>>>>>>>/b9|\1|/g
   s/>>>>>>>>\(z*\)<<<<<<<</a8|\1|/g;       s/<<<<<<<<\(z*\)>>>>>>>>/b8|\1|/g
    s/>>>>>>>\(z*\)<<<<<<</a7|\1|/g;         s/<<<<<<<\(z*\)>>>>>>>/b7|\1|/g
     s/>>>>>>\(z*\)<<<<<</a6|\1|/g;           s/<<<<<<\(z*\)>>>>>>/b6|\1|/g
      s/>>>>>\(z*\)<<<<</a5|\1|/g;             s/<<<<<\(z*\)>>>>>/b5|\1|/g
       s/>>>>\(z*\)<<<</a4|\1|/g;               s/<<<<\(z*\)>>>>/b4|\1|/g
        s/>>>\(z*\)<<</a3|\1|/g;                 s/<<<\(z*\)>>>/b3|\1|/g
         s/>>\(z*\)<</a2|\1|/g;                   s/<<\(z*\)>>/b2|\1|/g
          s/>\(z*\)</a1|\1|/g;                     s/<\(z*\)>/b1|\1|/g
  s/>>>>>>>>>\(+*\)<<<<<<<<</a9|\1|/g;     s/<<<<<<<<<\(+*\)>>>>>>>>>/b9|\1|/g
   s/>>>>>>>>\(+*\)<<<<<<<</a8|\1|/g;       s/<<<<<<<<\(+*\)>>>>>>>>/b8|\1|/g
    s/>>>>>>>\(+*\)<<<<<<</a7|\1|/g;         s/<<<<<<<\(+*\)>>>>>>>/b7|\1|/g
     s/>>>>>>\(+*\)<<<<<</a6|\1|/g;           s/<<<<<<\(+*\)>>>>>>/b6|\1|/g
      s/>>>>>\(+*\)<<<<</a5|\1|/g;             s/<<<<<\(+*\)>>>>>/b5|\1|/g
       s/>>>>\(+*\)<<<</a4|\1|/g;               s/<<<<\(+*\)>>>>/b4|\1|/g
        s/>>>\(+*\)<<</a3|\1|/g;                 s/<<<\(+*\)>>>/b3|\1|/g
         s/>>\(+*\)<</a2|\1|/g;                   s/<<\(+*\)>>/b2|\1|/g
          s/>\(+*\)</a1|\1|/g;                     s/<\(+*\)>/b1|\1|/g
  s/>>>>>>>>>\(-*\)<<<<<<<<</a9|\1|/g;     s/<<<<<<<<<\(-*\)>>>>>>>>>/b9|\1|/g
   s/>>>>>>>>\(-*\)<<<<<<<</a8|\1|/g;       s/<<<<<<<<\(-*\)>>>>>>>>/b8|\1|/g
    s/>>>>>>>\(-*\)<<<<<<</a7|\1|/g;         s/<<<<<<<\(-*\)>>>>>>>/b7|\1|/g
     s/>>>>>>\(-*\)<<<<<</a6|\1|/g;           s/<<<<<<\(-*\)>>>>>>/b6|\1|/g
      s/>>>>>\(-*\)<<<<</a5|\1|/g;             s/<<<<<\(-*\)>>>>>/b5|\1|/g
       s/>>>>\(-*\)<<<</a4|\1|/g;               s/<<<<\(-*\)>>>>/b4|\1|/g
        s/>>>\(-*\)<<</a3|\1|/g;                 s/<<<\(-*\)>>>/b3|\1|/g
         s/>>\(-*\)<</a2|\1|/g;                   s/<<\(-*\)>>/b2|\1|/g
          s/>\(-*\)</a1|\1|/g;                     s/<\(-*\)>/b1|\1|/g

  :pntless2
  s/+\([ab][0-9]|[^|]*|\)-/\1/g;           s/-\([ab][0-9]|[^|]*|\)+/\1/g
  s/+\([ab][0-9]|[^|]*|\)+/++\1/g;         s/-\([ab][0-9]|[^|]*|\)-/--\1/g
  tpntless2

  :pntless3
  s/\([ab][0-9]\)|\([^|]*\)|\1|/\1|\2/g
  tpntless3

  # repeat pntless1, + extra check for something like a7||
  # clean junk generated in pntless3
  :pntless4
  s/+-//g; s/-+//g; s/<>//g; s/><//g; s/[-+][-+]*z/z/g; s/zzz*/z/g; s/^zz*//
  s/\([ab][0-9]\)||//g
  tpntless4

  " <<< "$program")
  program_len=${#program}

  local -i i j count
  local ins

  # emg says that you need to be able to go <
  # HUGE assholes
  echo "go () { tape=() i=1000000000"                            # beginning of function

  while (( i < program_len )); do
    ins=${program:i:1}
    case $ins in
    +|-|">"|"<")                                                 # squeeze these
      for (( count = 1; ++i < program_len; count ++ )); do
        [[ ${program:i:1} = "$ins" ]] || break
      done
      case $ins in
          -) echo "(( tape[i] = (tape[i] - $count) & 255 ))" ;;
          +) echo "(( tape[i] = (tape[i] + $count) & 255 ))" ;;
        ">") echo "(( i += $count ))" ;;
        "<") echo "(( i -= $count ))" ;;
      esac
      ;;
    .) echo putbyte; (( i ++ )) ;;
    ,) echo getbyte; (( i ++ )) ;;
    "[")
                                                                 # optimize multiplication loops
      loop=${program:i+1} loop=${loop%%"]"*}

      if [[ $loop = *[",.["]* ]]; then
        echo "while (( tape[i] )); do"
      else
        left=${loop//[!<]} right=${loop//[!>]}
        if (( ${#left} != ${#right} )); then
          echo "while (( tape[i] )); do"
        else
          min=0 loop_len=${#loop} tape_pos=0                     # 2 steps because array[-1]
          for (( loop_i = 0; loop_i < loop_len; loop_i++)); do
            case ${loop:loop_i:1} in
              "<") (( min = -- tape_pos < min ? tape_pos : min )); ;;
              ">") (( tape_pos ++ )) ;;
              b) (( min = tape_pos - ${loop:loop_i+1:1} < min ? tape_pos - ${loop:loop_i+1:1} : min ))
                                                                 # any other character is skipped
            esac
          done
          starting_pos=${min#-} tape=([starting_pos]=0)
          tape_pos=$starting_pos if=0
          for (( loop_i = 0; loop_i < loop_len; loop_i++)); do   # mini interpreter
            case ${loop:loop_i:1} in
              "<") (( tape_pos -- )) ;;
              ">") (( tape_pos ++ )) ;;
              +) (( tape[tape_pos] = (tape[tape_pos] + 1) & 255 )) ;;
              -) (( tape[tape_pos] = (tape[tape_pos] - 1) & 255 )) ;;
              z) tape[tape_pos]=0 ; if=1 ;;
              a|b) jump=${loop:loop_i+1:1}
                 [[ ${loop:loop_i:1} = a ]] && dire=+ || dire=-
                 (( tape_pos $dire= jump, loop_i += 3 ))         # now we're past |
                 while :; do
                   case ${loop:loop_i:1} in
                     +) (( tape[tape_pos] ++ )) ;;
                     -) (( tape[tape_pos] -- )) ;;
                     z) tape[tape_pos]=0 ; if=1 ;;
                     *) break
                   esac
                   (( loop_i ++ ))
                 done
                 if [[ $dire = + ]]; then (( tape_pos -= jump ))
                 else (( tape_pos += jump ))
                 fi
                 ;;
            esac
          done
          strings=()
          case ${tape[starting_pos]} in                          # +/-1 == optimize it away
            1) for position in "${!tape[@]}"; do
                 (( tape[position] *= -1 ))                      # convert [+>--<] to [->++<]
               done ;&
            255) for position in "${!tape[@]}"; do
                   offset=$((position-starting_pos)) string=
                   case $offset in
                     0) continue ;;
                     [!-]*) offset=+$offset ;&
                     *) string="tape[i$offset] = " ;;
                   esac
                   if (( tape[position] == 0 )); then
                     string+=0
                   elif (( tape[position] > 0 )); then
                     string+="(tape[i$offset] + tape[i] * ${tape[position]}) & 255"
                   else
                     string+="(tape[i$offset] - tape[i] * ${tape[position]#-}) & 255"
                   fi
                   strings+=("$string")
                 done
                 (( if )) && echo "if (( tape[i] )); then"
                 printf "(( ${strings[0]//" * 1)"/)} "
                 for string in "${strings[@]:1}"; do
                   printf ")) ; (( ${string//" * 1)"/)} "
                 done
                 echo ")) ; (( tape[i] = 0 ))"
                 (( if )) && echo fi
                 (( i += ${#loop} + 1 ))
              ;;
            0) for position in "${!tape[@]}"; do
                 offset=$((position-starting_pos)) string=
                 case $offset in
                   0) continue ;;
                   [!-]*) offset=+$offset ;&
                   *) string="tape[i$offset] = " ;;
                 esac
                 if (( tape[position] == 0 )); then
                   string+=0
                 elif (( tape[position] > 0 )); then
                   string+="(tape[i$offset] + ${tape[position]}) & 255"
                 else
                   string+="(tape[i$offset] - ${tape[position]#-}) & 255"
                 fi
                 strings+=("$string")
               done
               if (( if )); then
                 echo "if (( tape[i] )); then"
               else
                 echo "while (( tape[i] )); do"
               fi
               printf "(( ${strings[0]//" * 1)"/)} "
               for string in "${strings[@]:1}"; do
                 printf ")) ; (( ${string//" * 1)"/)} "
               done
               if (( if )); then
                 echo ")) ; (( tape[i] = 0 )); fi"
                 (( i += ${#loop} + 1 ))
               else
                 (( i += ${#loop} ))
                 echo "))"
               fi
               ;;
            *) echo "while (( tape[i] )); do"               # so much work for nothing
          esac
        fi
      fi


         [[ ${program:(++i):1} = "]" ]] && echo ":;" ;;          # syntax error without this
    "]") echo done; (( i ++ ))
       ;;
    a|b) count=${program:(++i):1} op=${program:(++i,++i):1}
         for (( incrcount = 1; ++i < program_len; incrcount ++ )); do
           [[ ${program:i:1} = [z+-] ]] || break
         done
         (( i++ ))                                               # skip the | separator
         if [[ $op = z ]]; then
           case $ins in
             a) echo "(( tape[i+$count] = 0 ))" ;;
             b) echo "(( tape[i-$count] = 0 ))" ;;
           esac
         else
           case $ins in
             a) echo "(( tape[i+$count] = (tape[i+$count] $op $incrcount) & 255 ))" ;;
             b) echo "(( tape[i-$count] = (tape[i-$count] $op $incrcount) & 255 ))" ;;
           esac
         fi
         ;;
    z) for (( count = 0; ++i < program_len; count ++ )); do      # optimize [-]++++
         [[ ${program:i:1} = [+-] ]] || break
       done
       echo "tape[i]=$((count & 255))"
       ;;
    esac
  done
  echo }                                                         # end of function
}


while read -r program || [[ $program ]]; do # assholes
  eval "$(compile)"
  go
  echo
done < "$1"
