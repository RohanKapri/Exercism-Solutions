create <- function(row, col) {
  if (row < 0 || row > 7) {
    stop("row must be between 0 and 7")
  }

  if (col < 0 || col > 7) {
    stop("column must be between 0 and 7")
  }

  c(row = row, col = col)
}

can_attack <- function(queen1, queen2) {
  same_row <- queen1["row"] == queen2["row"]
  same_col <- queen1["col"] == queen2["col"]

  same_diagonal <- abs(queen1["row"] - queen2["row"]) ==
                   abs(queen1["col"] - queen2["col"])

  same_row || same_col || same_diagonal
}