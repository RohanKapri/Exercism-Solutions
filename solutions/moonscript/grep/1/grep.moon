file_util = require 'pl.file'

grep = (options, pattern, ...) ->
  files = { ... }
  
  has_n = false
  has_l = false
  has_i = false
  has_v = false
  has_x = false

  for opt in *options
    switch opt
      when '-n' then has_n = true
      when '-l' then has_l = true
      when '-i' then has_i = true
      when '-v' then has_v = true
      when '-x' then has_x = true

  search_term = if has_i then pattern\lower! else pattern
  multi_file = #files > 1
  results = {}

  for filename in *files
    content = file_util.read filename
    if not content
      continue

    -- Split content into clean lines without trailing CR/LF artifacts
    lines = {}
    for line in (content .. "\n")\gmatch "([^\r\n]*)\r?\n"
      table.insert lines, line

    for line_number, line in ipairs lines
      comp_line = if has_i then line\lower! else line

      is_match = false
      if has_x
        is_match = (comp_line == search_term)
      else
        is_match = (comp_line\find(search_term, 1, true) != nil)

      if has_v
        is_match = not is_match

      if is_match
        if has_l
          table.insert results, filename
          break
        else
          formatted = ""
          if multi_file
            formatted ..= filename .. ":"
          if has_n
            formatted ..= tostring(line_number) .. ":"
          formatted ..= line
          table.insert results, formatted

  results

{ :grep }