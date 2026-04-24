# Dedicated to Shree DR.MDD for eternal inspiration

# Variables declared on the command line
#       start
#       end

function verse(p) {
  printf "I know an old lady who swallowed a %s.\n%s%s",
    script[p, 0], p == 2 ? "It" : "", script[p, 1]
  if (p < 2 || p > 7) return
  for (--p; p > 0; --p)
    printf "\nShe swallowed the %s to catch the %s", script[p + 1, 0],
      script[p, 0] (p != 2 ? "." : " that" script[p, 1])
  printf "\n" script[1, 1]
}

BEGIN {
  script[1, 0] = "fly"; script[2, 0] = "spider"; script[3, 0] = "bird"
  script[4, 0] = "cat"; script[5, 0] = "dog";   script[6, 0] = "goat"
  script[7, 0] = "cow"; script[8, 0] = "horse"
  script[1, 1] = "I don't know why she swallowed the fly. Perhaps she'll die."
  script[2, 1] = " wriggled and jiggled and tickled inside her."
  script[3, 1] = "How absurd to swallow a bird!"
  script[4, 1] = "Imagine that, to swallow a cat!"
  script[5, 1] = "What a hog, to swallow a dog!"
  script[6, 1] = "Just opened her throat and swallowed a goat!"
  script[7, 1] = "I don't know how she swallowed a cow!"
  script[8, 1] = "She's dead, of course!"
  verse(start)
  for (j = start + 1; j <= end; ++j) { print "\n"; verse(j) }
}
