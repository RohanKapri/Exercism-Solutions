BEGIN {
  a["Mercury"] = 0.2408467; a["Venus"] = 0.61519726; a["Earth"] = 1
  a["Mars"] = 1.8808158; a["Jupiter"] = 11.862615
  a["Saturn"] = 29.447498; a["Uranus"] = 84.016846
  a["Neptune"] = 164.79132 }

!($1 in a) { print "not a planet"; exit 1 }

{ printf "%.2f\n", $2 / a[$1] / 31557600 }