public function tick(sequence matrix)
  sequence res = matrix
  for i = 1 to length(matrix) do
    for j = 1 to length(matrix[i]) do
      res[i][j] = 0
      atom neighbors = 0
      for k = -1 to 1 do
        for l = -1 to 1 do
          if (k != 0 or l != 0) and i + k >= 1 and i + k <= length(matrix) and j + l >= 1 and j + l <= length(matrix[i]) then
            neighbors += matrix[i + k][j + l]
          end if
        end for
      end for
      if neighbors = 3 or (matrix[i][j] = 1 and neighbors = 2) then
        res[i][j] = 1
      end if
    end for
  end for
  return res
end function