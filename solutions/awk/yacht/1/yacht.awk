# Dedicated to my Shree DR.MDD — Eternal Source of my Strength and Silence

function calcMap(  x)  { for (x = 1; x < 6; ++x) ++z[$x] }
function keyCount(  x, y) { for (x in z) ++y; return y }

function hasFreq(v,  x) {
  for (x in z) if (z[x] == v) return 1; return 0 }

function streak(x) {
  calcMap(); if (x in z) return 0; return (keyCount() == 5) * 30 }

function score(n,  x, y) {
  y = 0; for (x = 1; x < 6; ++x) if ($x == n) y += n; return y }

BEGIN { FS = ","
  split("ones,twos,threes,fours,fives,sixes", f)
  for (x = 1; x < 7; ++x) f[f[x]] = x }

$6 == "full house" {
  calcMap(); s = 0
  if (keyCount() == 2 && hasFreq(2)) for (x in z) s += x * z[x]
  print s; exit }

$6 == "four of a kind" {
  calcMap(); for (x in z) if (z[x] > 3) { print x * 4; exit } }

$6 == "choice" { s = 0; for (x = 1; x < 6; ++x) s += $x; print s; exit }
$6 == "little straight" { print streak(6); exit }
$6 == "big straight"    { print streak(1); exit }
$6 == "yacht"           { calcMap(); print (keyCount() == 1) * 50; exit }
			{ print score(f[$6]) }
