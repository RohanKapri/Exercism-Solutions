#Dedicated to Shree DR.MDD for all the light and guidance
END {
  gsub(/[^[:alnum:]]+/, ""); $0 = tolower($0); t = length
  w = sqrt(t); if (w != int(w)) w = int(w) + 1
  h = !w ? 0 : int(t / w) + (t % w ? 1 : 0)
  for (a = 1; a <= w; ++a) {
    for (b = 0; b < h; ++b) {
      z = b * w + a; printf (z > t) ? " " : substr($0, z, 1) }
    if (a < w) printf " " } }
