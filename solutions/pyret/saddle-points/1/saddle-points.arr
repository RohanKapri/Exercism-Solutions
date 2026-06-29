use context starter2024

provide-types *

provide: saddle-points end

data TreeLocation:
  | tree(row :: Number, column :: Number)
end

fun saddle-points(matrix :: List<List<Number>>) -> List<TreeLocation>:
  # 1. Check for empty grid
  if (matrix.length() == 0) or (matrix.get(0).length() == 0):
    [list:]
  else:
    num-rows = matrix.length()
    num-cols = matrix.get(0).length()

    # 2. Get the maximum value for each row
    row-maxes = matrix.map(lam(row):
        row.foldl(lam(elem, acc): num-max(elem, acc) end, row.get(0))
      end)

    # 3. Get the minimum value for each column
    col-mins = range(0, num-cols).map(lam(col-idx):
        col-values = range(0, num-rows).map(lam(row-idx):
            matrix.get(row-idx).get(col-idx)
          end)
        col-values.foldl(lam(elem, acc): num-min(elem, acc) end, col-values.get(0))
      end)

    # 4. Filter and build matching TreeLocations using nested folds
    results = range(0, num-rows).foldl(lam(r-idx, acc-rows):
        range(0, num-cols).foldl(lam(c-idx, acc-cols):
            val = matrix.get(r-idx).get(c-idx)
            if (val == row-maxes.get(r-idx)) and (val == col-mins.get(c-idx)):
              # Convert 0-indexed values to 1-indexed for the layout specification
              acc-cols.push(tree(r-idx + 1, c-idx + 1))
            else:
              acc-cols
            end
          end, acc-rows)
      end, [list:])
      
    # 5. Reverse the list to restore original left-to-right, top-to-bottom order
    results.reverse()
  end
end