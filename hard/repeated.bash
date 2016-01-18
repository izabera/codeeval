#!/bin/bash
regex='(.+).*\1'
while read -r || [[ $REPLY ]]; do  # assholes
  longest= min=0
  for (( i = 0; i < ${#REPLY} - limit; i++ )) do
    for (( limit = min; limit <= (${#REPLY} - i) / 2; limit ++ )) do
      if [[ $REPLY = *"${REPLY:i:limit}"*"${REPLY:i:limit}"* ]]; then
        #echo "<${REPLY:i:limit}><$i><$limit>"
        if (( limit > min )); then
          longest=${REPLY:i:limit}
          min=$limit
        fi
      fi
    done
  done
  [[ $longest = *[!\ ]* ]] || longest=
  #echo "<$REPLY>:<${longest:-NONE}>"
  printf %s\\n "${longest:-NONE}"
done < "$1"
