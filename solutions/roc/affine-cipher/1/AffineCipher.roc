module [encode, decode]

encode : Str, { a : U64, b : U64 } -> Result Str [NotCoprime]
encode = |phrase, key|
    if Bool.not(is_coprime(key.a, 26)) then
        Err(NotCoprime)
    else
        phrase
        |> Str.to_utf8
        |> List.keep_if(is_alpha_numeric)
        |> List.map(to_lower)
        |> List.map(|c| encode_char(c, key))
        |> List.chunks_of(5)
        |> List.map(Str.from_utf8)
        |> List.keep_oks(|x| x)
        |> Str.join_with(" ")
        |> |str| if Str.is_empty(str) then Ok("") else Ok(str)

decode : Str, { a : U64, b : U64 } -> Result Str [NotCoprime]
decode = |phrase, key|
    if Bool.not(is_coprime(key.a, 26)) then
        Err(NotCoprime)
    else
        phrase
        |> Str.to_utf8
        |> List.keep_if(is_alpha_numeric)
        |> List.map(to_lower)
        |> List.map(|c| decode_char(c, key))
        |> Str.from_utf8
        |> Result.with_default("")
        |> Ok

encode_char : U8, { a : U64, b : U64 } -> U8
encode_char = |c, key|
    if is_numeric(c) then
        c
    else if is_alpha(c) then
        i = c - 'a'
        e = ((Num.to_u64(i)) * key.a + key.b) % 26
        'a' + (Num.to_u8(e))
    else
        c

decode_char : U8, { a : U64, b : U64 } -> U8
decode_char = |c, key|
    if is_numeric(c) then
        c
    else if is_alpha(c) then
        y = Num.to_u64(c - 'a')
        mmi = modular_multiplicative_inverse(key.a, 26)
        # Ensure we don't overflow by doing modulo operations first
        y_plus_mod = (y + 26) % 26
        b_mod = key.b % 26
        d = (mmi * ((y_plus_mod + 26 - b_mod) % 26)) % 26
        'a' + (Num.to_u8(d))
    else
        c

is_coprime : U64, U64 -> Bool
is_coprime = |a, b|
    gcd(a, b) == 1

gcd : U64, U64 -> U64
gcd = |a, b|
    if b == 0 then
        a
    else
        gcd(b, a % b)

modular_multiplicative_inverse : U64, U64 -> U64
modular_multiplicative_inverse = |a, m|
    walk_extended_gcd(Num.to_i64(a), Num.to_i64(m))
    |> |result|
        (x, _, _) = result
        ((Num.to_u64(((x % (Num.to_i64(m))) + (Num.to_i64(m))))) % m)

walk_extended_gcd : I64, I64 -> (I64, I64, I64)
walk_extended_gcd = |a, b|
    if b == 0 then
        (1, 0, a)
    else
        q = a // b
        r = a % b
        (s, t, g) = walk_extended_gcd(b, r)
        (t, s - q * t, g)

is_alpha_numeric : U8 -> Bool
is_alpha_numeric = |c|
    is_alpha(to_lower(c)) || is_numeric(c)

is_alpha : U8 -> Bool
is_alpha = |c|
    c >= 'a' && c <= 'z'

is_numeric : U8 -> Bool
is_numeric = |c|
    c >= '0' && c <= '9'

to_lower : U8 -> U8
to_lower = |c|
    if c >= 'A' && c <= 'Z' then
        c + 32
    else
        c