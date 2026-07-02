module [rotate]

rotate_in_range : U8, U8, U8 -> U8
rotate_in_range = |byte, base, shift|
    # ((byte - base) + shift) % 26 + base
    offset = byte - base
    rotated_offset = (offset + shift) % 26
    base + rotated_offset

rotate_byte : U8, U8 -> U8
rotate_byte = |byte, shift|
    if byte >= 'a' && byte <= 'z' then
        rotate_in_range(byte, 'a', shift)
    else if byte >= 'A' && byte <= 'Z' then
        rotate_in_range(byte, 'A', shift)
    else
        # non-letters (spaces, digits, punctuation) stay the same
        byte

rotate : Str, U8 -> Str
rotate = |text, shift_key|
    bytes = Str.to_utf8(text)
    shift = shift_key % 26

    rotated_bytes =
        List.map(bytes, |byte| rotate_byte(byte, shift))

    Str.from_utf8_lossy(rotated_bytes)
        