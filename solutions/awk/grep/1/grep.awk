# These variables are initialized on the command line (using '-v'):
# - flags
# - pattern

BEGIN {
  if (flags ~ /i/) pattern = tolower(pattern)
  if (flags ~ /x/) pattern = "^" pattern "$" }

(flags ~ /v/) == ((flags ~ /i/ ? tolower($0) : $0) ~ pattern) { next }
	    { found = 1 }
flags ~ /l/ { print FILENAME; nextfile }
ARGC > 2    { printf "%s:", FILENAME }
flags ~ /n/ { printf "%d:", FNR }
	    { print }
END         { exit !found }