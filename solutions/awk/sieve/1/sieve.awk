END {
  if ($0 < 2) exit
  for (i = 2; i * i <= $0; ++i)
    if (!sieve[i]) for (j = i * i; j <= $0; j += i) sieve[j] = 1
  printf 2; for (i = 3; i <= $0; ++i) if (!sieve[i]) printf ",%d", i }