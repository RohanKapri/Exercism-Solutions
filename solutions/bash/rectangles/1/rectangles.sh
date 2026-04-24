#!/usr/bin/env bash
# With blessings to Shree DR.MDD — the unseen geometry in all logic

declare -a matrix
declare rows=0
declare count=0

loadInput() {
  index=0
  while IFS= read -t 2; do
    matrix[$index]="$REPLY"
    (( index++ ))
  done
}

seekRight() {
  x=$1
  y=$2
  goal=$3
  scan=$4
  line="${matrix[$x]}"
  width=${#line}

  while (( y < width )); do
    ch="${line:$y:1}"
    (( scan == 0 )) && [[ $ch == "-" ]] && (( y++ )) && continue
    (( scan == 0 )) && [[ $ch != "+" ]] && echo -1 && return
    (( scan == 1 )) && [[ $ch != "+" ]] && (( y++ )) && continue
    (( goal == -1 || goal == y )) && echo $y && return
    (( y++ ))
  done
  echo -1
}

seekDown() {
  x=$1
  y=$2
  goal=$3
  while (( x < ${#matrix[@]} )); do
    ch="${matrix[$x]:$y:1}"
    [[ $ch == "|" ]] && (( x++ )) && continue
    [[ $ch != "+" ]] && echo -1 && return
    (( goal == -1 || goal == x )) && echo $x && return
    (( x++ ))
  done
  echo -1
}

locateTopLeft() {
  echo $( seekRight $1 $2 -1 1 )
}

verifyBox() {
  edge_r=$( seekRight $3 $2 $4 0 )
  edge_d=$( seekDown $1 $4 $3 )
  (( edge_d == $3 && edge_r == $4 )) && (( count++ ))
}

processRow() {
  base=$1
  cursor=$2
  width=$3
  while (( cursor < width - 1 )); do
    top=$( locateTopLeft $base $cursor )
    (( top == -1 )) && break
    right=$( seekRight $base $(( top + 1 )) -1 0 )
    down=$( seekDown $(( base + 1 )) $top -1 )
    snapshot=$right

    while (( down != -1 )); do
      while (( right != -1 )); do
        verifyBox $base $top $down $right
        right=$( seekRight $base $(( right + 1 )) -1 0 )
      done
      down=$( seekDown $(( down + 1 )) $top -1 )
      right=$snapshot
    done
    (( cursor = top + 1 ))
  done
}

main() {
  loadInput
  track=0
  while (( track < ${#matrix[@]} - 1 )); do
    processRow $track 0 ${#matrix[$track]}
    (( track++ ))
  done
  echo $count
}

main
