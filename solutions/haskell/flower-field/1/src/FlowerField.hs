module FlowerField (annotate) where

import Data.Char (intToDigit)

annotate :: [String] -> [String]
annotate board = 
    [ [ annotateCell r c | c <- [0..colCount - 1] ] | r <- [0..rowCount - 1] ]
  where
    rowCount = length board
    colCount = if rowCount == 0 then 0 else length (head board)

    -- Access a cell safely using coordinates. Returns ' ' if out of bounds.
    getCell :: Int -> Int -> Char
    getCell r c
      | r < 0 || r >= rowCount || c < 0 || c >= colCount = ' '
      | otherwise = (board !! r) !! c

    -- Processes an individual cell coordinate
    annotateCell :: Int -> Int -> Char
    annotateCell r c
      | getCell r c == '*' = '*'
      | count == 0         = ' '
      | otherwise          = intToDigit count
      where
        -- Count how many of the 8 neighbors are flowers
        count = length [ () | dr <- [-1..1]
                            , dc <- [-1..1]
                            , (dr /= 0 || dc /= 0)
                            , getCell (r + dr) (c + dc) == '*' ]