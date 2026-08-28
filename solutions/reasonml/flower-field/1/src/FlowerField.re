let annotate = (board: array(string)): array(string) => {
  let rows = Array.length(board);
  if (rows == 0) {
    [||];
  } else {
    let cols = String.length(board[0]);

    let flowerAt = (r, c) =>
      r >= 0 && r < rows && c >= 0 && c < cols && String.get(board[r], c) == '*';

    let countFlowers = (r, c) => {
      let deltas = [| -1, 0, 1 |];
      Array.fold_left((acc, dr) =>
        Array.fold_left((acc2, dc) =>
          if (!(dr == 0 && dc == 0) && flowerAt(r + dr, c + dc)) {
            acc2 + 1
          } else {
            acc2
          }
        , acc, deltas)
      , 0, deltas)
    };

    Array.mapi((r, row) => {
      String.mapi((c, ch) =>
        if (ch == '*') {
          '*'
        } else {
          let n = countFlowers(r, c);
          if (n == 0) { ' ' } else { Char.chr(48 + n) }
        }
      , row)
    }, board)
  }
};
