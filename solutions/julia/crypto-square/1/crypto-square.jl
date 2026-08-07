function ciphertext(plaintext)
    text = replace(lowercase(plaintext), r"[^a-z0-9]" => "")
    r, c = Int(ceil(sqrt(length(text)))), isqrt(length(text))
    c += r*c < length(text)
    matrix = reshape(collect(text * " "^(r*c - length(text))), r, c)
    join(join.(eachrow(matrix)), " ")
end