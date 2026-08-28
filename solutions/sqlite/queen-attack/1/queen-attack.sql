update "queen-attack"
set error = case
    when black_row < 0 or white_row < 0 then 'row not positive'
    when black_col < 0 or white_col < 0 then 'column not positive'
    when black_row > 7 or white_row > 7 then 'row not on board'
    when black_col > 7 or white_col > 7 then 'column not on board'
end;

update "queen-attack"
set result = white_row = black_row 
    or white_col = black_col
    or black_row - black_col = white_row - white_col
    or black_row + black_col = white_row + white_col
where error is null;