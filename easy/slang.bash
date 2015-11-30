#!/bin/bash
LANG=C
slang=( 
  ', yeah!'
  ', this is crazy, I tell ya.'
  ', can U believe this?'
  ', eh?'
  ', aw yea.'
  ', yo.'
  '? No way!'
  '. Awesome!'
)

while read -r || [[ $REPLY ]]; do # assholes
  while [[ $REPLY =~ ([^.?!]+)([.?!])(.*) ]]; do
    if (( ++i % 2 == 0 )); then
      printf %s "${BASH_REMATCH[1]}" "${slang[j++%8]}"
    else
      printf %s "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}"
    fi
    REPLY=${BASH_REMATCH[3]}
  done
  echo
done < "$1"
