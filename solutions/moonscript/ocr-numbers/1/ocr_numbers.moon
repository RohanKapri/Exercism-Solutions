DIGIT_PATTERNS = {
  " _ | ||_|   ": "0"
  "     |  |   ": "1"
  " _  _||_    ": "2"
  " _  _| _|   ": "3"
  "   |_|  |   ": "4"
  " _ |_  _|   ": "5"
  " _ |_ |_|   ": "6"
  " _   |  |   ": "7"
  " _ |_||_|   ": "8"
  " _ |_| _|   ": "9"
}

convert = (rows) ->
  num_lines = #rows
  if num_lines % 4 != 0
    error 'Number of input lines is not a multiple of four'

  for row in *rows
    if #row % 3 != 0
      error 'Number of input columns is not a multiple of three'

  result_lines = {}

  for line_idx = 1, num_lines, 4
    cols = #rows[line_idx]
    
    -- Ensure all 4 rows in this section have the exact same width
    for r = line_idx, line_idx + 3
      if #rows[r] != cols
        error 'Number of input columns is not a multiple of three'

    line_digits = {}
    num_digits = cols / 3

    for d = 0, num_digits - 1
      start_col = d * 3 + 1
      end_col = start_col + 2

      -- Extract 3x4 grid pattern
      pattern = ""
      for r = line_idx, line_idx + 3
        pattern ..= rows[r]\sub(start_col, end_col)

      digit = DIGIT_PATTERNS[pattern] or "?"
      table.insert line_digits, digit

    table.insert result_lines, table.concat(line_digits, "")

  table.concat result_lines, ","

{
  :convert
}