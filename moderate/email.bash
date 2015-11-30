#!/bin/bash
LANG=C
str='[[:alnum:]!#$%&'\''*+/=?^_`{|}~-]+'
ip='\[([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|IPv6:[[:xdigit:]]{0,4}:([[:xdigit:]]{0,4}:){0,6}[[:xdigit:]])]'
regex='^("([^\\"]|\\.)*"|'$str'(\.'$str')*)@('$ip'|[[:alnum:]_-]+(\.[[:alnum:]_-]+)*)$'
while read -r; do
  [[ $REPLY =~ $regex ]] && echo true || echo false
done < "$1"
