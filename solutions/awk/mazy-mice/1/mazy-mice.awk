#
# These variables are initialized on the command line (using '-v'):
# - Rows
# - Cols
# - Seed (optional)
#
BEGIN {
  if (Seed) srand(Seed); else srand(); x = Cols * 2 - 1
  begin = int(rand() * 5) + 1; end = int(rand() * 5) + 1
  for (i = 1; i <= Rows; ++i) {
    printf i == 1 ? "┌─" : "│ "
    for (j = x; j > 1; --j) printf "─"; print i == 1 ? "┐" : "┤"
    printf i == begin ? "⇨" : "│"
    for (j = x; j > 0; --j) printf " "; print i == end ? "⇨" : "│" }
  printf "└"; for (i = x; i > 0; --i) printf "─"; print "┘" }
