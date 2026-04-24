function ay(s, i) {
  if (NR > 1) printf " "; printf substr(s, i) substr(s, 1, i - 1) "ay" }

BEGIN                  { RS = "[[:space:]]+" }
/^([aeiou]|xr|yt)/     { ay($0, 1); next }
/^[^aeiou][^aeiouy]*y/ { match($0, /y/); ay($0, RSTART); next }
/^[^aeiou]*qu/         { match($0, /qu/); ay($0, RSTART + 2); next }
                       { match($0, /[aeiou]/); ay($0, RSTART) }