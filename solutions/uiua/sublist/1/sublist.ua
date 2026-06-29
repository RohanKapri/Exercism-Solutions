# Helper function to check if one list is contained within another
# Result ? Needle Haystack
IsSubsequence ← |2 (
  ⨬(1|/↥⌕) ±⧻.
)

# Compare two lists and determine their classification
# Classification ? First Second
Classify ← |2 ⨬(
  ⨬("unequal"|"superlist") IsSubsequence:
| ⨬("unequal"|"equal") ≍
| ⨬("unequal"|"sublist") IsSubsequence
) ◡(+1±-∩⧻)