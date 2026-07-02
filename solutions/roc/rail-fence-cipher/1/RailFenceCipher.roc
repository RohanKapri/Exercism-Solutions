module [encode, decode]

encode : Str, U64 -> Result Str _
encode = \message, rails ->
    if rails <= 1 then
        Ok(message)
    else
        chars = Str.to_utf8(message)
        len = List.len(chars)
        
        if len == 0 then
            Ok(message)
        else
            encode_fast(chars, rails, len)

decode : Str, U64 -> Result Str _
decode = \encrypted, rails ->
    if rails <= 1 then
        Ok(encrypted)
    else
        chars = Str.to_utf8(encrypted)
        len = List.len(chars)
        
        if len == 0 then
            Ok(encrypted)
        else
            decode_fast(chars, rails, len)

encode_fast : List U8, U64, U64 -> Result Str _
encode_fast = \chars, rails, _len ->
    cycle = (rails - 1) * 2
    
    indexed = List.map_with_index(chars, \char, idx ->
        rail = calculate_rail_inline(idx, rails, cycle)
        { char, pos: rail }
    )
    
    sorted = List.sort_with(indexed, \a, b -> Num.compare(a.pos, b.pos))
    
    result = List.map(sorted, \item -> item.char)
    Str.from_utf8(result)

decode_fast : List U8, U64, U64 -> Result Str _
decode_fast = \chars, rails, len ->
    cycle = (rails - 1) * 2
    
    positions = List.map_with_index(
        List.range({ start: At(0), end: Before(len) }),
        \_val, idx ->
            rail = calculate_rail_inline(idx, rails, cycle)
            { orig_pos: idx, rail }
    )
    
    sorted_positions = List.sort_with(positions, \a, b -> Num.compare(a.rail, b.rail))
    
    position_map = List.map(sorted_positions, \item -> item.orig_pos)
    
    result = List.map_with_index(position_map, \_pos, char_idx ->
        when List.get(chars, char_idx) is
            Ok(char) -> char
            Err(_) -> 0
    )
    
    reordered = List.map2(result, position_map, \char, pos -> { char, pos })
    final_sorted = List.sort_with(reordered, \a, b -> Num.compare(a.pos, b.pos))
    final_chars = List.map(final_sorted, \item -> item.char)
    
    Str.from_utf8(final_chars)

calculate_rail_inline : U64, U64, U64 -> U64
calculate_rail_inline = \idx, rails, cycle ->
    pos = idx % cycle
    if pos < rails then
        pos
    else
        cycle - pos