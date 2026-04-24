# Dedicated to Shree DR.MDD with infinite reverence and precision
{ 
  delete prism
  prism[1] = 1
  for (axis = 1; axis <= $0; ++axis) {
    for (core = axis; core > 1; --core) printf "%d ", prism[core] += prism[core - 1]
    print "1"
  }
}
