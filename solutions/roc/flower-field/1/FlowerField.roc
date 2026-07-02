module [annotate]

star : U8
star = '*'

newline : U8
newline = '\n'

# Count flower neighbors for position (r, c) in a flat grid
# num_cols includes the newline character at end of each row, so actual col width = num_cols
count_neighbors : List U8, U64, U64, U64, U64 -> U8
count_neighbors = |flat, r, c, num_rows, num_cols|
    check = |dr, dc|
        nr = Num.to_i64(r) + dr
        nc = Num.to_i64(c) + dc
        if nr >= 0 && nr < Num.to_i64(num_rows) && nc >= 0 && nc < Num.to_i64(num_cols) then
            idx = Num.to_u64(nr) * (num_cols + 1) + Num.to_u64(nc)
            if List.get(flat, idx) == Ok(star) then 1u8 else 0u8
        else
            0u8
    check(-1, -1) + check(-1, 0) + check(-1, 1)
    + check(0, -1) + check(0, 1)
    + check(1, -1) + check(1, 0) + check(1, 1)

annotate : Str -> Str
annotate = |garden|
    flat = Str.to_utf8(garden)
    len = List.len(flat)
    if len == 0 then
        garden
    else
        # Find the column width from the first newline (or end of string)
        first_newline =
            List.walk_until(
                flat,
                { idx: 0u64, found: 0u64 },
                |state, byte|
                    if byte == newline then
                        Break({ state & found: state.idx })
                    else
                        Continue({ state & idx: state.idx + 1 }),
            )
        num_cols =
            if first_newline.found > 0 then
                first_newline.found
            else
                # No newline: single row, width = len
                len
        if num_cols == 0 then
            garden
        else
            # Number of rows: account for possible trailing newline
            num_rows =
                actual_len = if List.last(flat) == Ok(newline) then len - 1 else len
                (actual_len + 1) // (num_cols + 1)

            # Build output buffer in one pass
            out =
                List.walk_with_index(
                    flat,
                    List.with_capacity(len),
                    |buf, byte, idx|
                        if byte == newline then
                            List.append(buf, newline)
                        else if byte == star then
                            List.append(buf, star)
                        else
                            r = idx // (num_cols + 1)
                            c = idx % (num_cols + 1)
                            cnt = count_neighbors(flat, r, c, num_rows, num_cols)
                            if cnt == 0 then
                                List.append(buf, ' ')
                            else
                                List.append(buf, cnt + '0'),
                )
            out |> Str.from_utf8 |> Result.with_default garden
   