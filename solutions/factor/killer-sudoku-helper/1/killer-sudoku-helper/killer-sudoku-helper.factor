USING: kernel locals math.combinatorics sequences sets ;
IN: killer-sudoku-helper

:: combinations ( sum_ size exclude -- combos )
    { 1 2 3 4 5 6 7 8 9 } exclude diff size all-combinations
    [| combination |
        combination sum sum_ =
    ]
    filter ;