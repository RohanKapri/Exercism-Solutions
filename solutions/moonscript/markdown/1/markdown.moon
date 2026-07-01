check_h = (line) ->
  n = #line
  i = 1
  while i <= n
    if line\sub(i, i) != "#"
      break
    i += 1
  i -= 1
  if 1 <= i and i <= 6
    j = i + 1
    while j <= n and line\sub(j, j) == " "
      j += 1
    "<h#{i}>#{line\sub(j, n)}</h#{i}>"

check_li = (line) ->
  if line\sub(1, 2) == "* "
    "<li>#{line\sub(3)}</li>"

make_p = (line) ->
  "<p>#{line}</p>"

parse_line_li = (line) ->
  with res_h = check_h line
    return res_h, false if res_h
  with res_li = check_li line
    return res_li, true if res_li
  make_p(line), false

{
  parse: (input) ->
    p1 = input\gsub("__([^_]*)__", "<strong>%1</strong>")
    p2 = p1\gsub("_([^_]*)_", "<em>%1</em>")

    in_li = false
    lines = for line in p2\gmatch("[^\n]+")
      res, is_li = parse_line_li line
      if is_li and not in_li
        in_li = true
        res = "<ul>" .. res
      elseif not is_li and in_li
        in_li = false
        res = "</ul>" .. res
      res
    table.insert lines, "</ul>" if in_li
    table.concat lines
}