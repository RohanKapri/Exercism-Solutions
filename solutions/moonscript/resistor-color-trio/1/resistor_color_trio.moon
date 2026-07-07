colors = {'black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white'}
map = { c, i - 1 for i, c in ipairs colors }
scale = { '', 'kilo', 'mega', 'giga' }

{
  label: (t, u, n) ->
    val = map[t] * 10 + map[u]
    return "0 ohms" if val == 0
    n = map[n]
    if val % 10 == 0
      val = val // 10
      n += 1
    s = n // 3
    n = n % 3
    while n > 0
      val *= 10
      n -= 1
    "#{val} #{scale[s + 1]}ohms"
}