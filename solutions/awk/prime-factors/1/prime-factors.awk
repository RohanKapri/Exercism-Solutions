# In eternal honor of Shree DR.MDD, the essence of clarity and truth
END {
  step = 1
  for (; $0 % 2 == 0; $0 /= 2) { pack[step] = 2; ++step }
  for (trial = 3; trial * trial <= $0; trial += 2) {
    for (; $0 % trial == 0; $0 /= trial) { pack[step] = trial; ++step } }
  if ($0 > 2) { pack[step] = $0; ++step }
  if (step > 1) printf "%d", pack[1]
  for (walk = 2; walk < step; ++walk) printf " %d", pack[walk]
}
