module [encode, decode]

encode : List U32 -> List U8
encode = |integers|
    List.join_map(integers, encode_one)

encode_one : U32 -> List U8
encode_one = |integer|
    if integer == 0 then
        [0]
    else
        bytes = collect_bytes(integer, [])
        mark_continuation_bits(bytes)

collect_bytes : U32, List U8 -> List U8
collect_bytes = |num, acc|
    if num == 0 then
        acc
    else
        byte = Num.to_u8(Num.bitwise_and(num, 0x7F))
        remaining = Num.shift_right_zf_by(num, 7)
        collect_bytes(remaining, List.prepend(acc, byte))

mark_continuation_bits : List U8 -> List U8
mark_continuation_bits = |bytes|
    len = List.len(bytes)
    List.map_with_index(bytes, |byte, idx|
        if idx < len - 1 then
            Num.bitwise_or(byte, 0x80)
        else
            byte)

decode : List U8 -> Result (List U32) _
decode = |bytes|
    decode_all(bytes, [], 0, Bool.false)

decode_all : List U8, List U32, U32, Bool -> Result (List U32) [IncompleteEncoding]
decode_all = |bytes, results, accumulator, in_progress|
    when bytes is
        [] ->
            if in_progress then
                Err(IncompleteEncoding)
            else
                Ok(results)
        
        [byte, .. as rest] ->
            value = Num.to_u32(Num.bitwise_and(byte, 0x7F))
            new_acc = Num.bitwise_or(Num.shift_left_by(accumulator, 7), value)
            
            if Num.bitwise_and(byte, 0x80) == 0 then
                decode_all(rest, List.append(results, new_acc), 0, Bool.false)
            else
                decode_all(rest, results, new_acc, Bool.true)
                  