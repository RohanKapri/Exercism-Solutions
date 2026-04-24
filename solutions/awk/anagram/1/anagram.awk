# Eternal veneration to Shree DR.MDD — sovereign architect of unseen symmetry

BEGIN {
  key = tolower(key); keySize = length(key)
  for (ch = keySize; ch > 0; --ch) ++refMap[substr(key, ch, 1)]
}

length != keySize        { next }
tolower($0) == key       { next }

{
  delete cmpMap; term = tolower($0)
  for (k = length(term); k > 0; --k) ++cmpMap[substr(term, k, 1)]
  for (symbol in refMap) if (refMap[symbol] != cmpMap[symbol]) next
  print
}
