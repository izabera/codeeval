#!/bin/bash
LANG=C

# stupid way: create a string then eval it

#set -f
#q () {
#  case $# in
#    2) ret=()
#       for op in + - *; do
#         ret+=("($1 $op $2)" "($2 $op $1)")
#       done ;;
#    *) local tmp i
#       for (( i = 1; i <= $#; i++ )) do
#         q "${@:1:i-1}" "${@:i+1}"
#         for op in + - *; do
#           for res in "${ret[@]}"; do
#             tmp+=("($res $op ${!i})")
#           done
#         done
#       done
#       ret=("${tmp[@]}") ;;
#  esac
#}
#
#while read -ra arr || [[ $arr ]]; do
#  q "${arr[@]}"
#  for res in "${ret[@]}"; do
#    if (( $res == 42 )); then
#      echo YES
#      continue 2
#    fi
#  done
#  echo NO
#done < "$1"


# ok it turns out the stupid way is too slow
# let's use the stupid^2 way
bcscript=$(mktemp)
{
  printf '%s\n' {a..e}{+,-,"*"} |
  sed -n '
  /a/!{h;s/$/a)/p;x}
  /b/!{h;s/$/b)/p;x}
  /c/!{h;s/$/c)/p;x}
  /d/!{h;s/$/d)/p;x}
  /e/!{h;s/$/e)/p;x}' |
  sed 's/$/+/p;s/+$/-/p;s/-$/*/' |
  sed -n '
  /a/!{h;s/$/a)/p;x}
  /b/!{h;s/$/b)/p;x}
  /c/!{h;s/$/c)/p;x}
  /d/!{h;s/$/d)/p;x}
  /e/!{h;s/$/e)/p;x}' |
  sed 's/$/+/p;s/+$/-/p;s/-$/*/' |
  sed -n '
  /a/!{h;s/$/a)/p;x}
  /b/!{h;s/$/b)/p;x}
  /c/!{h;s/$/c)/p;x}
  /d/!{h;s/$/d)/p;x}
  /e/!{h;s/$/e)/p;x}' |
  sed 's/$/+/p;s/+$/-/p;s/-$/*/' |
  sed -n '
  /a/!{h;s/$/a)/p;x}
  /b/!{h;s/$/b)/p;x}
  /c/!{h;s/$/c)/p;x}
  /d/!{h;s/$/d)/p;x}
  /e/!{h;s/$/e)/p;x}' |
  sed -n '
  /).*).*).*)/{s/^/((((/p;b}
  /).*).*)/{s/^/(((/p;b}
  /).*)/{s/^/((/p;b}
  /)/s/^/(/p' |
  sed 's/^/if ( /;s/$/ == 42 ) { "YES\n"; halt }/'
  printf '"NO\n"\n'
} > "$bcscript"

while read -r a b c d e || [[ $a ]]; do
  bc <(printf 'a=%d\nb=%d\nc=%d\nd=%d\ne=%d\n' "$a" "$b" "$c" "$d" "$e") < "$bcscript"
done < "$1"
rm "$bcscript"

