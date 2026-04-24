#!/usr/bin/env bash

declare -A num_map=(
  [0]=no
  [1]=one
  [2]=two
  [3]=three
  [4]=four
  [5]=five
  [6]=six
  [7]=seven
  [8]=eight
  [9]=nine
  [10]=ten
)

verse() {
  start="${num_map[$1]}"
  end="${num_map[$(($1 - 1))]}"

  bottle_1=$( (($1 == 1)) && echo "bottle" || echo "bottles")
  bottle_2=$( (($1 - 1 == 1)) && echo "bottle" || echo "bottles")

  cat <<END
${start^} green $bottle_1 hanging on the wall,
${start^} green $bottle_1 hanging on the wall,
And if one green bottle should accidentally fall,
There'll be $end green $bottle_2 hanging on the wall.

END
}

die() {
  >&2 echo "$1"
  exit 1
}

[[ "$#" -ne 2 ]] && die "2 arguments expected"
(($1 < $2)) && die "cannot generate more verses than bottles"

for ((i = $1; i > $1 - $2; i--)); do
  verse "$i"
done