square_root = (n) ->
  -- find b, the greatest power of 4 <= n
  b = 4 ^ math.floor(math.log n, 4)
  x = 0

  while b != 0
    if n >= x + b
      n -= (x + b)
      x = (x >> 1) + b
    else
      x >>= 1
    b >>= 2

  x

{ sqrt: square_root }