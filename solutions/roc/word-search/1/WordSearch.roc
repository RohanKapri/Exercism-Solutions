module [search]

Position : { column : U64, row : U64 }
WordLocation : { start : Position, end : Position }

Dir : { dc : I64, dr : I64, delta : I64 }

search : Str, List Str -> Dict Str WordLocation
search = |grid, words_to_search_for|
    lines =
        grid
        |> Str.split_on("\n")
        |> List.keep_if(|line| !(Str.is_empty(line)))

    num_rows = List.len(lines)

    # Flat grid and stride
    flat : List U8
    flat = List.walk(lines, [], |acc, line| List.concat(acc, Str.to_utf8(line)))

    stride =
        when List.first(lines) is
            Ok(line) -> List.len(Str.to_utf8(line))
            Err(_) -> 1

    num_cols = stride
    s = Num.to_i64(stride)

    dirs : List Dir
    dirs = [
        { dc: 1,  dr: 0,  delta: 1 },
        { dc: -1, dr: 0,  delta: -1 },
        { dc: 0,  dr: 1,  delta: s },
        { dc: 0,  dr: -1, delta: -s },
        { dc: 1,  dr: 1,  delta: s + 1 },
        { dc: -1, dr: -1, delta: -s - 1 },
        { dc: -1, dr: 1,  delta: s - 1 },
        { dc: 1,  dr: -1, delta: -s + 1 },
    ]

    # Build first-char index: each byte -> list of flat indices
    first_char_idx : Dict U8 (List U64)
    first_char_idx = List.walk_with_index(flat, Dict.empty({}), |dict, byte, idx|
        positions = when Dict.get(dict, byte) is
            Ok(lst) -> lst
            Err(_) -> []
        Dict.insert(dict, byte, List.append(positions, idx))
    )

    List.walk(words_to_search_for, Dict.empty({}), |result_dict, word|
        word_bytes = Str.to_utf8(word)
        word_len = List.len(word_bytes)

        if word_len == 0 || stride == 0 then
            result_dict
        else
            first_byte =
                when List.first(word_bytes) is
                    Ok(b) -> b
                    Err(_) -> 0

            # Only visit cells where first character matches
            candidates =
                when Dict.get(first_char_idx, first_byte) is
                    Ok(lst) -> lst
                    Err(_) -> []

            found = List.walk_until(candidates, Err(NotFound), |_, flat_idx|
                row = flat_idx // stride
                col = flat_idx % stride

                dir_result = List.walk_until(dirs, Err(NotFound), |_, dir|
                    end_row_i = Num.to_i64(row) + dir.dr * Num.to_i64(word_len - 1)
                    end_col_i = Num.to_i64(col) + dir.dc * Num.to_i64(word_len - 1)

                    if end_row_i < 0
                    || end_col_i < 0
                    || Num.to_u64(end_row_i) >= num_rows
                    || Num.to_u64(end_col_i) >= num_cols then
                        Continue(Err(NotFound))
                    else if matches_flat(flat, Num.to_i64(flat_idx), dir.delta, word_bytes, word_len) then
                        loc = {
                            start: { column: col + 1, row: row + 1 },
                            end: { column: Num.to_u64(end_col_i) + 1, row: Num.to_u64(end_row_i) + 1 },
                        }
                        Break(Ok(loc))
                    else
                        Continue(Err(NotFound))
                )

                when dir_result is
                    Ok(loc) -> Break(Ok(loc))
                    Err(_) -> Continue(Err(NotFound))
            )

            when found is
                Ok(loc) -> Dict.insert(result_dict, word, loc)
                Err(_) -> result_dict
    )

matches_flat : List U8, I64, I64, List U8, U64 -> Bool
matches_flat = |flat, start_i, delta, word_bytes, word_len|
    List.walk_until(
        List.range({ start: At(0), end: Before(word_len) }),
        Bool.true,
        |_, i|
            flat_pos = Num.to_u64(start_i + delta * Num.to_i64(i))
            grid_byte = when List.get(flat, flat_pos) is
                Ok(b) -> b
                Err(_) -> 0
            word_byte = when List.get(word_bytes, i) is
                Ok(b) -> b
                Err(_) -> 0
            if grid_byte == word_byte then Continue(Bool.true) else Break(Bool.false),
    )
          